/* bg opacity */
float alpha = 1.00;

/* Colorscheme */
static const char *colorname[] = {
	/* 8 normal colors */
	[0] = "#1d1d1d", /* black   */
	[1] = "#f92655", /* red     */
	[2] = "#a6e22e", /* green   */
	[3] = "#fd9717", /* yellow  */
	[4] = "#4e82aa", /* blue    */
	[5] = "#8c54de", /* magenta */
	[6] = "#2aa198", /* cyan    */
	[7] = "#ccccc6", /* white   */
	/* 8 bright colors */
	[8]  = "#75715e", /* black   */
	[9]  = "#f92633", /* red     */
	[10] = "#a6e22e", /* green   */
	[11] = "#f4bf75", /* yellow  */
	[12] = "#66d9ef", /* blue    */
	[13] = "#ae81ff", /* magenta */
	[14] = "#545455", /* cyan    */
	[15] = "#f9f8f5", /* white   */
	/* special colors */
	[255] = 0,
	[256] = "#11121d", /* background */
	[257] = "#bbbbbb", /* foreground */
	[258] = "#ff2200", /* cursor background */
	[259] = "#11121d", /* cursor foreground */
};
