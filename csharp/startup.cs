using System.Globalization;
using System.Net.Http;
using System.Reactive;
using System.Reactive.Concurrency;
using System.Reactive.Disposables;
using System.Reactive.Linq;
using System.Reactive.Subjects;
using System.Reactive.Threading.Tasks;
using System.Reflection;
using System.Security.Cryptography;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using Newtonsoft.Json;
using System.IO;
using YamlDotNet.Serialization;

public static class EqualityComparer
{
    private class FuncComparer<T> : IEqualityComparer<T>
    {
        private Func<T, T, bool> _comparer;

        public FuncComparer(Func<T, T, bool> comparer)
        {
            _comparer = comparer;
        }

        public bool Equals(T x, T y)
        {
            return _comparer(x, y);
        }

        public int GetHashCode(T obj)
        {
            return obj.GetHashCode();
        }
    }

    public static IEqualityComparer<T> Create<T>(Func<T, T, bool> comparer)
    {
        return new FuncComparer<T>(comparer);
    }
}

public sealed class ThrottleFirstObservable<T> : IObservable<T>
{
    private readonly IObservable<T> source;

    private readonly IScheduler timeSource;

    private readonly TimeSpan timespan;

    public ThrottleFirstObservable(IObservable<T> source,
              IScheduler timeSource, TimeSpan timespan)
    {
        this.source = source;
        this.timeSource = timeSource;
        this.timespan = timespan;
    }

    public IDisposable Subscribe(IObserver<T> observer)
    {
        var parent = new ThrottleFirstObserver(observer, timeSource, timespan);
        var d = source.Subscribe(parent);
        parent.OnSubscribe(d);
        var cd = new CompositeDisposable(new [] { d, parent });
        return cd;
    }

    public sealed class ThrottleFirstObserver : IDisposable, IObserver<T>
    {
        private readonly IObserver<T> downstream;

        private readonly IScheduler timeSource;

        private readonly TimeSpan timespan;

        private IDisposable upstream;

        private IDisposable scheduled;

        private bool completed;

        private bool waitingToComplete;
        private Exception[] waitingToError;

        private bool once;

        private DateTimeOffset due;

        private T[] queued = new T[0];

        public ThrottleFirstObserver(IObserver<T> downstream,
                IScheduler timeSource, TimeSpan timespan)
        {
            this.downstream = downstream;
            this.timeSource = timeSource;
            this.timespan = timespan;
        }

        public void OnSubscribe(IDisposable d)
        {
            if (Interlocked.CompareExchange(ref upstream, d, null) != null)
            {
                d.Dispose();
            }
        }

        public void Dispose()
        {
            completed = true;
            var d = Interlocked.Exchange(ref upstream, this);
            if (d != null && d != this)
            {
                d.Dispose();
            }
        }

        public void OnCompleted()
        {
            if (scheduled != null)
            {
                waitingToComplete = true;
            }
            else
            {
                completed = true;
                downstream.OnCompleted();
            }
        }

        public void OnError(Exception error)
        {
            if (scheduled != null)
            {
                waitingToError = new Exception[] { error };
            }
            else
            {
                completed = true;
                downstream.OnError(error);
            }
        }

        public void OnNext(T value)
        {
            if (completed)
            {
                return;
            }
            var now = timeSource.Now;
            if (!once)
            {
                once = true;
                due = now + timespan;
                downstream.OnNext(value);
                if (waitingToComplete)
                {
                    downstream.OnCompleted();
                }
                else if (waitingToError != null)
                {
                    downstream.OnError(waitingToError[0]);
                }
            }
            else if (now >= due)
            {
                queued = new T[0];
                due = now + timespan;
                downstream.OnNext(value);
                if (waitingToComplete)
                {
                    downstream.OnCompleted();
                }
                else if (waitingToError != null)
                {
                    downstream.OnError(waitingToError[0]);
                }
            }
            else
            {
                queued = new T[] { value };
                if (scheduled == null)
                {
                    var timeToWait = due - now;
                    scheduled = timeSource.Schedule(timeToWait, () =>
                    {
                        if (completed)
                        {
                            return;
                        }
                        scheduled = null;
                        var q = queued;
                        if (q.Length == 1)
                        {
                            queued = new T[0];
                            var newNow = timeSource.Now;
                            due = newNow + timespan;
                            downstream.OnNext(q[0]);
                            if (waitingToComplete && !completed)
                            {
                                completed = true;
                                downstream.OnCompleted();
                            }
                            else if (waitingToError != null && !completed)
                            {
                                completed = true;
                                downstream.OnError(waitingToError[0]);
                            }
                        }
                    });
                }
            }
        }
    }
}

public static class ObservableExtensions
{
    public static IObservable<T> ThrottleFirst<T>(this IObservable<T> source,
            TimeSpan timespan, IScheduler timeSource = null)
    {
        return new ThrottleFirstObservable<T>(source, timeSource ?? Scheduler.Default, timespan);
    }

    public static IObservable<bool> WhereTrue(this IObservable<bool> src)
    {
        return src.Where(v => v);
    }

    public static IObservable<bool> WhereFalse(this IObservable<bool> src)
    {
        return src.Where(v => !v);
    }

    public static IObservable<T> WhereNotNull<T>(this IObservable<T> src) where T : class
    {
        return src.Where(v => v != null);
    }

    public static IObservable<Unit> ToUnit<T>(this IObservable<T> src)
    {
        return src.Select(_ => Unit.Default);
    }

    // // https://github.com/Reactive-Extensions/Rx.NET/issues/395#issuecomment-296172872
    // public static IObservable<T> ThrottleFirst<T>(this IObservable<T> source, TimeSpan delay, IScheduler scheduler)
    // {
    //     return source.Publish(o => o
    //         .Take(1)
    //         .Concat(o.IgnoreElements().TakeUntil(Observable.Return(default(T)).Delay(delay, scheduler)))
    //         .Repeat()
    //         .TakeUntil(o.IgnoreElements().Concat(Observable.Return(default(T)))));
    // }

    // // https://github.com/Reactive-Extensions/Rx.NET/issues/395#issuecomment-296172872
    // public static IObservable<T> ThrottleFirst<T>(this IObservable<T> source, TimeSpan delay)
    // {
    //     return source.Publish(o => o
    //         .Take(1)
    //         .Concat(o.IgnoreElements().TakeUntil(Observable.Return(default(T)).Delay(delay)))
    //         .Repeat()
    //         .TakeUntil(o.IgnoreElements().Concat(Observable.Return(default(T)))));
    // }

    // https://stackoverflow.com/a/32137966/4592309
    public static IObservable<Tuple<T, T>> CombineWithPrevious<T>(
        this IObservable<T> source,
        T initialValue = default(T))
    {
        var seed = Tuple.Create(initialValue, initialValue);

        return source.Scan(seed,
            (acc, current) => Tuple.Create(acc.Item2, current));
    }
}