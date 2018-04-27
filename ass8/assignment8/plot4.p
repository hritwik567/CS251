set terminal postscript eps enhanced color
set output out

set title "Plot for average speedup error"
set xlabel "Number of elements"
set ylabel "Average Speedup Error" offset -1
set key top left
set yrange[0:]

set style histogram errorbars lw 3
set style data histogram

plot filename u ($2/$2):($3*$2*$2):xticlabels(1) title "Threads = 1" fillstyle pattern 7, \
'' u ($2/$4):($5*$2*$2) title "Threads = 2" fillstyle pattern 9, \
'' u ($2/$6):($7*$2*$2) title "Threads = 4" fillstyle pattern 12, \
'' u ($2/$8):($9*$2*$2) title "Threads = 8" fillstyle pattern 14, \
'' u ($2/$10):($11*$2*$2) title "Threads = 16" fillstyle pattern 17
