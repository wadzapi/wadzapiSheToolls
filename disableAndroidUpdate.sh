#!/bin/bash
#http://forum.xda-developers.com/showthread.php?t=1431341 (by lexelby)

su
touch /data/app/com.android.vending-1.apk
chattr +i /data/app/com.android.vending-1.apk
