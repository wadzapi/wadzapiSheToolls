#!/bin/bash
#Скрипт для переключения между раскладками (en <--> dvorak-en) 
#loadkeys /usr/lib/kbd/keymaps/i386/dvorak/dvorak.map.gz
#loadkeys /usr/lib/kbd/keymaps/i386/qwerty/us.map.gz
DEFAULT_KEYMAP="us"
KEYMAPS_BASEDIR="/usr/lib/kbd/keymaps/i386"
KEYMAP_EXT="map.gz"
KEYMAPS=( "dvorak/dvorak" "qwerty/us" )
DEBUG_MODE="false"
STATE_DIR="/tmp/keymaps"
STATE_FILE="currKeymap"
CURR_KEYMAP=$DEFAULT_KEYMAP

#function initDebugEnv() {
#    if [[ $1 == "debug" ]]; then
#        echo "   [ ----------- DEBUG ----------- ]   "
#        echo
#        echo "Debug mode in script ${0} enabled"
#        DEBUG_MODE="true"
#    fi
#}

function debugLogger() {
    if [[ $DEBUG_MODE == "true" ]];then
        echo "${1}";fi
}

function handleKeymapState() {
    debugLogger "handleKeymapState called."
    case $1 in
        load)
            debugLogger "Load keymap state called"
            CURR_KEYMAP=$(cat "${STATE_DIR}/${STATE_FILE}")
            debugLogger "Keymap state was loaded to var CURR_KEYMAP(=${CURR_KEYMAP}) from ${STATE_DIR}/${STATE_FILE} statefile"
            ;;
        save)
            debugLogger "Save keymap state called"
            echo ${CURR_KEYMAP} > "${STATE_DIR}/${STATE_FILE}"
            debugLogger "Save keymap state called. Value of CURR_KEYMAP(=${CURR_KEYMAP}) was written to ${STATE_DIR}/${STATE_FILE}"
            ;;
    esac
    debugLogger "Now env var CURR_KEYMAP=${CURR_KEYMAP}"
    debugLogger "handleKeymapState exit."
}

function switchDvorakRu() {
    debugLogger "switchDvorakRu called."
    handleKeymapState load
    case $CURR_KEYMAP in
        us)
            debugLogger "Switch layout from ${CURR_KEYMAP} to dvorak"
            CURR_KEYMAP="dvorak"
            debugLogger "called loadkeys ${KEYMAPS_BASEDIR}/${KEYMAPS[0]}.${KEYMAP_EXT}"
            loadkeys "${KEYMAPS_BASEDIR}/${KEYMAPS[0]}.${KEYMAP_EXT}"
            ;;
        dvorak)
            debugLogger "Switch layout from ${CURR_KEYMAP} to us"
            CURR_KEYMAP="us"
            debugLogger "called loadkeys ${KEYMAPS_BASEDIR}/${KEYMAPS[1]}.${KEYMAP_EXT}"
            loadkeys "${KEYMAPS_BASEDIR}/${KEYMAPS[1]}.${KEYMAP_EXT}"
            ;;
        *)
            debugLogger "Unsupported layout ${CURR_KEYMAP}"
            exit 1
            ;;
    esac
    handleKeymapState save
    debugLogger "switchDvorakRu exit."
}

function initKeymapState() {
    debugLogger "initKeymapState called with arg $1"
    if [[ ! -d "${STATE_DIR}" ]]; then 
        mkdir ${STATE_DIR}
        echo $DEFAULT_KEYMAP > ${STATE_DIR}/${STATE_FILE}
        debugLogger "State saving folder created in ${STATE_DIR} with file ${STATE_FILE}"
    fi
    if [[ ! -f "${STATE_DIR}" ]]; then 
        touch ${STATE_DIR}/${STATE_FILE}
        debugLogger "State saving file created in ${STATE_DIR}/${STATE_FILE}"
    fi
    handleKeymapState load
    debugLogger "env var CURR_KEYMAP=${CURR_KEYMAP}"
    debugLogger "initKeymapState exit"
}


function initSwitchDvorakRu() {
    #initDebugEnv $1
    debugLogger "initSwitchDvorakRu called with arg $1"
    initKeymapState
    debugLogger "env var CURR_KEYMAP=${CURR_KEYMAP}"
    debugLogger "initSwitchDvorakRu exit"
    debugLogger ""
    debugLogger "   [ -----------   END  ----------- ]   "



}

#debugLogger "Main script switchDvorakRu start"
initSwitchDvorakRu $1
#switchDvorakRu
#debugLogger "Main script switchDvorakRu end"
alias dvorakSwitch="switchDvorakRu"
alias dvorakSwitch="sudo switchDvorakRu"
alias asdf="loadkeys /usr/lib/kbd/keymaps/i386/qwerty/us.map.gz"
alias aoeu="loadkeys /usr/lib/kbd/keymaps/i386/dvorak/dvorak.map.gz"