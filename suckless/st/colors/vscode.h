/* Colorscheme */
static const char *colorname[] = {
	/* 8 normal colors */
	[0] = "#000000", /* black   */
	[1] = "#cd3131", /* red     */
	[2] = "#0dbc79", /* green   */
	[3] = "#e5e510", /* yellow  */
	[4] = "#2472c8", /* blue    */
	[5] = "#bc3fbc", /* magenta */
	[6] = "#11a8cd", /* cyan    */
	[7] = "#e5e5e5", /* white   */
	/* 8 bright colors */
	[8]  = "#666666", /* black   */
	[9]  = "#f14c4c", /* red     */
	[10] = "#50fa7b", /* green   */
	[11] = "#f1fa8c", /* yellow  */
	[12] = "#3b8eea", /* blue    */
	[13] = "#d670d6", /* magenta */
	[14] = "#29b8db", /* cyan    */
	[15] = "#e5e5e5", /* white   */
	/* more colors can be added after 255 to use with DefaultXX */
	[255] = 0,
	[256] = "#161719", /* 256 -> bg */
	[257] = "#b7bcba", /* 257 -> fg */
	[258] = "#ff7700", /* 258 -> cursor */
	[259] = "#000000", /* 259 -> rev cursor*/
};
