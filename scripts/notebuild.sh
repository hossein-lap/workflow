#!/bin/sh
set -e

# sent notification {{{
notify() {
	case $2 in
		1)
			mode=low
			;;
		2)
			mode=normal
			;;
		3)
			mode=critical
			;;
		*)
			mode=normal
			;;
	esac

	notify-send -u $mode -a ${script_name} -i stock-notes "${1}"
}
# }}}

## R {{{
#r_build () {
	#a=$( dirname "$1" )
	#i=$( echo "$a" | sed 's/\<md\>/pdf/g' )
	#j=$( echo "$a" | sed 's/\<md\>/html/g' )
#
	#Rscript -e "rmarkdown::render(input = '$1', output_dir = '$i', output_format = 'pdf_document')" 2>&1 > /dev/null
	#Rscript -e "rmarkdown::render(input = '$1', output_dir = '$j', output_format = 'html_document')" 2>&1 > /dev/null
#}
## }}}
## pandoc {{{
#pandoc_build () {
	#i=$( echo "$1" | sed 's/\<md\>/pdf/g' )
	#j=$( echo "$1" | sed 's/\<md\>/html/g' )
#
	##pandoc -t html "$1" -o "$j"
	##pandoc --pdf-engine=$HOME/.local/bin/texlive/bin/x86_64-linux/pdflatex -V geometry:margin=1in "$1" -o "$i"
	#pandoc -t ms "$1" -o "$i"
#}
## }}}
# Groff {{{
groff_build() {
	i=$(echo "$1" | sed 's/\<ms\>/pdf/g')
	groff -mspdf -Tpdf "${1}" > "${i}"
}
# }}}

# Groff
groff_build "$1"

## using pandoc
#pandoc_build "$1"

## usging R
#r_build "$1"

if [ -z $? ]; then
	notify "Note build successfully"
	exit 0
fi
