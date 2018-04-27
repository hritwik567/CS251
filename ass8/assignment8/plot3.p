set terminal postscript eps enhanced color
set output out

set title "Plot for average speedup time"
set xlabel "Number of elements(Logscale)"
set ylabel "Average Speedup" offset -1
set key top left

set style data histograms
set style histogram cluster
set style fill pattern border

plot filename u ($2/$2):xticlabels(1) title "Threads = 1" fillstyle pattern 7, \
'' u ($2/$4) title "Threads = 2" fillstyle pattern 9, \
'' u ($2/$6) title "Threads = 4" fillstyle pattern 12, \
'' u ($2/$8) title "Threads = 8" fillstyle pattern 14, \
'' u ($2/$10) title "Threads = 16" fillstyle pattern 17
