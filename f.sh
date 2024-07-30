#!/bin/bash

sed "s/[' ']//g" <<< "$1"
input_file="$1"
duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_file")
half_duration=$(awk '{print $1/2}' <<< "$duration")

ffmpeg -i "$input_file" -c copy -ss 0 -t "$half_duration" "${input_file%.*}_part1.mp4" \
-c copy -ss "$half_duration" "${input_file%.*}_part2.mp4"
