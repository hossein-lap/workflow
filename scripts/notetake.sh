#!/bin/sh
set -e

dircheck() {
	[ ! -d "${1}" ] && mkdir -p "${1}"
}

## Markdown {{{
#note_take_markdown() {
	#dirname=doc
	#TheDate=$(date +%Y-%m-%d)
#
	#dircheck "~/${dirname}/notes/"
	#dircheck "~/${dirname}/notes/md/"
	#dircheck "~/${dirname}/notes/pdf/"
	##dircheck "~/${dirname}/notes/html/"
#
	#NoteFilename="${HOME}/${dirname}/notes/md/note_${TheDate}.md"
#
	#if [ ! -f "${NoteFilename}" ]; then
#
		##printf '%s\n'\
			##".SH" ".LG" ".LG" \
			##"Note for ${TheDate}" \
			##> "${NoteFilename}"
#
		#printf '%s\n' "# Note for ${TheDate}" > "${NoteFilename}"
	#fi
#
	#vim -c "norm Go" \
		#-c "norm Go## $(date +%H:%M)" \
		#-c "norm Go" \
		#-c "norm Go" \
		#-c "norm zz" "${NoteFilename}"
#}
## }}}
# Groff {{{
note_take_groff() {
	dirname=doc
	TheDate=$(date +%Y-%m-%d)

	if [ ! -d "${HOME}/${dirname}/notes/" ]; then
		mkdir -p ~/${dirname}/notes/
	fi
	if [ ! -d "${HOME}/${dirname}/notes/ms" ]; then
		mkdir -p ~/${dirname}/notes/ms/
	fi
	if [ ! -d "${HOME}/${dirname}/notes/pdf" ]; then
		mkdir -p ~/${dirname}/notes/pdf/
	fi
	if [ ! -d "${HOME}/${dirname}/notes/html" ]; then
		mkdir -p ~/${dirname}/notes/html/
	fi

	NoteFilename="${HOME}/${dirname}/notes/ms/note_${TheDate}.ms"

	if [ ! -f "${NoteFilename}" ]; then
		printf '%s\n'\
			".SH" ".LG" ".LG" \
			"Note for ${TheDate}" \
			> "${NoteFilename}"
	fi

	vim \
		-c "norm Go.SH" \
		-c "norm Go$(date +%H:%M)" \
		-c "norm Go.PP" \
		-c "norm Go" \
		-c "norm zz" "${NoteFilename}"
}
# }}}

#note_take_markdown "$1"
note_take_groff "$1"
