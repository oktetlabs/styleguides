PANDOC = pandoc
PANDOC_OPTIONS = --toc -S

.PHONY : all pdf html txt clean
.SUFFIXES : .md .txt .html .pdf

DOCID = OKTL-0000034

all: pdf html txt

pdf: $(DOCID).pdf

html: $(DOCID).html

txt: $(DOCID).txt

.md.html:
	$(PANDOC) -t html -s $(PANDOC_OPTIONS) -o $@ $<

.md.txt:
	$(PANDOC) -t plain $(PANDOC_OPTIONS) -o $@ $<

.md.pdf:
	$(PANDOC) $(PANDOC_OPTIONS) -o $@ $<

clean :
	rm -f $(DOCID).pdf $(DOCID).html $(DOCID).txt
