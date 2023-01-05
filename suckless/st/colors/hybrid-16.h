/* bg opacity */
float alpha = 1.00;

/* Colorscheme */
static const char *colorname[] = {
	/* Normal */
	[0] = "#1d1f22",
	[1] = "#8d2e32",
	[2] = "#798431",
	[3] = "#e58a50",
	[4] = "#4b6b88",
	[5] = "#6e5079",
	[6] = "#4d7b74",
	[7] = "#5a626a",
	/* Bright */
	[8]  = "#1d1f22",
	[9]  = "#8d2e32",
	[10] = "#798431",
	[11] = "#e58a50",
	[12] = "#4b6b88",
	[13] = "#6e5079",
	[14] = "#4d7b74",
	[15] = "#5a626a",
	/* more colors can be added after 255 to use with DefaultXX */
	[255] = 0,
	[256] = "#222222", /* 256 -> bg */
	[257] = "#b7bcba", /* 257 -> fg */
	[258] = "#ff7700", /* 258 -> cursor */
	[259] = "#000000", /* 259 -> rev cursor*/
};
