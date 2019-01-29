#!/bin/bash

IMAGE=/tmp/image.png

NUMCOMICS=$(curl -sL "http://xkcd.com/info.0.json" | grep -oP '(?<=num": )([^,]*)')
COMIC=404
until [[ "$COMIC" -ne "404" ]]; do
    COMIC=$((1 + RANDOM % $NUMCOMICS))
done

URL=$(curl -sL "http://xkcd.com/$COMIC/info.0.json" | grep -oP '(?<=img": ")([^"]*)' | tr -d '\\')
curl -sL "$URL" -o $IMAGE

convert $IMAGE -gravity center -extent 1920x1080 -channel RGB -negate $IMAGE
montage $IMAGE $IMAGE -tile 2x1 -geometry +0+0 $IMAGE
i3lock -i $IMAGE

