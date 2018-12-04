artist=$(playerctl metadata artist)
title=$(playerctl metadata title)

# Advertisement
if [ -z "$artist" ] || [ -z "$title" ]; then
    echo "Pub"

    amixer set Master mute
else
    echo "$artist - $title"

    amixer set Master unmute
    amixer set Headphone unmute
    amixer set Speaker unmute
fi

