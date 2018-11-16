import os

dp1 = not os.system('xrandr | grep "DP-1 connected" | grep -v eDP')
dp2 = not os.system('xrandr | grep "DP-2 connected"')

if dp1 or dp2:
    os.system('/home/thomas.royer/.screenlayout/desktop.sh')
else:
    os.system('/home/thomas.royer/.screenlayout/laptop.sh')

