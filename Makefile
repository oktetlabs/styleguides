all: pdf html txt

pdf: OKTL-0000034.texi
	texi2pdf OKTL-0000034.texi

html: OKTL-0000034.texi
	makeinfo --html --no-split --number-sections --commands-in-node-names OKTL-0000034.texi

txt: OKTL-0000034.texi
	makeinfo --plaintext -o OKTL-0000034.txt OKTL-0000034.texi
