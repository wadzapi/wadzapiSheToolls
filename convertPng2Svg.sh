#!/bin/bash
echo "Input arg: ${1}" 
BASEPATH=$(dirname ${1})
IMGNAME=$(basename ${1%.*})
IMGEXT=$(basename ${1#*.})
OUTPPM="./${IMGNAME}.ppm"
OUTSVG="./${IMGNAME}.svg"
#TODO Добавить валидацию аргументов командной строки
printf "\n Начало конвертации файла %s в %s\n" $1 $OUTSVG
#convert imgmagick to ppm
convert ${1} ${OUTPPM}
#potrace -s ${OUTPPM} -o "${OUTSVG}.0"
autotrace -output-file ${OUTSVG} -output-format svg --color-count 4 ${OUTPPM}
