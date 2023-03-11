/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int centered = 0;                    /* -c option; centers dmenu on screen */
static int min_width = 600;                    /* minimum width when centered */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"Fira Code:size=14",
	"Noto Color Emoji:pixelsize=25:antialias=true:autohint=true",
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */

/* colorscheme */
#include "colors/default.h"
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] =  { normal_fg,   normal_bg  },
	[SchemeSel]  =  { focus_fg,    focus_bg   },
	[SchemeOut]  =  { sel_fg,      sel_bg     },
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 0;
static unsigned int columns    = 0;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " /?\"&[]";

/* Size of the window border */
static unsigned int border_width = 0;
