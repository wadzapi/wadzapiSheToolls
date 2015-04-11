#!/bin/bash
# Функции для задания алиасов в bash_profile

#Значения по-умолчанию для агрументов вызова
DEFAULT_FNAME="notes"
DEFAULT_SEP="_"
DATE_SEP="-"


#Значения, используемые в скриптах
TOUCH_FNAME=""
TOUCH_FEXT=""


#Функция нач. инициализации
function initTouchStampFn() {
	# парсим параметры вызова из командной строки
	echo "парсим параметры вызова из командной строки"
	while getopts ":a:" opt; do
	  case $opt in
	    fext)
	      echo "вызов с -fext $OPTARG" >&2
	     	case $OPTARG in
	      		html)
							TOUCH_FNAME="htmlPage"
	      			TOUCH_FEXT="html"
	      			;;
	      		format | md )
	      			TOUCH_FNAME="note"
	      			TOUCH_FEXT="md"
	      			;;
				esac
	      ;;
	    \?)
	      echo "Invalid option: -$OPTARG" >&2
	      exit 1
	      ;;
	    :)
	      echo "Вызвано без агрументов." >&2
	      # инициализация по-умолчанию
				TOUCH_FNAME=$DEFAULT_FNAME
				TOUCH_FEXT=$DEFAULT_FNAME
	      ;;
	  esac
	done
}


#
function touchStampFn() {
	initTouchStampFn $1
	fName="$TOUCH_FNAME"
	if [[ -n $1 ]]; then
		#
		fName=$(basename "$1")
		fExt="${fName##*.}"
		fName="${fName%.*}"
		#
		if [[ $fName != $fExt ]]; then
			touch "${fName}${DEFAULT_SEP}$(date +%d${DATE_SEP}%m${DATE_SEP}%y).${fExt}"
		else
			touch "${fName}${DEFAULT_SEP}$(date +%d${DATE_SEP}%m${DATE_SEP}%y)"
		fi
	else
		touch "${TOUCH_FNAME}${DEFAULT_SEP}$(date '+%d-%m-%y')"
	fi
}

#
function testTouchStampFn() {
	echo "Начало тестов для функции touchStampFn"
	testArgs=( "3" "3.js" "3." "." "" )
	for testArg in "${testArgs[@]}"
	do
		echo "Тест для touchStampFn ${testArg}"
		touchStampFn $testArg
	done
	echo "Конец тестов для функции touchStampFn"
}

#TODO Допилить логи в дебаге, комменты, ф-ция помощи
#testTouchStampFn

alias touchStamp="touchStampFn"