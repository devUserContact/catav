#!/bin/bash

PATH=$(pwd)

PATH_FF='/opt/homebrew/bin'
PATH_VIDEO='src/video'
PATH_AUDIO='src/audio/playlist.mp3'

catav() {

  for audioFile in src/audio/* 
    do 
      echo "appending $audioFile to tracklist.txt" 
      echo "file '$audioFile'" >> trackList.txt
    done 

  $PATH_FF/ffmpeg -f concat -i tracklist.txt -c copy $PATH_AUDIO

  rm tracklist.txt
  
  $PATH_FF/ffmpeg -i $PATH_VIDEO/test.mkv -i $PATH_AUDIO -c copy -map 0:v:0 -map 1:a:0  $PATH_VIDEO/output.mkv

  $PATH_FF/ffmpeg -v quiet -stats -i $PATH_AUDIO -f null - 2> playlistDuration.txt 
  duration=$(/usr/bin/sed -n 's/.*time=\([0-9:.]*\).*/\1/p' playlistDuration.txt)

  $PATH_FF/ffmpeg -ss 00:00 -i $PATH_VIDEO/output.mkv -t "$duration" -map 0 -c copy out/final.mkv

}

catav
