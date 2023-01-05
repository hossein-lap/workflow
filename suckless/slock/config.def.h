/* user and group to drop privileges to */
static const char *user  = "hos";
static const char *group = "hos";

/* 
 * Colorschemes
 *   - Available schemes:
 *     + ubuntu
 *     + default
 *     + solarized
 */

#include "colors/custom.h"

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* insert grid pattern with scale 1:1, the size can be changed with logosize */
static const int logosize = 75;
static const int logow = 12;	/* grid width and height for right center alignment*/
static const int logoh = 6;

static XRectangle rectangles[9] = {
	/*      x       y       w       h */
	/* P J */
//	{	2,	0,	1,	7 },
//	{	5,	0,	1,	3 },
//	{	9,	0,	1,	7 },
//	{	2,	3,	4,	1 },
//	{	3,	0,	3,	1 },
//	{	7,	0,	3,	1 },
//	{	6,	6,	4,	1 },
	/* dwm */
	{ 0,	3,	1,	3 },
	{ 1,	3,	2,	1 },
	{ 0,	5,	8,	1 },
	{ 3,	0,	1,	5 },
	{ 5,	3,	1,	2 },
	{ 7,	3,	1,	2 },
	{ 8,	3,	4,	1 },
	{ 9,	4,	1,	2 },
	{ 11,	4,	1,	2 },
};
