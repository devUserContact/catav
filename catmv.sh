#!/bin/bash

PATH=$(pwd)

catmv() {
  for audioFile in src/audio/* 
    do 
      echo "appending $audioFile to tracklist.txt" 
      echo "file '$PATH/$audioFile'" >> trackList.txt
    done 
}

catmv
