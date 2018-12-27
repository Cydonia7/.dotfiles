killall polybar
# Sed is used to get them in reverse order
for m in $(polybar --list-monitors | cut -d":" -f1 | sed '1!G;h;$!d'); do
    MONITOR=$m polybar --reload example &
done

