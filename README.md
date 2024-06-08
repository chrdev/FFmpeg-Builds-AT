# FFmpeg-Builds-AT

A Win64 FFMpeg build with AudioToolbox, based on BtbN/FFmpeg-Builds.

Supports `-c:a aac_at`.
See help via `ffmpeg -h encoder=aac_at`

This build removes some packages from the upstream:

* openh264 - use libx264.
* kvazaar - use libx265.
* aom - use dav1d, rav1e and svtav1.

## Installation

Choose one from the following two methods:

* Install Apple iTunes using the official installer. No further steps needed.

* Extract files from iTunes. See
  [QTFiles for qaac](https://github.com/AnimMouse/QTFiles)  
  The folder tree should be like this:
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

Some useful parameters:  
`-q 4` gives ~192 Kbps stereo, very high quality, recommended for movies.  
`-q 3` gives ~224 Kbps stereo, transparent, recommended for music videos.  
`-profile:a 4 -q 9` gives ~48 Kbps HE-AAC.  
`-profile:a 4 -b:a 64k` gives 64-average Kbps HE-AAC.

## Examples

Make a movie
`ffmpeg -i input.mkv -c:a aac_at -q 4 output.mkv`

Make a lecture
`ffmpeg -i input.mkv -c:a aac_at -profile:a 4 -q 9 output.mkv`

# Upstream README

[BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds)
