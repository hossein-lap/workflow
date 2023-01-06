/* bg opacity */
float alpha = 1.00;

/* Colorscheme */
static const char *colorname[] = {
	/* 8 normal colors */
	[0] = "#0A0A0A",
	[1] = "#EE0000",
	[2] = "#005f96",
	[3] = "#0066ff",
	[4] = "#0034b6",
	[5] = "#d64601",
	[6] = "#bb2121",
	[7] = "#AAABA6",
	/* 8 bright colors */
	[8] = "#2E2E2C",
	[9] = "#8B0000",
	[10] = "#7013cc",
	[11] = "#777777",
	[12] = "#007700",
	[13] = "#ff8c00",
	[14] = "#e42121",
	[15] = "#f53101",
	/* special colors */
	[255] = 0,
	[256] = "#11121d", /* 256 -> bg */
	[257] = "#ffffff", /* 257 -> fg */
	[258] = "#ff2200", /* 258 -> cursor */
	[259] = "#11121d", /* 259 -> rev cursor*/
};

