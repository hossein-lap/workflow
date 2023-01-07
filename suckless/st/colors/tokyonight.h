/* Colorscheme */
static const char *colorname[] = {
	/* 8 normal colors */
	[0] = "#32344a", /* black   */
	[1] = "#f7768e", /* red     */
	[2] = "#9ece6a", /* green   */
	[3] = "#e0af68", /* yellow  */
	[4] = "#7aa2f7", /* blue    */
	[5] = "#ad8ee6", /* magenta */
	[6] = "#449dab", /* cyan    */
	[7] = "#787c99", /* white   */
	/* 8 bright colors */
	[8]  = "#444b6a", /* black   */
	[9]  = "#ff7a93", /* red     */
	[10] = "#b9f27c", /* green   */
	[11] = "#ff9e64", /* yellow  */
	[12] = "#7da6ff", /* blue    */
	[13] = "#bb9af7", /* magenta */
	[14] = "#0db9d7", /* cyan    */
	[15] = "#acb0d0", /* white   */
	/* more colors can be added after 255 to use with DefaultXX */
	[255] = 0,
	[256] = "#11121d", /* 256 -> bg */
	[257] = "#a0a8cd", /* 257 -> fg */
	[258] = "#ff2200", /* 258 -> cursor */
	[259] = "#11121d", /* 259 -> rev cursor*/
};
