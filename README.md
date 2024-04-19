# FFmpeg-Builds-AT

A BtbN/FFmpeg-Builds fork focusing on Win64 versions with AudioToolbox abilities using wat4ff.

Highlight: -c:a aac_at

This fork drops these parts from its upstream:

* openh264 - leaves libx264.
* kvazaar - leaves libx265
* aom - leaves dav1d, rav1e, and svtav1.

## Setup

Choose either one:

* Install Apple iTunes using the same-bit-as-FFmpeg installer.

* Or, Make a portable folder by extracting files from iTunes.
  Like the way [qaac](https://github.com/nu774/qaac) does.  
  On 64-bit OS, The folder structure ends up like this:
```
  |   ffmpeg.exe
  \-- QTfiles64
      |   ASL.dll
      |   CoreAudioToolbox.dll
      |   CoreFoundation.dll
      |   icudt62.dll
      |   libdispatch.dll
      |   libicuin.dll
      |   libicuuc.dll
      |   objc.dll
```

* Or, highly unrecommended, install iTunes from the Store. By default no other
  software can use DLLs within the app folder. You have to manually grant
  permissions by using something like icacls.
  
## Tips

For movies, use -q to control quality, ranging from 0 to 14, best quality to 
smallest file.

`-q 4` ~ 192 Kbps stereo, very high quality, recommended for most movies.  
`-q 3` ~ 224 Kbps stereo, transparent, use it for opera or live.

For low-res lectures, use `-profile:a 4 -b:a 48k` for HE-AAC at 48 Kbps.

Examples
```
# movie:
ffmpeg -i input.mkv -c:a aac_at -q 4 output.mkv

# lecture for watching on TV:
ffmpeg -i input.mkv -c:a aac_at -profile:a 4 -b:a 64k output.mkv

# lecture for listening in car:
ffmpeg -i input.mkv -map 0:a -c:a aac_at -profile:a 4 -b:a 48k output.m4a

# To get some help
ffmpeg -h encoder=aac_at
```

# +++ Upstream README.md Starts +++
# FFmpeg Static Auto-Builds

Static Windows (x86_64) and Linux (x86_64) Builds of ffmpeg master and latest release branch.

Windows builds are targetting Windows 7 and newer.

Linux builds are targetting RHEL/CentOS 8 (glibc-2.28 + linux-4.18) and anything more recent.

## Auto-Builds

Builds run daily at 12:00 UTC (or GitHubs idea of that time) and are automatically released on success.

**Auto-Builds run ONLY for win64 and linux(arm)64. There are no win32/x86 auto-builds, though you can produce win32 builds yourself following the instructions below.**

### Release Retention Policy

- The last build of each month is kept for two years.
- The last 14 daily builds are kept.
- The special "latest" build floats and provides consistent URLs always pointing to the latest build.

## Package List

For a list of included dependencies check the scripts.d directory.
Every file corresponds to its respective package.

## How to make a build

### Prerequisites

* bash
* docker

### Build Image

* `./makeimage.sh target variant [addin [addin] [addin] ...]`

### Build FFmpeg

* `./build.sh target variant [addin [addin] [addin] ...]`

On success, the resulting zip file will be in the `artifacts` subdir.

### Targets, Variants and Addins

Available targets:
* `win64` (x86_64 Windows)
* `win32` (x86 Windows)
* `linux64` (x86_64 Linux, glibc>=2.28, linux>=4.18)
* `linuxarm64` (arm64 (aarch64) Linux, glibc>=2.28, linux>=4.18)

The linuxarm64 target will not build some dependencies due to lack of arm64 (aarch64) architecture support or cross-compiling restrictions.

* `davs2` and `xavs2`: aarch64 support is broken.
* `libmfx` and `libva`: Library for Intel QSV, so there is no aarch64 support.

Available variants:
* `gpl` Includes all dependencies, even those that require full GPL instead of just LGPL.
* `lgpl` Lacking libraries that are GPL-only. Most prominently libx264 and libx265.
* `nonfree` Includes fdk-aac in addition to all the dependencies of the gpl variant.
* `gpl-shared` Same as gpl, but comes with the libav* family of shared libs instead of pure static executables.
* `lgpl-shared` Same again, but with the lgpl set of dependencies.
* `nonfree-shared` Same again, but with the nonfree set of dependencies.

All of those can be optionally combined with any combination of addins:
* `4.4`/`5.0`/`5.1`/`6.0` to build from the respective release branch instead of master.
* `debug` to not strip debug symbols from the binaries. This increases the output size by about 250MB.
* `lto` build all dependencies and ffmpeg with -flto=auto (HIGHLY EXPERIMENTAL, broken for Windows, sometimes works for Linux)
