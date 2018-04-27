set terminal postscript eps enhanced color
set output out

set xlabel "Number of elements(Logscale)"
set ylabel "Time in Microseconds" offset -1
set key top right
set title "Scatter plot for threads = ".thread
set xrange[900:10000000]
set logscale x 10
plot filename using 1:3 title "Points" with points 
