PROJECT=baravalle

# xfig documents whose corresponding EPS fies are used in the paper
# FIGFILES = segment.fig allocGroup.fig

# matlab scripts that generate output for the paper. These are *.m files
# that generate a corresponding *.eps file when run.
MFILES =

# GNUplot files
PLTFILES = 

# Other EPS files that are necessary to build the document
# If you have eps files that you generate by hand, list them here.
EPSFILES =

# Non-refdbms bib files to be included
# If you need a local .bib file, put that here.
LOCALBIB = bibliografia/bibliografia.bib bibliografia/amcapaper.bib
LOCALXTXBIB = bibliografia/bibliografia.xtx bibliografia/amcapaper.xtx

# default targets to make for make all
TARGETS = $(PROJECT).pdf
TARGETSPS = $(PROJECT).ps

#-- Programs used when runing latex etc.                       
BIBTEX = bibtex
XTEX = crosstex
LATEX = latex
DVIPS = dvips -tletter
FIG2DEV = fig2dev
MATLAB = matlab
GNUPLOT = gnuplot
PS2PDF = ps2pdf
PDFLATEX = pdflatex

SRCFILES = $(wildcard *.tex)
EPSFIGFILES = $(FIGFILES:.fig=.eps)
EPSMFILES = $(MFILES:.m=.eps)
EPSPLTFILES = $(PLTFILES:.plt=.eps)
EPSFILES += $(EPSFIGFILES) $(EPSMFILES) $(EPSPLTFILES)

#--------------------------------------------------------------------------
# Production/target rules                       
#--------------------------------------------------------------------------
.SUFFIXES:
.PHONY: clean all veryclean
#-- EPS files may be expensive to regenerate, so keep them even though they
#-- are intermediate targets
.PRECIOUS: $(EPSMFILES) $(EPSFIGFILES)
#.PRECIOUS: $(EPSMFILES)

all: $(TARGETS)

#-- Make EPS files from matlab documents
%.eps: %.m
	$(MATLAB) -nodesktop -r "$*;quit" || $(MATLAB) -nodisplay -r "$*;quit"

#-- Make EPS files from xfig documents
%.eps: %.fig
	$(FIG2DEV) -L eps $< $@ || $(FIG2DEV) -L ps $< $@

#-- Make EPS files from GNUplot scripts
%.eps: %.plt
	$(GNUPLOT) $<

#-- Creation of initial .aux file
%.aux: %.tex $(SRCFILES) $(EPSFILES)
	$(LATEX) $<

#-- Create .bbl from .bib
%.bbl: %.aux $(LOCALBIB)
	$(BIBTEX) $*
	$(LATEX) $*.tex
	$(LATEX) $*.tex

#-- Build a dvi... 
#%.dvi: %.tex %.bbl $(EPSFILES) $(LOCALBIB)
%.dvi: %.tex %.bbl
	$(LATEX) $<

#-- converting .dvi to .ps... requires the EPS files
%.ps: %.dvi $(EPSFILES)
	$(DVIPS) -o $@ $<

#-- converting .ps to .pdf.
#%.pdf: %.ps
#	$(PS2PDF) $<

#-- generating pdf using pdflatex
%.pdf: %.tex $(SRCFILES) $(LOCALBIB)
	$(PDFLATEX) $*
	$(BIBTEX) $*
	$(PDFLATEX) $*
	$(BIBTEX) $*
	$(PDFLATEX) $*
	chmod +x $*.pdf
	
#	$(XTEX) --short=conference --short=state --no-field=month --no-field=address --no-field=editor --no-field=publisher \
#		--no-field=pages --xtx2bib $(LOCALXTXBIB)
bib:	$(LOCALXTXBIB)
	$(XTEX) --no-field=editor --no-field=publisher \
		--no-field=pages --xtx2bib $(LOCALXTXBIB)

ps:	$(TARGETSPS)

pdf:
	$(PS2PDF) $(TARGETS)

clean:
	rm -f *~  $(TARGETS) $(TARGETSPS) *.dvi *.log *.aux *.blg *.bbl $(OLDAUX)
	rm -f $(PROJECT)-compressed.pdf

veryclean: clean
	rm -f $(EPSFIGFILES) $(EPSMFILES) $(EPSPLTFILES)

spell:	$(SRCFILES)
	detex $^ | aspell | env LANG=C sort -u | env LANG=C comm -23 - ok-words

release: all
	gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.5 -dEmbedAllFonts=true -dSubsetFonts=true -dNOPAUSE -dQUIET -dBATCH -sOutputFile=$(PROJECT)-compressed.pdf $(PROJECT).pdf pdfmarks

