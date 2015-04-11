#!/bin/bash
DEFAULT_PATH="."

function dotItFn() {
    INPUT=${DEFAULT_PATH}/$1
    OUTPUT=${DEFAULT_PATH}/$1.png
    dot -Tpng ${INPUT} -o ${OUTPUT}
}

alias dotIt="dotItFn ${1}"