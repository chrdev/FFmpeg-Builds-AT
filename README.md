# FFmpeg-Builds-AT

![Win64 Releases](https://github.com/chrdev/FFmpeg-Builds-AT/actions/workflows/build.yml/badge.svg)

A FFMpeg build with AudioToolbox for Win64 , based on BtbN/FFmpeg-Builds.

Supports `-c:a aac_at`.  
Get help with `ffmpeg -h encoder=aac_at`

Packages removed from the upstream:  
* openh264 - use libx264.
* kvazaar - use libx265.
* aom - use dav1d, rav1e and svtav1.

## Installation

Choose one method of the two:

* Install Apple iTunes using the official installer. No further steps needed.

* Extract files from iTunes. See
  [QTFiles for qaac](https://github.com/AnimMouse/QTFiles)  
  The folder tree should be like:
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

`-q 0` : the best quality.  
`-q 14` : the smallest file.

`-q 4` : ~192 Kbps stereo, very high quality, recommended for movies.  
`-q 3` : ~224 Kbps stereo, transparent, recommended for music videos.  
`-profile:a 4 -q 9` : ~64 Kbps HE-AAC.  
`-profile:a 4 -b:a 64k` : 64 average-Kbps HE-AAC.

Make a movie  
`ffmpeg -i input.mkv -c:a aac_at -q 4 output.mkv`

Make a lecture  
`ffmpeg -i input.mkv -c:a aac_at -profile:a 4 -q 9 output.mkv`

END fork README

## Upstream README (Some info does NOT apply to this repo)

[BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds)

# FFmpeg Static Auto-Builds

Static Windows (x86_64) and Linux (x86_64) Builds of ffmpeg master and latest release branch.

Windows builds are targetting Windows 7 and newer, provided UCRT is installed.
The minimum supported version is Windows 10 22H2, no guarantees on anything older.

Linux builds are targetting RHEL/CentOS 8 (glibc-2.28 + linux-4.18) and anything more recent.

## Auto-Builds

Builds run daily at 12:00 UTC (or GitHubs idea of that time) and are automatically released on success.

**Auto-Builds run ONLY for win(arm)64 and linux(arm)64. There are no win32/x86 auto-builds, though you can produce win32 builds yourself following the instructions below.**

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
* `4.4`/`5.0`/`5.1`/`6.0`/`6.1`/`7.0`/`7.1`/`8.0`/`8.1`/`9.0` to build from the respective release branch instead of master.
* `debug` to not strip debug symbols from the binaries. This increases the output size by about 250MB.
* `lto` build all dependencies and ffmpeg with -flto=auto (HIGHLY EXPERIMENTAL, broken for Windows, sometimes works for Linux)
