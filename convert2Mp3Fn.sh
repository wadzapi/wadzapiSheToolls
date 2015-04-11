#!/bin/bash
#
INPUT_DIR=""
OUT_DIR=""
MP3EXT="mp3"
WAVEXT="wav"
ERR_BASE_MSG="ОШИБКА:"
INPUT_PATH=""

#metatags
ARTIST=""
TITLE=""
ALBUM=""
GENRE=""
TRACKNUMBER=""
DATE=""

RENAME_MODE="false"
TRANSLITERATE_MODE="false"


SAVEIFS=""


#Функция нач. инициализации
function initConvertWavMp3Fn() {
	# парсим параметры вызова из командной строки
	echo "Парсим параметры вызова из командной строки"
	while getopts ":a:" opt; do
	  case $opt in
	    inputDir)
			#TODO Добавить сохр $INPUT_DIR
			INPUT_DIR=${OPTARG}
	      ;;
	    outputDir)
			#TODO Добавить сохр $OUT_DIR
			OUT_DIR=${OPTARG}
	      ;;
	    \?)
	      echo "Указана недопустимая опция: -$OPTARG" >&2
	      exit 1
	      ;;
	    :)
	      echo "Вызвано без агрументов." >&2
	      # инициализация по-умолчанию
				INPUT_DIR="."
				OUT_DIR=$(mktemp -d)
				echo "По умолчанию входная директория установлена как: ${INPUT_DIR}"
	      		echo "По умолчанию выходная директория установлена как: ${OUT_DIR}"
	      ;;
	  esac
	done
}

function extractMeta() {
	rawFName="${1}.${2}"
	extractMetaMsg="извлечения метаинформации из файла ${rawFName}"
	echo "Начало ${extractMetaMsg}"
	case ${2} in
		flac)
			ARTIST=$(metaflac "${rawFName}" --show-tag=ARTIST | sed s/.*=//g)
  			TITLE=$(metaflac "${rawFName}" --show-tag=TITLE | sed s/.*=//g)
			ALBUM=$(metaflac "${rawFName}" --show-tag=ALBUM | sed s/.*=//g)
			GENRE=$(metaflac "${rawFName}" --show-tag=GENRE | sed s/.*=//g)
			TRACKNUMBER=$(metaflac "${rawFName}" --show-tag=TRACKNUMBER | sed s/.*=//g)
			DATE=$(metaflac "${rawFName}" --show-tag=DATE | sed s/.*=//g)
			;;
		*)
			echo "Отстуствует метаинформация о файле ${rawFName}"
			;;
	esac
	echo "Конец ${extractMetaMsg}"
}

function tryRename() {
	renameMsg="переименования исходного файла ${1}"
	echo "Начало ${renameMsg}"
	newName=$(echo '${1}' | tr -s  [:blank:] '-')
	echo "Конец ${renameMsg}. Файл ${1} переименован в ${newName}"
}

function tryDecode() {
	decodeMsg="попытки декодирования ${INPUT_PATH}"
	echo "Начало ${decodeMsg}"
	rawFName="${1}.${2}"
	tryRename ${rawFName}
	case ${2} in
		ogg)
			oggdec ${rawFName}
			;;
		wv)
			wvunpack ${rawFName}
			;;
		flac)
			flac -d ${rawFName}
			;;
		*)
			echo "Файл \"${1}\" с недопустимым расширением \"${2}\" пропущен"
			;;
	esac
	echo "Конец ${decodeMsg}"
}


function tryContvert2Mp3() {
	CVRT_MSG="конвертации ${1}.${2} в ${1}.${MP3EXT}"
	echo "Попытка начала ${CVRT_MSG}"
	INPUT_PATH="${INPUT_DIR}/${1}.${2}"
	OUT_PATH="${OUT_DIR}/${1}.${MP3EXT}"
	case ${2} in
		${WAVEXT})
			echo "Файл ${WAVEXT}. Начало ${CVRT_MSG}"
			lame -V0 -h -b 160 --vbr-new ${INPUT_PATH} ${OUT_PATH}
			#lame -V0 --add-id3v2 --pad-id3v2 --ignore-tag-errors --ta "$ARTIST" --tt "$TITLE" --tl "$ALBUM"  --tg "${GENRE:-12}" --tn "${TRACKNUMBER:-0}" --ty "$DATE"
			echo "Конец ${CVRT_MSG}"
			;;
		:)
			echo "${ERR_BASE_MSG} Невозможно идентифицировать - передан файл без расширения!"
			exit 1
			;;
		*)
			echo "Файл в формате ${2}, отличном от ${WAVEXT}."
			extractMeta $1 $2
			tryDecode $1 $2
			if [[ -f "$1.${WAVEXT}" ]]; then
				echo "Найден декодированный в ${WAVEXT} файл"
				tryContvert2Mp3 $1 ${WAVEXT}
			else
				echo "${ERR_BASE_MSG} Не найден декодированный в ${WAVEXT} файл"
			fi
			;;
	esac
	echo "Конец успешной попытки ${CVRT_MSG}"
}

function defaultInitFn() {
	defaultInitMsg="инициализации по-умолчанию"
	echo "Начало ${defaultInitMsg}"
	INPUT_DIR="."
	OUT_DIR=$(mktemp -d)
	SAVEIFS=$IFS
	IFS=$(echo -en "\n\b")
	echo "Конец ${defaultInitMsg}"
}

function convert2Mp3Fn() {
	#initConvertWavMp3Fn $1 $2
	defaultInitFn $@
	mainLogMsg="выполнения скрипта из ${INPUT_DIR} в папку ${OUT_DIR}"
	echo "Начало ${mainLogMsg}"
	for sndFile in ${INPUT_DIR}/*
	do
		if [[ -f ${sndFile} ]]; then
			fName=$(basename "$sndFile")
			fExt="${fName##*.}"
			fName="${fName%.*}"
			tryContvert2Mp3 ${fName} ${fExt}
		fi
	done
	defaultAfterFn $@
	echo "Конец ${mainLogMsg}"
}

function defaultAfterFn() {
	defaultAfterMsg="пост-обработки по-умолчанию"
	echo "Начало ${defaultAfterMsg}"
	IFS=$SAVEIFS
	echo "Конец ${defaultAfterMsg}"
}