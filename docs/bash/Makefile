NAME = bash
CC = pandoc
THEME = ../theme

TARGS = -V title:'Bash' -V subtitle:'Cheatsheet' -V author:'P J'
TOC = --toc --toc-depth=2
TITLE = #$(TOC) $(TARGS)

COLOR = $(TITLE) --defaults $(THEME)/dracula.yaml
BANDW = $(TITLE) --defaults $(THEME)/bw.yaml

all:
	$(CC) $(BANDW) $(NAME).md -o $(NAME)-bw.pdf
#	$(CC) $(COLOR) $(NAME).md -o $(NAME).pdf
#	Rscript -e "rmarkdown::render(input = '$(NAME).rmd', output_format = \"all\")"

full:
	$(CC) $(COLOR) $(NAME).md -o $(NAME).pdf
	$(CC) $(BANDW) $(NAME).md -o $(NAME)-bw.pdf

clean:
	make
	rm *.aux *.log *.toc
