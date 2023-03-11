#!/bin/sh

lua=$(lua -v | awk '{print $1" "$2}')
python=$(python --version)
cc=$(gcc --version | head -1 | awk '{print $1" "$NF}')

#nvim=$(nvim --version | head -1)
bash=$(bash --version | head -1 | awk '{print $2" "$4}' | sed -e 's/,//' -e 's/(.*//')
pandoc=$(pandoc --version | head -1)
groff=$(groff -v | head -1 | awk '{print $2" "$NF}')

printf '%s\n \n' ' ------------------------------------------------'
printf '• %s %s \t• %s %s \t• %s %s\n' ${cc} ${lua} ${python}
printf '• %s %s \t• %s %s \t• %s %s\n' ${bash} ${groff} ${pandoc}

#printf '%s %s - %s %s - %s %s\n' ${nvim} ${pandoc} ${groff}

#printf "$(lua -v)\n$(python --version)\n$(gcc --version | head -1)"
