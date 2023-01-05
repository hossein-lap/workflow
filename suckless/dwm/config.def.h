/* See LICENSE file for copyright and license details. */

/* vars */
#define SCRIPTSPATH "~/.local/dev/hossein-lap/scripts/"

static const char term[]		= "st";
static const char fileman[]		= "lfub";
static const char browser[]		= "firefox";
static const char muspley[]		= "cmus";
static const char rssread[]		= "newsboat";

//static const char ndterm[]		= "alacritty";
static const char bdterm[]		= "lxterminal";

/* colorschemes */
/*
 * List of colors:
 *   • blue:      "#0077ff" • cyan:      "#00aaff"
 *   • pink:      "#ff77cc" • purple:    "#cc77ff"
 *   • red:       "#ff0000" • darkpink:  "#e95678"
 *   • orange:    "#ff7700" • yellow:    "#ffd500"
 *   • white:     "#ffffff" • default
 *   • dracula
 *   • soalrized-dark: {blue,green,pink,yellow}
 */
#include "colors/bg/orange.h"

static const char *colors[][3]	  = {
        /*                     fg        bg        border   */
	[SchemeNorm]	= { normal_fg, normal_bg, normal_br },
	[SchemeSel]	= { focus_fg, focus_bg, focus_br },
};

/* appearance */
static const unsigned int borderpx	= 2;	/* border pixel of windows */
static const unsigned int snap		= 64;	/* snap pixel */
static const unsigned int gappx		= 16;	/* gap pixel between windows */
static const int showbar		= 1;	/* 0 means no bar */
static const int topbar			= 1;	/* 0 means bottom bar */

static const char *fonts[]		= { "Fira Code:size=12" };
static const char dmenufont[]		= { "Fira Code:size=12" };
//static const char *fonts[]		= { "Ubuntu Mono:size=15" };
//static const char dmenufont[]		= { "Ubuntu Mono:size=15" };
//static const char *fonts[]		= { "Fira Mono:size=13" };
//static const char dmenufont[]		= { "Fira Mono:size=13" };

/* tagging */
//static const char *tags[] = { "sys", "dev", "www", "dir", "vid", "doc", "em", "pre", "tmp" };
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };
//static const char *tags[] = { "a", "b", "c", "d", "e", "f", "g", "h", "i" };
//static const char *tags[] = { "a", "s", "d", "f", "g", "h", "j", "k", "l" };
//static const char *tags[] = { "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX" };
//static const char *tags[] = { "i", "ii", "iii", "iv", "v", "vi", "vii", "viii", "ix" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class	instance	title		tags mask	isfloating	monitor */
//	{ "Gimp",	NULL,	NULL,				0,		1,	-1 },
	{ "Mozilla Firefox",	NULL,	NULL,				4,		0,	-1 },
	{ "sxiv",	NULL,	NULL,				0,		1,	-1 },
//	{ "persepolis",	NULL,	"Persepolis Download Manager",	0,		1,	-1 },
//	{ "Telegram",	NULL,	"Telegram",			5,		0,	-1 },
	{ "sterm",	NULL,	"Term",				0,		1,	-1 },
	{ "st",		NULL,	"Terminal",			0,		1,	-1 },
	{ "dmenu",		NULL,	"broken",			0,		1,	-1 },
	{ "st",		NULL,	"Note",				0,		1,	-1 },
	{ "GNU Emacs",	NULL,	"Note",				7,		0,	-1 },
};

/* layout(s) */
static const float mfact     = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },
	{ "[M]",      monocle },  /* first entry is default */
	{ "><>",      NULL },   /* no layout function means floating behavior */
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */

static const char *dmenucmd[]	= {
	"dmenu_run", "-p", "run:", "-m", dmenumon,
		"-fn", dmenufont, "-bw", "0", "-nb", normal_bg, "-nf", normal_fg,
		"-sb", focus_bg, "-sf", focus_fg,
	NULL
};

//static const char *dmenupln[]	= {
//	"dmenu_run", "-p", "run:", "-m", dmenumon,
//		"-fn", dmenufont, "-nb", normal_bg, "-nf", normal_fg, "-sb", focus_bg,
//		"-sf", focus_fg, "-c", "-l", "15", "-g", "1",
//	NULL
//};

static const char *termcmd[]	= { term, NULL };
//static const char *ndtmcmd[]	= { ndterm, NULL };
/* hos custom {{{ */

static const char *tabbdcmd[]	= { "tabbed", "-c", "-k", "-r", "2", "st", "-w", "''", NULL };
static const char *floatcmd[]	= { term, "-t", "Terminal", NULL};
//static const char *floatcmd[]	= { "st", "-t", "Terminal", NULL};
static const char *takenote[]	= { "st", "-t", "Note", "bash", "-c", SCRIPTSPATH"note-take.sh", NULL};
static const char *bidicmd[]	= { bdterm, NULL};

static const char *filecmd[]	= { term, "-t", fileman, fileman, NULL};
static const char *newsboat[]	= { term, "-t", "Newsboat", rssread, NULL};
static const char *muscmd[]	= { "bash", "-c", SCRIPTSPATH"cmus-tmux.sh", NULL};
static const char *wwwcmd[]	= { browser, NULL};
/* change brightness */
static const char *brightu[]	= { "brightnessctl", "s", "+5\%", NULL};
static const char *brightd[]	= { "brightnessctl", "s", "5\%-", NULL};

static const char *dmshot[]	= { "bash", "-c", SCRIPTSPATH"dm-shot.sh", NULL};

static const char *dmkill[]	= { "bash", "-c", SCRIPTSPATH"dm-kill.sh", NULL};
static const char *dmsrun[]	= { "bash", "-c", SCRIPTSPATH"dm-srun.sh", NULL};
static const char *dmusbd[]	= { "bash", "-c", SCRIPTSPATH"dm-usb.sh",  NULL};
static const char *scrn_lock[]	= { "slock", NULL};
static const char *emclient[]	= { "emacsclient", "-c", "-a", "emacs", NULL};

static const char *sysbtop[]	= { term, "-t", "Terminal", "btop", NULL};
/* }}}*/

static Key keys[] = {
	/* modifier                     key        function        argument */
/* hos custom {{{ */
	{ MODKEY|ShiftMask,		XK_t,		spawn,		{.v = tabbdcmd	} },
	{ MODKEY|ShiftMask,		XK_Return,	spawn,		{.v = termcmd	} },
	{ MODKEY,			XK_x,		spawn,		{.v = floatcmd	} },
	{ MODKEY|ControlMask,		XK_t,		spawn,		{.v = bidicmd	} },
	{ 0,				XK_Print,	spawn,		{.v = dmshot	} },
	{ MODKEY|ShiftMask,		XK_k,		spawn,		{.v = dmkill	} },
	{ MODKEY,			XK_r,		spawn,		{.v = dmsrun	} },
	{ MODKEY|ShiftMask,		XK_d,		spawn,		{.v = dmusbd	} },
	{ MODKEY|ShiftMask,		XK_l,		spawn,		{.v = scrn_lock	} },

	{ MODKEY|ShiftMask,		XK_f,		spawn,		{.v = filecmd	} },
	{ MODKEY|ShiftMask,		XK_b,		spawn,		{.v = wwwcmd	} },
	{ MODKEY|ShiftMask,		XK_m,		spawn,		{.v = muscmd	} },
	{ MODKEY|ShiftMask,		XK_n,		spawn,		{.v = newsboat	} },
	{ MODKEY|ControlMask,		XK_Delete,	spawn,		{.v = sysbtop	} },

	{ MODKEY,			XK_n,		spawn,		{.v = takenote	} },
	{ MODKEY,			XK_e,		spawn,		{.v = emclient	} },
	{ MODKEY,			XK_p,		spawn,		{.v = dmenucmd	} },
	{ MODKEY,			XK_Up,		spawn,		{.v = brightu	} },
	{ MODKEY,			XK_Down,	spawn,		{.v = brightd	} },
/* }}}*/
	{ MODKEY,			XK_b,		togglebar,	{0} },
	{ MODKEY,			XK_j,		focusstack,	{.i = +1 } },
	{ MODKEY,			XK_k,		focusstack,	{.i = -1 } },
	{ MODKEY,			XK_i,		incnmaster,	{.i = +1 } },
	{ MODKEY,			XK_d,		incnmaster,	{.i = -1 } },
	{ MODKEY,			XK_h,		setmfact,	{.f = -0.05} },
	{ MODKEY,			XK_l,		setmfact,	{.f = +0.05} },
	{ MODKEY,			XK_Return,	zoom,		{0} },
	{ MODKEY,			XK_Tab,		view,		{0} },
	{ MODKEY|ShiftMask,		XK_c,		killclient,	{0} },
	{ MODKEY,			XK_t,		setlayout,	{.v = &layouts[0]} },
	{ MODKEY,			XK_m,		setlayout,	{.v = &layouts[1]} },
	{ MODKEY,			XK_f,		setlayout,	{.v = &layouts[2]} },
	{ MODKEY,			XK_space,	setlayout,	{0} },
	{ MODKEY|ShiftMask,		XK_space,	togglefloating,	{0} },
	{ MODKEY,			XK_0,		view,		{.ui = ~0 } },
	{ MODKEY|ShiftMask,		XK_0,		tag,		{.ui = ~0 } },
	{ MODKEY,			XK_comma,	focusmon,	{.i = -1  } },
	{ MODKEY,			XK_period,	focusmon,	{.i = +1  } },
	{ MODKEY|ShiftMask,		XK_comma,	tagmon,		{.i = -1  } },
	{ MODKEY|ShiftMask,		XK_period,	tagmon,		{.i = +1  } },
	TAGKEYS(			XK_1,					0)
	TAGKEYS(			XK_2,					1)
	TAGKEYS(			XK_3,					2)
	TAGKEYS(			XK_4,					3)
	TAGKEYS(			XK_5,					4)
	TAGKEYS(			XK_6,					5)
	TAGKEYS(			XK_7,					6)
	TAGKEYS(			XK_8,					7)
	TAGKEYS(			XK_9,					8)
	{ MODKEY|ShiftMask,		XK_q,		quit,		{0} },
	{ MODKEY|ControlMask,		XK_q,		quit,		{.i = 23} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

