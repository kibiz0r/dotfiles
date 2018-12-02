# BIOS

- Load optimized defaults
- Switch SATA mode to AHCI

# USB Installer

`hackintosh/make_usb_installer`

*Make sure to install Clover to the USB drive, not the main drive!*

- F12 to boot into Install Mojave
- Erase/partition internal drive
- Install normally

# Post-install

```
disks=$(diskutil list | grep /dev/disk | sed 's/\/dev\/\(disk[[:digit:]]\).*/\1/')

cruzer=""

for disk in $disks; do
  if diskutil info $disk | grep "Cruzer Glide" > /dev/null; then
    cruzer=$disk
  fi
done

if [[ -z $cruzer ]]; then
  echo "Couldn't find Cruzer Glide"
  exit 1
fi

echo "Found Cruzer Glide at $cruzer"

diskutil unmount "$cruzer"s1
sudo mkdir /Volumes/ESP-USB
sudo mount -t msdos /dev/"$cruzer"s1 /Volumes/ESP-USB

/Volumes/ESP-USB/EFI/CLOVER/switch_to_internal_config
```

