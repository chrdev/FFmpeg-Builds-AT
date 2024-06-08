# FFmpeg-Builds-AT

A BtbN/FFmpeg-Builds fork focusing on AudioToolbox/Win64.

Supports`-c:a aac_at` on Windows.

Packages removed from this fork:

* openh264 - left libx264.
* kvazaar - left libx265.
* aom - left dav1d, rav1e and svtav1.

## Installation

Choose either one of the two:

* Install Apple iTunes using the official installer. No further steps needed.

* Extract files from iTunes. Same as
  [QTFiles for qaac](https://github.com/AnimMouse/QTFiles)  
  On x64 OS, The folder tree looks like this:
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

## Tips

`-q 0` gives the best quality, and `-q 14` gives the smallest file.  
Some useful parameters are:  
`-q 4` gives ~192 Kbps stereo, very high quality, recommended for movies.  
`-q 3` gives ~224 Kbps stereo, transparent, use it for opera, live, etc.

For low-res lectures, use `-profile:a 4 -b:a 48k` for HE-AAC at 48 Kbps.

Examples
```
# a movie:
ffmpeg -i input.mkv -c:a aac_at -q 4 output.mkv

# a lecture for watching at home:
ffmpeg -i input.mkv -c:a aac_at -profile:a 4 -b:a 64k output.mkv

# a lecture for listening in-car:
ffmpeg -i input.mkv -map 0:a -c:a aac_at -profile:a 4 -b:a 48k output.m4a

# To get some help
ffmpeg -h encoder=aac_at
```

# BtbN/FFmpeg-Builds README.md

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
