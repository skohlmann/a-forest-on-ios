#!/bin/bash

iconsSizes=(1024 512 256 180 167 152 128 120 87 80 76 64 60 58 40 32 29 20 16)

for iconSize in ${iconsSizes[@]}; do
    convert ${1}.png -quality 100 -resize ${iconSize}x${iconSize} ${1}-${iconSize}.png

    type pngquant
    if [ ${?} -eq 0 ];then
        pngquant --strip --force --quality 4 --output ${1}-${iconSize}.png ${1}-${iconSize}.png
    fi
    
    type zopflipng
    if [ ${?} -eq 0 ];then
        zopflipng --iterations=15 -y ${1}-${iconSize}.png ${1}-${iconSize}.png
    fi
done
