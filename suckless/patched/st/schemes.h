static const ColorScheme schemes[] = {
	/* Dracula {{{ */
	{
		{
		/* 8 normal colors */
			"#21222c",
			"#ff5555",
			"#50fa7b",
			"#f1fa8c",
			"#bd93f9",
			"#ff79c6",
			"#8be9fd",
			"#f8f8f2",
		/* 8 bright colors */
			"#6272a4",
			"#ff6e6e",
			"#69ff94",
			"#ffffa5",
			"#d6acff",
			"#ff92df",
			"#a4ffff",
			"#ffffff",
		/* special */
			[256] = "#f32323",
			[257] = "#1e1f29"
//			[257] = "#282a36"
		},
		15,   /* foreground */
		257,  /* background */
		256,    /* cursor */
		257   /* I have no idea XD */
	},
	/*}}}*/
	/* Solarized-dark {{{ */
	{
		{
		/* 8 normal colors */
			"#073642", /* black   */
			"#dc322f", /* red     */
			"#859900", /* green   */
			"#b58900", /* yellow  */
			"#268bd2", /* blue    */
			"#d33682", /* magenta */
			"#2aa198", /* cyan    */
			"#eee8d5", /* white   */
		/* 8 bright colors */
			"#002b36", /* black   */
			"#cb4b16", /* red     */
			"#586e75", /* green   */
			"#657b83", /* yellow  */
			"#839496", /* blue    */
			"#6c71c4", /* magenta */
			"#93a1a1", /* cyan    */
			"#fdf6e3", /* white   */
		/* special */
			[256] = "#93a1a1",
			[257] = "#fdf6e3"
		},
		7,   /* foreground */
		8,   /* background */
		1,   /* cursor */
		257  /* I have no idea XD */
	},
	/*}}}*/
	/* Gruvbox-dark {{{ */
	{
		{
		/* 8 normal colors */
			"#282828", /* black   */
			"#cc241d", /* red     */
			"#98971a", /* green   */
			"#d79921", /* yellow  */
			"#458588", /* blue    */
			"#b16286", /* magenta */
			"#689d6a", /* cyan    */
			"#a89984", /* white   */
		/* 8 bright colors */
			"#928374", /* black   */
			"#fb4934", /* red     */
			"#b8bb26", /* green   */
			"#fabd2f", /* yellow  */
			"#83a598", /* blue    */
			"#d3869b", /* magenta */
			"#8ec07c", /* cyan    */
			"#ebdbb2", /* white   */
		/* special */
			[256] = "#ebdbb2",
			[257] = "#555555",
		},
		15,  /* foreground */
		0,   /* background */
		9,   /* cursor */
		257  /* I have no idea XD */
	},
	/*}}}*/
	/* Ubuntu {{{ */
	{
		{
		/* 8 normal colors */
			"#2e3436",
			"#ef2929",
			"#8ae234",
			"#fce94f",
			"#729fcf",
			"#ad7fa8",
			"#34e2e2",
			"#eeeeec",
		/* 8 bright colors */
			"#555753",
			"#cc0000",
			"#4e9a06",
			"#c4a000",
			"#3465a4",
			"#75507b",
			"#06989a",
			"#d3d7cf",
		/* special */
			[256] = "#ff7700",
			//[256] = "#eeeeec",
			[257] = "#2d0922"
		},
		15,   /* foreground */
		257,  /* background */
		256,    /* cursor */
		257   /* I have no idea XD */
	},
	/* }}} */
	// /* Ayu-dark {{{ */
	{
		{
		/* 8 normal colors */
			"#01060e",
			"#ea6c73",
//			"#91b362",
			"#c2d94c",
			"#f9af4f",
			"#53bdfa",
			"#fae994",
			"#90e1c6",
			"#c7c7c7",
		/* 8 bright colors */
			"#686868",
			"#f07178",
			"#c2d94c",
			"#ffb454",
			"#59c2ff",
			"#ffee99",
			"#95e6cb",
			"#ffffff",
		/* special */
			[256] = "#b3b1ad", // foreground
			[257] = "#0a0e14", // background
		},
		15,   /* foreground */
		257,  /* background */
		1,    /* cursor */
		257   /* I have no idea XD */
	},
	// /* }}} */
	/* Hos {{{ */
	{
		{
		/* 8 normal colors */
			"#0A0A0A",
			"#EE0000",
			"#005f96",
			"#0066ff",
			"#0034b6",
			"#d64601",
			"#bb2121",
			"#AAABA6",
		/* 8 bright colors */
			"#2E2E2C",
			"#8B0000",
			"#7013cc",
			"#777777",
			"#007700",
			"#ff8c00",
			"#e42121",
			"#f53101",
		/* special colors */
			[256] = "#ffffff",
			[257] = "#11121d",
		},
		7,    /* foreground */
		257,  /* background */
		1,    /* cursor */
		257   /* I have no idea XD */
	},
	/* }}} */
	/* Termite {{{ */
	{
		{
		/* 8 normal colors */
			"#000000", /* black   */
			"#FF0000", /* red     */
			"#97D01A", /* green   */
			"#FFA800", /* yellow  */
			"#16B1FB", /* blue    */
			"#FF2491", /* magenta */
			"#0FDCB6", /* cyan    */
			"#EBEBEB", /* white   */
		/* 8 bright colors */
			"#232323", /* black   */
			"#FF0000", /* red     */
			"#76B639", /* green   */
			"#E1A126", /* yellow  */
			"#289CD5", /* blue    */
			"#FF2491", /* magenta */
			"#0A9B81", /* cyan    */
			"#F8F8F8", /* white   */
		/* special */
			[256] = "#ff7700",
			[257] = "#000000"
//			[257] = "#11121d"
		},
		15,   /* foreground */
		257,  /* background */
		256,    /* cursor */
		257   /* I have no idea XD */
	},
	/*}}}*/
	/* 256_noir {{{ */
	{
		{
		/* 8 normal colors */
			"#000000", /* black   */
			"#ee0000", /* red     */
			"#585855", /* green   */
			"#AAABA6", /* yellow  */
			"#383833", /* blue    */
			"#D6D6D0", /* magenta */
			"#7a7a77", /* cyan    */
			"#AAABA6", /* white   */
		/* 8 bright colors */
			"#000000", /* black   */
			"#ee0000", /* red     */
			"#585855", /* green   */
			"#AAABA6", /* yellow  */
			"#383833", /* blue    */
			"#D6D6D0", /* magenta */
			"#7a7a77", /* cyan    */
			"#AAABA6", /* white   */
		/* special */
			[256] = "#ee0000",
			[257] = "#000000"
		},
		15,   /* foreground */
		257,  /* background */
		1,    /* cursor */
		257   /* I have no idea XD */
	},
	/* }}} */
	/* Solarized light {{{ */
	{
		{
		/* 8 normal colors */
			"#eee8d5", /* black   */
			"#dc322f", /* red     */
			"#859900", /* green   */
			"#b58900", /* yellow  */
			"#268bd2", /* blue    */
			"#d33682", /* magenta */
			"#2aa198", /* cyan    */
			"#073642", /* white   */
		/* 8 bright colors */
			"#fdf6e3", /* black   */
			"#cb4b16", /* red     */
			"#93a1a1", /* green   */
			"#839496", /* yellow  */
			"#657b83", /* blue    */
			"#6c71c4", /* magenta */
			"#586e75", /* cyan    */
			"#002b36", /* white   */
		/* special */
			[256] = "#586e75",
			[257] = "#fafafa"
			//"#002b36"
		},
		12,   /* foreground */
		257,    /* background */
		256,  /* cursor */
		257   /* I have no idea XD */
	},
	/*}}}*/
	/* Default {{{ */
	{
		{
		/* 8 normal colors */
			"black",
			"red3",
			"green3",
			"yellow3",
			"blue2",
			"magenta3",
			"cyan3",
			"gray90",
		/* 8 bright colors */
			"gray50",
			"red",
			"green",
			"yellow",
			"#5c5cff",
			"magenta",
			"cyan",
			"white",
		/* special */
			[256] = "#cccccc",
			[257] = "black",
		},
		7,    /* foreground */
		257,  /* background */
		256,  /* cursor */
		257   /* I have no idea XD */
	},
	/*}}}*/
};
