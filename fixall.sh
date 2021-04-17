#!/bin/bash

if ! [ -x "$(command -v mkvmerge)" ]; then
  echo 'Error: mkvmerge is not installed.' >&2
  exit 1
fi

if ! [ -x "$(command -v ffmpeg)" ]; then
  echo 'Error: ffmpeg is not installed.' >&2
  exit 1
fi

# Save original Input File Separator
SAVEIFS=$IFS
# Set the temporary IFS for this script
IFS=$(echo -en "\n\b")

# Always restore the original IFS regardless of how the script exits
trap 'IFS=$SAVEIFS' EXIT

# Create a variable containing all .mp4 files found recursively
Files=$(find . -name "*.mp4" -type f)
for f in $Files
do
  # Print out name of the file we're working on
  echo $f
  newFileName="${f%.mp4}"
  # Create temp file containing all videos from original .mp4
  mkvmerge -A -S -o temp.video.mkv "${newFileName}".mp4
  # Create temp file containing all audio and subtitles from original
  mkvmerge -D -o temp.audio.mkv "${newFileName}".mp4
  # Recombine them into a new .mp4 file
  ffmpeg -loglevel 0 -hide_banner -stats -y -i temp.video.mkv -i temp.audio.mkv -c copy -c:s srt -map 0 -map 1 "${newFileName}".mkv
  # Delete temp files used
  rm temp.video.mkv temp.audio.mkv

  # Using globstar to allow the section below to transverse subdirectories as needed
  echo "Activating glostar"
  shopt -s globstar;
  echo $?
  sleep 1;

  # Using ffmpeg to override the original MP4 with the video found in the new/temporary MKV file with the same name
  echo "Converting files to MKV and merging subtitle into the new file"
    for i in **/*.mkv; do
        ffmpeg -i "$i" -y -flags +global_header -movflags faststart -c:v copy -c:a copy "${i%.mkv}.mp4";
    done
  echo $?

  # Deletes the new/temporary MKV that matches an MP4 file with the same name
  echo "Deleting MKV files that match MP4 files"
    for f in **/*.mkv; do
      [ -e "${f%.*}.mp4" ] && echo rm -- "$f" && rm -- "$f"
    done;
  echo $?

done

exit 0
