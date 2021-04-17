# MKVToolNix-missing-ctts-atom-repair
Scripts to add the missing ctts atom to MP4 files created using MKVToolNix prior to version 45.

# Purpose of this script

MKVToolNix prior to version 45 failed to make a ctts atom which created a shuddering effect for mp4 files made from mkvs assembled using MKVToolNix.
More technical information can be found here:

https://gitlab.com/mbunkus/mkvtoolnix/-/issues/2777#note_315725406

The bash scripts listed in this repo are designed to "repair" the mp4 files by creating a temporary mkv file, using ffmpeg to override the original mp4 file, and than deleting the temporary mkv file.

# THESE SCRIPTS ARE DESTRUCTIVE

All of these scripts are designed to override the original mp4 files. This is a warning that no warranty exists, implied or expressed. It is very much a possibility that a loss of data may occur. These scripts are being shared "AS IS."

These scripts are also known to potentially offset subtitles from previous mp4 files that lacked a ctts atom.

# Requirements

This script was tested on Ubuntu 20.04 and should work using the default package manager APT install packages that come with Ubuntu 20.04 and newer.

The scripts also require bash 4.0+, which mostly affect MacOS users. To use these scripts on the MacOS a user will need to add/upgrade your bash install a version 4.0 or newer.

-atomicparsley (for manually checking for the presence of a ctts atom)

-MKVToolNix 45 or newer (needed to create the new/temporary mkv files with a ctts atom present)

-ffmpeg (used to create the new/temporary mkv files and to later extract the videos files and putting them into a new mp4 file with a ctts atom)

-bash 4.0+ (older versions of bash lack glostar, making transversing subdirectories more difficult)

# Ubuntu 20.04 and likely newer install instructions.

As always, make sure `apt-get` is up-to-date. `sudo apt-get update`

Atomicparsley, apt install.

```sudo apt-get install atomicparsley```

MKVToolNix, apt install.

```sudo apt-get install mkvtoolnix```

FFmpeg, apt install.

```sudo apt-get install ffmpeg```

Ubuntu 20.04 comes with bash version 5.0.17 or newer. This version of bash works by default with these scripts. MacOS users will need to upgrade/secondary install bash 4.0 or newer.

# Usage

If wanting to check if an individual file has a ctts atom, you can use atomicparsley to verify the file has the ctts atom.

```AtomicParsley <input.mp4> -T 1 | grep ctts```

If the file does not contain a ctts atom, move `fixall.sh` into the folder of the file you want to repair. It is important to note the script will repair any .mp4 file in the same directory or sub directory of the bash script.

To run the script, run the script by specifying the bash script is a bash script.

```bash fixall.sh```

As RARBG files have been brought as files that have been affected by the MKVToolNix/ctts atom issue, two scripts have been added that will attempt to repair all RARBG x265 files based on the RARBG naming convenction. If placed and run in the root of a media folder, the script will attempt to repair/replace the ctts in all RARBG files, if the files are still using the RARBG naming convention.

This will fix/repair mp4 files using the `x265-RARBG` naming convention:

```bash fix-x265-RARBG.sh```

This will fix/repair mp4 files using the `x265-VXT` naming convention:

```bash fix-x265-VXT.sh```


A big thank you to lightmaster, `_incorrect`, and everyone else over at the Plex Thread that put together the info that helped me to put together a bash workable script for repairing HEVC mp4 files with a broken ctts atom. https://forums.plex.tv/t/example-of-stuttering-hevc-playback-on-apple-tv-4k/558255
