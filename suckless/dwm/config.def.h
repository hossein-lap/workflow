/* See LICENSE file for copyright and license details. */

/* vars */
//#define SCRIPTSPATH "/data/dev/hossein-lap/workflow/scripts/"

static const char term[]    = "st";
static const char fileman[] = "lfub";
static const char browser[] = "firefox";
static const char muspley[] = "cmus";
static const char rssread[] = "newsboat";
static const char bdterm[]  = "xfce4-terminal";

/* appearance */
static const unsigned int borderpx = 3;  /* border pixel of windows */
static const unsigned int snap     = 32; /* snap pixel */
static const unsigned int gappih   = 12; /* horiz inner gap between windows */
static const unsigned int gappoh   = 22; /* horiz outer gap between windows and screen edge */
static const unsigned int gappiv   = 10; /* vert inner gap between windows */
static const unsigned int gappov   = 10; /* vert outer gap between windows and screen edge */
static const int smartgaps    = 0; /* 1 means no outer gap when there is only one window */
static const int showbar      = 1; /* 0 means no bar */
static const int topbar       = 1; /* 0 means bottom bar */
static const char *fonts[]    = {
	"Fira Code:size=14",
	"Vazir Variable:Bold:pixelsize=20:antialias=true:autohint=true",
	"FiraCode Nerd Font:size=14",
	"JoyPixels:pixelsize=20:antialias=true:autohint=true",
	"FontAwesome:pixelsize=20:antialias=true:autohint=true",
//	"Noto Color Emoji:pixelsize=20:antialias=true:autohint=true",
};
static const char dmenufont[] = { "Fira Code:size=14" };

/* colorschemes */
#include "colors/void.h"
static const char *colors[][3]	= {
	/*               fg         bg         border   */
	[SchemeNorm] = { normal_fg, normal_bg, normal_br },
	[SchemeSel]  = { focus_fg, focus_bg, focus_br },
};

/* tagging */
static const char *tags[] = {
	"♠", "♠", "♠", "♥", "♥", "♥", "♣", "♣", "♣" 
//	"", "", "漣", "", "ﳲ", "", "", "", ""
//	"1", "2", "3", "4", "5", "6", "7", "8", "9"
//	"a", "b", "c", "d", "e", "f", "g", "h", "i"
};
static const char *tagsalt[] = {
	"1", "2", "3", "4", "5", "6", "7", "8", "9"
//	"q", "w", "e", "r", "t", "y", "u", "i", "o"
//	"a", "b", "c", "d", "e", "f", "g", "h", "i"
};
static const int momentaryalttags = 0; /* 1 means alttags will show only when key is held down*/

static const Rule rules[]	= {
	/* xprop(1):
	 *   WM_CLASS(STRING) = instance, class
	 *   WM_NAME(STRING) = title
	 */
	/* class       instance    title       tags mask     isfloating   monitor */
	{ "Gimp",      NULL,       NULL,           0,            1,          -1 },
	{ "st",        NULL,       "Terminal",     0,            1,          -1 },
	{ "Nsxiv",     "nsxiv",    "nsxiv",        0,            1,          -1 },
//	{ "Sxiv",      "sxiv",     "sxiv",         0,            1,          -1 },
//	{ "dmenu",     NULL,       "dmsrun.sh",    0,            1,          -1 },
//	{ "dmenu",     NULL,       "dmshot.sh",    0,            1,          -1 },
//	{ "dmenu",     NULL,       "dmusb.sh",     0,            1,          -1 },
//	{ "dmenu",     NULL,       "dmrecord.sh",  0,            1,          -1 },
//	{ "dmenu",     NULL,       "dmchar.sh",    0,            1,          -1 },
//	{ "dmenu",     NULL,       "dmstexec.sh",  0,            1,          -1 },
//	{ "dmenu",     NULL,       "dmlp.sh",      0,            1,          -1 },
////	{ "dmenu",     NULL,       NULL,           0,            0,          -1 },
	{ "Firefox",   NULL,       NULL,           1 << 3,       0,          -1 },
	{ "st",        NULL,       "lfub",         1 << 4,       0,          -1 },
	{ "st",        NULL,       "cmus",         1 << 7,       0,          -1 },
	{ "Telegram",  NULL,       NULL,           1 << 8,       0,          -1 },
};

/* layout(s) */
static const float mfact = 0.53;     /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;        /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int statusall = 1;      /* 1 means status is shown in all bars, not just active monitor */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[]	= {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "[M]",      monocle },
	{ "><>",      NULL },    /* no layout function means floating behavior */
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
static const char *dmenucmd[] = {
	"dmenu_run", "-p", "run", "-m", dmenumon,
		"-fn", dmenufont, "-nb", normal_bg, "-nf", normal_fg,
		"-sb", focus_bg, "-sf", focus_fg,
	NULL
};
static const char *termcmd[] = { "st", NULL };
/* hos custom {{{ */
static const char *tabbdcmd[] = { "tabbed", "-c", "-k", "-r", "2", "st", "-w", "''", NULL };
//static const char *takenote[] = { "st", "-t", "Terminal", "sh", "-c", "notetake.sh", NULL};
static const char *bidicmd[] = { bdterm, NULL};
static const char *filecmd[] = { term, "-t", fileman, fileman, NULL};
static const char *newsboat[] = { term, "-t", "Newsboat", rssread, NULL};
static const char *muscmd[] = { "sh", "-c", "cmustmux.sh", NULL};
static const char *wwwcmd[] = { browser, NULL};
static const char *brightu[] = { "brightnessctl", "s", "+5\%", NULL};
static const char *brightd[] = { "brightnessctl", "s", "5\%-", NULL};
static const char *takenote[] = { "sh", "-c", "mdtodo.sh", NULL};
static const char *floatcmd[] = { "sh", "-c", "dmstexec.sh", NULL};
static const char *dmshot[] = { "sh", "-c", "dmshot.sh", NULL};
static const char *dmkill[] = { "sh", "-c", "dmkill.sh", NULL};
static const char *dmsrun[] = { "sh", "-c", "dmsrun.sh", NULL};
static const char *dmusbd[] = { "sh", "-c", "dmusb.sh", NULL};
static const char *dmchnf[] = { "sh", "-c", "dmchar_nerdfont.sh", NULL};
static const char *dmchfa[] = { "sh", "-c", "dmchar_fontawesome.sh", NULL};
static const char *dmchem[] = { "sh", "-c", "dmchar_emoji.sh", NULL};
static const char *dmchuc[] = { "sh", "-c", "dmchar_unicode.sh", NULL};
static const char *dmexit[] = { "sh", "-c", "dmexit.sh", NULL};
static const char *scrn_lock[] = { "slock", NULL};
static const char *emclient[] = { "emacsclient", "-c", "-a", "emacs", NULL};
static const char *sysbtop[] = { term, "btop", NULL};
/* }}}*/

static const Key keys[] = {
	/* modifier                     key        function        argument */
	/* hos custom {{{ */
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY|ShiftMask,             XK_t,      spawn,          {.v = tabbdcmd } },
	{ MODKEY,                       XK_x,      spawn,          {.v = floatcmd } },
	{ MODKEY|ControlMask,           XK_t,      spawn,          {.v = bidicmd } },
	{ 0,                            XK_Print,  spawn,          {.v = dmshot } },
	{ MODKEY|ShiftMask,             XK_k,      spawn,          {.v = dmkill } },
	{ MODKEY,                       XK_r,      spawn,          {.v = dmsrun } },
	{ MODKEY|ShiftMask,             XK_d,      spawn,          {.v = dmusbd } },
	{ MODKEY|ShiftMask,             XK_a,      spawn,          {.v = dmchfa } },
	{ MODKEY,                       XK_a,      spawn,          {.v = dmchnf } },
	{ MODKEY,                       XK_e,      spawn,          {.v = dmchem } },
	{ MODKEY,                       XK_u,      spawn,          {.v = dmchuc } },
	{ MODKEY|ShiftMask,             XK_l,      spawn,          {.v = scrn_lock } },
	{ MODKEY|ShiftMask,             XK_f,      spawn,          {.v = filecmd } },
	{ MODKEY|ShiftMask,             XK_b,      spawn,          {.v = wwwcmd } },
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = muscmd } },
	{ MODKEY|ShiftMask,             XK_n,      spawn,          {.v = newsboat } },
	{ MODKEY|ControlMask,           XK_Delete, spawn,          {.v = sysbtop } },
	{ MODKEY,                       XK_n,      spawn,          {.v = takenote } },
	{ MODKEY|ShiftMask,             XK_e,      spawn,          {.v = emclient } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY,                       XK_Up,     spawn,          {.v = brightu } },
	{ MODKEY,                       XK_Down,   spawn,          {.v = brightd } },
	{ MODKEY,                       XK_q,      spawn,          {.v = dmexit } },
	/* }}}*/
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|Mod4Mask,              XK_h,      incrgaps,       {.i = +1 } },
	{ MODKEY|Mod4Mask,              XK_l,      incrgaps,       {.i = -1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_h,      incrogaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_l,      incrogaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask|ControlMask,  XK_h,      incrigaps,      {.i = +1 } },
	{ MODKEY|Mod4Mask|ControlMask,  XK_l,      incrigaps,      {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_0,      togglegaps,     {0} },
	{ MODKEY|Mod4Mask|ShiftMask,    XK_0,      defaultgaps,    {0} },
	{ MODKEY,                       XK_y,      incrihgaps,     {.i = +1 } },
	{ MODKEY,                       XK_o,      incrihgaps,     {.i = -1 } },
	{ MODKEY|ControlMask,           XK_y,      incrivgaps,     {.i = +1 } },
	{ MODKEY|ControlMask,           XK_o,      incrivgaps,     {.i = -1 } },
	{ MODKEY|Mod4Mask,              XK_y,      incrohgaps,     {.i = +1 } },
	{ MODKEY|Mod4Mask,              XK_o,      incrohgaps,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_y,      incrovgaps,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_o,      incrovgaps,     {.i = -1 } },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_v,      togglealttag,   {0} },
	TAGKEYS(                        XK_1,                       0)
	TAGKEYS(                        XK_2,                       1)
	TAGKEYS(                        XK_3,                       2)
	TAGKEYS(                        XK_4,                       3)
	TAGKEYS(                        XK_5,                       4)
	TAGKEYS(                        XK_6,                       5)
	TAGKEYS(                        XK_7,                       6)
	TAGKEYS(                        XK_8,                       7)
	TAGKEYS(                        XK_9,                       8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
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

