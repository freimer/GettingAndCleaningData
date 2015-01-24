%.pdf: %.md
	pandoc -t latex $< -o $@

all: README.pdf CodeBook.pdf
