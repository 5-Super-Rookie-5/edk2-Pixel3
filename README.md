# EDK2 UEFI Firmware For Google Pixel3
Attempt to create a normal EDK2 for Google Pixel3.

Based on zhuowei's port for [Pixel3XL](https://github.com/Pixel3Dev/edk2-pixel3/).

## The Most Important
DO NOT FLASH THIS UEFI FIRMWARE IN YOUR MAIN PHONE !!!

It's very unstable and you may lost your data.

## Status 
 UFS WORK！

 Can boot Linux Arm

 Clock WORK!

 Test ACPI etc. tables added.

 And can load Windows PE.

## Dev Logs



## To-Do
1.Fix fts touchscreen

2.Fix ACPI tables

3.make USB work

## Dependencies

Ubuntu 20.04:

```
sudo apt update
sudo apt upgrade
sudo apt install build-essential uuid-dev iasl git nasm gcc-aarch64-linux-gnu abootimg python3-distutils python3-pil python3-git
```



## Building
1.Clone edk2 and edk2-platforms (Place three directories side by side.)

edk2:
```
commit:3a3713e62cfad00d78bb938b0d9fb1eedaeff314
```

edk2-platforms:
```
commit:cfdc7f907d545b14302295b819ea078bc36c6a40
```


2.Clone this project
```
git clone https://github.com/sunshuyu/edk2-pixel3.git
```

3.Build environment
```
cd edk2-pixel3
```

4.Build this project
```
bash build.sh
```
5.Debug and use
```
fastboot boot boot-blueline.img
```

## Credits

Orther edk2 project [edk2-sdm845](https://github.com/edk2-porting/edk2-sdm845).

SimpleFbDxe screen driver is from imbushuo's [Lumia950XLPkg](https://github.com/WOA-Project/Lumia950XLPkg).

Also thanks [edk2 website](https://github.com/tianocore/tianocore.github.io/wiki/Using-EDK-II-with-Native-GCC#Install_required_software_from_apt).
