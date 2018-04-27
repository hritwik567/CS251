set terminal postscript eps enhanced color
set output out

set title "Line plot for average time"
set xlabel "Number of elements(Logscale)"
set ylabel "Average Exececution Time in Microseconds" offset -1
set key top left
set xrange[900:10000000]
set logscale x 10

plot filename using 1:2 title "Threads = 1" with linespoints, \
	'' using 1:4 title "Threads = 2" with linespoints, \
	'' using 1:6 title "Threads = 4" with linespoints, \
	'' using 1:8 title "Threads = 8" with linespoints, \
	'' using 1:10 title "Threads = 16" with linespoints
