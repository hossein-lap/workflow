/* bg opacity */
float alpha = 1.00;

/* Colorscheme */
static const char *colorname[] = {
	/* 8 normal colors */
	[0] = "#000000", /* black   */
	[1] = "#ee0000", /* red     */
	[4] = "#383833", /* green   */
	[3] = "#AAABA6", /* yellow  */
	[2] = "#585855", /* blue    */
	[5] = "#D6D6D0", /* magenta */
	[6] = "#7a7a77", /* cyan    */
	[7] = "#AAABA6", /* white   */
	/* 8 bright colors */
	[8] = "#000000", /* black   */
	[9] = "#ee0000", /* red     */
	[12] = "#383833", /* green   */
	[11] = "#AAABA6", /* yellow  */
	[10] = "#585855", /* blue    */
	[13] = "#D6D6D0", /* magenta */
	[14] = "#7a7a77", /* cyan    */
	[15] = "#AAABA6", /* white   */
	//[8]  = "#2E2E2C", /* black   */
	//[9]  = "#aa0000", /* red     */
	//[10] = "#7a7a77", /* green   */
	//[11] = "#D6D6D0", /* yellow  */
	//[12] = "#7a7a77", /* blue    */
	//[13] = "#AAABA6", /* magenta */
	//[14] = "#585855", /* cyan    */
	//[15] = "#D6D6D0", /* white   */
	/* more colors can be added after 255 to use with DefaultXX */
	[255] = 0,
	[256] = "#000000", /* 256 -> bg */
	[257] = "#b7bcba", /* 257 -> fg */
	[258] = "#ff0000", /* 258 -> cursor */
	[259] = "#000000", /* 259 -> rev cursor*/
};
