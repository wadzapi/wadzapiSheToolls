#/bin/bash

# vars
DELIM="      ----------- "
DEFAULT_LOGPATH="/var/log/not_specified_logName.log"
LOG_LEVEL=0
SCRIPT_NAME=${BASH_SOURCE[0]}
MYLOG=$SCRIPT_NAME.log

# Функция вывода в 
function debugLog {
    echo "Cmd defined as " $(fc -l -1) "  executed."
}

# Функция вывода строки в логфайл, использует либо вызов с 2 аргументами,
# $1 - название лога (в текущем каталоге), $2 ... $n - n -1 cтрок для вывода в файл; 
# либо через pipe input с пробелом в качестве разделителя между 2-мя аргументами
# Пример использования: appendLog "LogFileName" "LogString1" ... "LogStringN" или же: 
# echo "-logfile LogFileName LogString1 ... LogStringN" | appendLog
function appendLog {
    # Set log filename
    LOGFILE=$DEFAULT_LOGPATH
    if [ -z "$1" ] && [ -f $1 ]; then
        LOGFILE=$1
    else
        log "No logFileNameDefined, using default: " $DEFAULT_LOGPATH 
    fi
    # Append string if not empty
    LogStrings=${@:2:$(expr $# - 1)}
    StringsLen=${#LogStrings[@]}
    if [[ $StringsLen -eq 0 ]]; then
        log "No output string was received"
    else
        echo $StringsLen " should be appended." 
        for logStr in $LogStrings
        do
            log "Appended " $logStr " to log file: " $LOGFILE "."
            printf "%s $logStr\n" >> $LOGFILE
        done
    fi
}

# Функция вывода на стд. вывод (консоль) сообщений в режиме отладки
# , если $LOG_LEVEL=1, иначе ничего не выполняет.
function log {
    if [[ $LOG_LEVEL -eq 1 ]]; then
        echo "$@"
    fi
}

# Функция выводит строку таймстампа, 
# формата : DELIM TIMESTAMP reversed DELIM
function printTime {
    printf "\n\n%s%s%s\n" $DELIM `date -R` `echo $DELIM | rev`
}
