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

# Upstream Page

[BtbN/FFmpeg-Builds](https://github.com/BtbN/FFmpeg-Builds)
