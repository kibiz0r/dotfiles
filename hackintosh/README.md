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
sudo mkdir /Volumes/ESP; sudo mount -t msdos /dev/disk0s1 /Volumes/ESP
/Volumes/ESP/EFI/CLOVER/switch_to_internal_config
```
