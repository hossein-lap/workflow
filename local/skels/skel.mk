NAME = name
CC   = gcc
CARG = -Wall -std=c99
OARG = -o
TARG = -c
EXT = c
OBJ = o

all:
	$(CC) $(CARG) $(TARG) $(NAME).$(EXT)
	$(CC) $(CARG) $(OARG) $(NAME) $(NAME).$(OBJ)

clean:
	touch *
	make
	rm *.$(OBJ)
