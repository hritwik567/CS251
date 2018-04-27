from __future__ import print_function
import os
import sys
import subprocess as sub

executable = "./" + sys.argv[1]

threads = os.path.join(os.curdir, "threads.txt")
params = os.path.join(os.curdir, "params.txt")

#open threads.txt
f = open(threads, "r")
threads = f.read()
f.close()
if threads[-1] == "\n":
	threads = threads[:-1]
threads = threads.split(" ")


#open params.txt
f = open(params, "r")
params = f.read()
f.close()
if params[-1] == "\n":
	params = params[:-1]
params = params.split(" ")

for thread in threads:
	file = "output" + thread + ".txt"
	f = open(file, "w")
	for elem in params:
		for i in range(100):
			p = sub.Popen([executable, elem, thread],stdout=sub.PIPE,stderr=sub.PIPE)
			out, _ = p.communicate()
			out = out[13:]
			out = out[:-11]
			f.write(elem + " " + thread + " " + out + "\n")
	f.close()
