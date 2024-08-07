#!/bin/bash

input_file="$1"
duration=$(ffprobe -v error -show_entries format=duration -of default=noprint_wrappers=1:nokey=1 "$input_file")
quarter_duration=$(awk '{print $1/4}' <<< "$duration")

ffmpeg -i "$input_file" -c copy -ss 0 -t "$quarter_duration" "${input_file%.*}_part1.mp4" \
-c copy -ss "$quarter_duration" -t "$quarter_duration" "${input_file%.*}_part2.mp4" \
-c copy -ss "$(awk '{print $1*2}' <<< "$quarter_duration")" -t "$quarter_duration" "${input_file%.*}_part3.mp4" \
-c copy -ss "$(awk '{print $1*3}' <<< "$quarter_duration")" "${input_file%.*}_part4.mp4"