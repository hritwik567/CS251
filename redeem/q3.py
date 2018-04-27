from __future__ import print_function
import sys
import numpy as np

def print_level(s, e, level, h):
    if e<s:
        print(' '*sp,end='')
        return

    m = int((e+s)/2)
    if level==0:
        spaces = ' '*sp*int(2**(h-1)-1)
        print(spaces,str(inp[m-1]).rjust(sp),spaces,end='',sep='')
    else:
        print_level(s,m-1,level-1,h)
        print(' '*sp,end='')
        print_level(m+1,e,level-1,h)





if len(sys.argv[1:])==0:
    print("Expected atleast 1 arguments found none")
    quit()

inp = []
sp = 1
for i in sys.argv[1:]:
    if len(i) > sp:
        sp = len(i)
    inp.append(int(i))

inp = np.sort(inp)
height = int(np.ceil(np.log2(len(inp)+1)))

for i in range(height):
    print_level(1,len(inp),i,height-i)
    print()
