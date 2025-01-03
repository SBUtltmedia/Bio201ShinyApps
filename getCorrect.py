import sys
import re
rightAnswers=[]
with open(sys.argv[1], 'r') as x:f = x.readlines()
for line in f:
    m = re.search(r'correct.vec = c\(([^\)]*)', line)
    if m!=None:
        rightAnswers.append(m.group(1).replace('"',"").split(","))
        print(m.group(1).replace('"',""))
print(rightAnswers)