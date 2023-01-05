/* bg opacity */
float alpha = 1.00;

/* Colorscheme */
static const char *colorname[] = {
	/* Normal */
	[0] = "#073642",  /*  0: black    */
	[1] = "#dc322f",  /*  1: red      */
	[2] = "#859900",  /*  2: green    */
	[3] = "#b58900",  /*  3: yellow   */
	[4] = "#268bd2",  /*  4: blue     */
	[5] = "#d33682",  /*  5: magenta  */
	[6] = "#2aa198",  /*  6: cyan     */
	[7] = "#eee8d5",  /*  7: white    */
	/* Bright */
	[8]  = "#002b36",  /*  8: brblack  */
	[9]  = "#cb4b16",  /*  9: brred    */
	[10] = "#586e75",  /* 10: brgreen  */
	[11] = "#657b83",  /* 11: bryellow */
	[12] = "#839496",  /* 12: brblue   */
	[13] = "#6c71c4",  /* 13: brmagenta*/
	[14] = "#93a1a1",  /* 14: brcyan   */
	[15] = "#fdf6e3",  /* 15: brwhite  */
	/* more colors can be added after 255 to use with DefaultXX */
	[255] = 0,
	[256] = "#002b36", /* 256 -> bg */
	[257] = "#cccccc", /* 257 -> fg */
	[258] = "#cb4b16", /* 258 -> cursor */
	[259] = "#000000", /* 259 -> rev cursor*/
};
