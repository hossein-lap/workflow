.\" bullet list {{{
.de bu
.IP \[bu] 3
\\$1
..
.de su
.IP \[SP]
\\$1
..
.de hu
.IP \[HE]
\\$1
..
.de du
.IP \[DI]
\\$1
..
.de cu
.IP \[CL]
\\$1
..
.\" }}}
.\" circle list {{{
.de ci
.IP \[ci] 3
\\$1
..
.\" }}}
.\" checked list {{{
.de ok
.IP \[OK] 3
\\$1
..
.\" }}}
.\" unchecked list {{{
.de sq
.IP \[sq] 3
\\$1
..
.\" }}}
.\" codeblock {{{
.de cb
.nr ln 1
.sp 1n
.QS
.B1
.ft CW
.br
.sp 1n
.nf
.\".in +.1m
.SM
.SM
.nm +0 1 1 -5
.LG
.LG
..
.de /cb
.br
.sp 1n
.nm
.fi
.ft
.in
.B2
.QE
..
.\" }}}
.\" outputblock {{{
.de ob
.QS
.sp 1n
.ft CW
.nf
..
.de /ob
.nm
.ft P
.sp 1n
.QE
..
.\" }}}
.\" headings {{{
.de nh
.NH \\$2
.XN "\\$1"
..
.de sh
.SH \\$2
.LG
.XN "\\$1"
..
.\" }}}
