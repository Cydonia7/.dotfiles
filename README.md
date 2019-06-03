To create lock screen image (PNG with several screens):

```
montage background.jpg background.jpg -mode Concatenate -tile x1 lock.png
convert -resize 3840x1080 lock.png lock.png
```
