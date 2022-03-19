#!/bin/bash


for file in list/*
do
    if [[ -f "$file" ]]; then
        country=$(basename "$file" .jpg)
        mkdir "flags/$country"
        index=0
        for color in $(convert "$file" -colorspace RGB -format %c histogram:info:- | sort -nr | head -n3 | sort -n | awk '{ print $NF }')
        do
            convert "$file" -fill white -fuzz 18% +opaque "$color" "flags/$country/$index.jpg"
            (( index++ ))
        done

        convert "$file" -colorspace Gray -edge 1 "flags/$country/$index.jpg"
        (( index++ ))
        convert "$file" -colorspace Gray "flags/$country/$index.jpg"
        (( index++ ))
        cp "$file" "flags/$country/$index.jpg"
    fi
done


