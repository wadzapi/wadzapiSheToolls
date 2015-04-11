#!/bin/bash

ROOT_LINK=""


echo "wget \
     --recursive \
     --page-requisites \
     --convert-links \
     --random-wait \
     --limit-rate=200k \
     --verbose \
     --local-encoding=UTF-8 \
     --tries=10 \
     --no-parent \
     --user-agent='Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Firefox/31.0' \
         ${ROOT_LINK}"


wget \
     --recursive \
     --page-requisites \
     --convert-links \
     --random-wait \
     --limit-rate=200k \
     --verbose \
     --local-encoding=UTF-8 \
     --tries=10 \
     --no-parent \
     --user-agent="Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Firefox/31.0" \
         $ROOT_LINK
     #--no-clobber \
   # --accept "jpg,jpeg,html,js,css,php,png,svg,htm,," \
     #--progress=bar \
     #--continue \
     #--remote-encoding=UTF-8 \
     #--restrict-file-names=windows \
     #--level=8 \
     #--max-redirect=0 \
     #--html-extension \
     #--domains mozilla.org \
     #--no-host-directories \
