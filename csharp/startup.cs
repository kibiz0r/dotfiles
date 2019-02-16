using System.Reactive;
using System.Reactive.Linq;
using System.Reactive.Subjects;
using System.Net.Http;
using System.Text.RegularExpressions;

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

