import os
import sys

n = 100.0

threads = [1,2,4,8,16]
calc = []

for i in threads:
	file = "output" + str(i) + ".txt"
	f = open(file,"r")
	temp = f.read()
	f.close()
	if temp[-1] == "\n":
		temp = temp[:-1]
	temp = temp.split("\n")
	mean_var = dict()
	for out in temp:
		a = out.split(" ")
		b = mean_var.get(a[0],(0.0,0.0,0.0))
		mean_var[a[0]] = (b[0]+float(a[2]),b[1]+(1.0/float(a[2])**2),b[2] + (1.0/float(a[2])))
	calc.append(mean_var)


f = open("mean_var.txt","w")
for key in calc[0]:
	output = key
	for i in range(len(threads)):
		mv = calc[i][key]
		mean1 = mv[0]/n
		mean = mv[2]/n
		variance = (mv[1] - n*(mean**2))/n
		output = output + " " + str(mean1) + " " + str(variance)	
	f.write(output + "\n")
f.close()			
