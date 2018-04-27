from __future__ import print_function
import sys
import re

def check(letter, base):
    if letter == '-':
        return True

    if letter >= '0' and letter <= '9':
        return (base > (ord(letter)-ord('0')))

    if letter >= 'A' and letter <= 'Z':
        return (base-10 > (ord(letter)-ord('A')))

    if letter == '.':
        return True

    return False



def convert(number, base):
    flag = 0
    
    if number[0] == '-':
        flag = 1
        number = number[1:]
    
    if '.' in number:
        head = number.split('.')[0]
        tail = number.split('.')[1]
    else:
        head = number
        tail = False
    head_dec = 0
    tail_dec = 0

    for i in range(len(head)):
        power = len(head)-i-1
        if head[i] >= '0' and head[i] <= '9':
            head_dec = head_dec + (ord(head[i])-ord('0'))*(base**power)

        if head[i] >= 'A' and head[i] <= 'Z':
            head_dec = head_dec + (ord(head[i])-ord('A')+10)*(base**power)

    if tail:
        for i in range(len(tail)):
            power = i+1
            if tail[i] >= '0' and tail[i] <= '9':
                tail_dec = tail_dec + (ord(tail[i])-ord('0'))/(base**power)

            if tail[i] >= 'A' and head[i] <= 'Z':
                tail_dec = tail_dec + (ord(tail[i])-ord('A')+10)/(base**power)
    
    head_dec *= -1 if flag==1 else 1
    tail_dec *= -1 if flag==1 else 1
    if tail_dec:
        return (head_dec+tail_dec)
    else:
        return head_dec

if len(sys.argv[1:])!=2:
    print("Expected 2 arguments found {}".format(len(sys.argv[1:])))
    quit()

number = sys.argv[1]
base = sys.argv[2]

p1 = re.compile("[0-9]+([\.][0]+)?")

if p1.fullmatch(base)==None:
    print("Invalid base")
    quit()
else:
    base = convert(base.split('.')[0],10)

if base<2 or base>36:
    print("Base out of bounds")
    quit()

p1 = re.compile("([-]?[0-9a-zA-Z]*[\.]?[0-9a-zA-Z]*)")
p2 = re.compile("((\.)|(\-)|(\-\.))")
if p1.fullmatch(number)==None or p2.fullmatch(number):
    print("invalid input")
    quit()

number = number.upper()

for i in range(len(number)):

    if not check(number[i],base):
        print("invalid input")
        quit()


print(convert(number,base))    
