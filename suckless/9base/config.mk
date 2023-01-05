# Customize to fit your system

# paths
override PREFIX = /usr/lib/plan9
MANPREFIX   = ${PREFIX}/share/man

VERSION     = 7
OBJTYPE = x86_64
#OBJTYPE     = arm
#OBJTYPE     = x86_64
#OBJTYPE     = sun4u

# Linux/BSD
#CFLAGS      += -Wall -Wno-missing-braces -Wno-parentheses -Wno-switch -c -I. -DPREFIX="\"${PREFIX}\""
override CFLAGS += -D_DEFAULT_SOURCE  -c -I. -DPLAN9PORT -DPREFIX="\"${PREFIX}\"" -fcommon


# Solaris
#CFLAGS      = -fast -xtarget=ultra -D__sun__ -c -I. -DPREFIX="\"${PREFIX}\""
#LDFLAGS     = -dn

# compiler
override AR += rc

YACC = byacc
