library(knitr)

knitr::knit_engines$set(
	lua = function(options) {
		code <- paste(options$code, collapse = '\n')
		out <- system2(
			'lua', c('-e', shQuote(code)),
			stdout = TRUE
		)
		knitr::engine_output(options, code, out)
	},
	julia = function(options) {
		code <- paste(options$code, collapse = '\n')
		out <- system2(
			'julia', c('-e', shQuote(code)),
			stdout = TRUE
		)
		knitr::engine_output(options, code, out)
	}
)

knitr::opts_chunk$set(engine.path = list(
	lua = '/usr/bin/lua',
	julia = '/usr/bin/julia'
))

knitr::opts_chunk$set(
	comment = '## ',
	message = FALSE,
	warning = FALSE,
	results = 'markup',
	background = '#000000',
	attr.source = '.numberLines'
)
knitr::opts_knit$set(
	progress = FALSE,
	verbose = FALSE
)
