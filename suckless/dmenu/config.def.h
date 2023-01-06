/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Ubuntu Mono:size=15"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

/* colorscheme */
#include "colors/fg/orange.h"
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] =  { normal_fg,   normal_bg  },
	[SchemeSel]  =  { focus_fg,    focus_bg   },
	[SchemeOut]  =  { sel_fg,      sel_bg     },
};
/* -l option; if nonzero, dmenu uses vertical list with given number of lines */
static unsigned int lines      = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";
