/* bg opacity */
float alpha = 1.00;

/* Colorscheme */
static const char *colorname[] = {
	/* 8 normal colors */
	[0] = "#282828", /* black   */
	[1] = "#cc241d", /* red     */
	[2] = "#98971a", /* green   */
	[3] = "#d79921", /* yellow  */
	[4] = "#458588", /* blue    */
	[5] = "#b16286", /* magenta */
	[6] = "#689d6a", /* cyan    */
	[7] = "#a89984", /* white   */
	/* 8 bright colors */
	[8]  = "#928374", /* black   */
	[9]  = "#fb4934", /* red     */
	[10] = "#b8bb26", /* green   */
	[11] = "#fabd2f", /* yellow  */
	[12] = "#83a598", /* blue    */
	[13] = "#d3869b", /* magenta */
	[14] = "#8ec07c", /* cyan    */
	[15] = "#ebdbb2", /* white   */
	/* special colors */
	/* hard contrast: #1d2021 / normal contrast: #282828 / soft contrast: #32302f */
	[255] = 0,
	[256] = "#1d2021", /* background */
	[257] = "#ebdbb2", /* foreground */
	[258] = "#ff7700", /* cursor background */
	[259] = "#000000", /* cursor foreground */
};
