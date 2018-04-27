CC=gcc
CFLAGS=-c -Wall -I.
LDFLAGS=-pthreads
SOURCES=thread_function.c prog.c
HEADER=common.h
OBJECTS=$(SOURCES:.c=.o)
EXEC=app

RUNDEP=threads.txt params.txt
RUNSRC=runtest.py

ANDEP=output1.txt output2.txt output4.txt output8.txt output16.txt
ANSRC=preprocess.py

GNUDEP=mean_var.txt

LINEPLOT=lineplot.eps
SPEEDPLOT=speedplot.eps
ERRORPLOT=errorplot.eps
SCATTER=sc1.eps sc2.eps sc4.eps sc8.eps sc16.eps


all:App runtest analyze plot report

#Step 1
App: $(SOURCES) $(EXEC)

$(EXEC): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@

%.o: %.c $(HEADER)
	$(CC) $(CFLAGS) $< -o $@

#Step 2
runtest: $(ANDEP)

$(ANDEP): $(EXEC) $(RUNSRC) $(RUNDEP)	
	python $(RUNSRC) $(EXEC)

#Step 3
analyze: $(GNUDEP)

$(GNUDEP): $(ANSRC) $(ANDEP)
	python $(ANSRC)

#Step 4
plot: $(SCATTER) $(LINEPLOT) $(SPEEDPLOT) $(ERRORPLOT)

$(SCATTER): plot1.p $(GNUDEP)
	gnuplot -e "filename='output1.txt'; out='sc1.eps'; thread='1'" plot1.p ;\
	gnuplot -e "filename='output2.txt'; out='sc2.eps'; thread='2'" plot1.p ;\
	gnuplot -e "filename='output4.txt'; out='sc4.eps'; thread='4'" plot1.p ;\
	gnuplot -e "filename='output8.txt'; out='sc8.eps'; thread='8'" plot1.p ;\
	gnuplot -e "filename='output16.txt'; out='sc16.eps'; thread='16'" plot1.p ;

$(LINEPLOT): plot2.p $(GNUDEP)
	gnuplot -e "filename='mean_var.txt'; out='lineplot.eps'" plot2.p

$(SPEEDPLOT): plot3.p $(GNUDEP)
	gnuplot -e "filename='mean_var.txt'; out='speedplot.eps'" plot3.p

$(ERRORPLOT): plot4.p $(GNUDEP)
	gnuplot -e "filename='mean_var.txt'; out='errorplot.eps'" plot4.p

#Step 5
report: report.pdf

report.pdf: $(SCATTER) $(LINEPLOT) $(SPEEDPLOT) $(ERRORPLOT) report.tex
	rm -f *.pdf report.log report.aux report.dvi && pdflatex report.tex

.PHONY: clean cleanlog cleaneps App runtest analyze plot report

clean: cleanlog cleaneps cleanlatex
	rm -f $(OBJECTS) $(EXEC)

cleanlog: $(ANDEP) $(GNUDEP)
	rm -f $(ANDEP) $(GNUDEP)

cleaneps: 
	rm -f *.eps

cleanlatex:
	rm -f *.pdf report.log report.aux report.dvi
