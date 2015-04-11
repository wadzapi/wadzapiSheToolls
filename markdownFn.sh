#!/bin/bash
# Функции-обертки для вызова markdown.pl

#Значения по-умолчанию для агрументов вызова
DEFAULT_SRC_FOLDER="."
DEFAULT_DEST_FOLDER="$(mktemp)"
#Значения, используемые в скриптах
MD_SRC=""
HTML_DEST=""

function initDefault() {
	echo "initDefault"
	if [[ -n $1 ]]; then
		MD_SRC=$1
		if [[ -z $2 ]]; then
			HTML_DEST="out.html"
		else
			HTML_DEST="${2}"
		fi
	else
		echo -en "Первый агрумент должен указывать на исходный файл в формате md.\n Необязательный второй аргумент указывает название скомпилированного html файла.\n"
		exit 1
	fi
}

#Функция нач. инициализации
function initMarkdownFn() {
	# парсим параметры вызова из командной строки
	echo "Парсим параметры вызова из командной строки"
	while $(getopts ":f:t:" opt "${1}"); do
		case $opt in
			f)
echo " - с указанием src файла (-src ${OPTARG})" 
MD_SRC=$OPTARG
;;
t)
echo " - с указанием dest файла (-dest ${OPTARG})" >&2
HTML_DEST=$OPTARG
;;
*)
echo "Вызвано с использованием недопустимого аргумента ${OPTARG}" >&2
initDefault
;;
esac
done
}

#
function markdownFn() {
	#initMarkdownFn $1
	initDefault
	echo markdown ./${MD_SRC} > ./${HTML_DEST}
}


#
function testMarkdownFn() {
	echo "Начало тестов для функции markdownFn"
	testFormat="#Заголовок 1\n Описание подраздела 1.\n\n ##Подзаголовок 2\nОписание подраздела 2.\nСписок 1:\n - пункт 1\n - пункт 2\n\n"
	testArgs=( "testSrc1" "testSrc2" )
	for testArg in "${testArgs[@]}"
	do
		#echo "Тест для markdownFn ${testArg}"
		#echo "Формат вывода: ${testFormat}"
		printf "${testFormat}" > "${testArg}.md"
		markdownFn -f ${testArg} -t ${testArg}.md
		#rm $testArg.md
	done
	echo "Конец тестов для функции markdownFn"
}

#TODO Допилить логи в дебаге, комменты, ф-ция помощи
#testMarkdownFn

alias markdown="markdownFn $@"