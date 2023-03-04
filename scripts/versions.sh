#!/bin/sh

lua=$(lua -v | awk '{print $1" "$2}')
python=$(python --version)
cc=$(gcc --version | head -1 | awk '{print $1" "$NF}')

nvim=$(nvim --version | head -1)
pandoc=$(pandoc --version | head -1)
groff=$(groff -v | head -1 | awk '{print $2" "$NF}')

printf '%s %s - %s %s - %s %s\n' ${lua} ${python} ${cc}
echo ' '
printf '%s %s - %s %s - %s %s\n' ${nvim} ${pandoc} ${groff}
echo ' '
#printf '%s %s - %s %s - %s %s\n' ${nvim} ${pandoc} ${groff}

#printf "$(lua -v)\n$(python --version)\n$(gcc --version | head -1)"
