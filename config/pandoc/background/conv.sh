#  _  _ ___    
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              

#!/bin/sh
set -e

FILES=$(ls *.png)

for File in $FILES
do
    convert $File $(printf '%s\n' "$File" | sed 's/png/jpg/' )
done

mkdir -p png
mv -iv *.png png/
