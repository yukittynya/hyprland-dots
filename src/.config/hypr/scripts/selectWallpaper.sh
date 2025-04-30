#!/usr/bin/bash

if [ "$#" -ne 1 ]; then 
  echo "Usage: $0 path/to/wallpaper"
  exit 1
fi

swww img $1
wallust run $1
swaync-client -rs
