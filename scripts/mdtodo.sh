#!/bin/sh

path="${HOME}/.local/todo/"
name=work

[ ! -d ${path} ] && mkdir -p ${path}

st nvim ${path}/${name}.md
