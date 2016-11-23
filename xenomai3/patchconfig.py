# Simple Kernel Config Patcher
#
# Removes the not required options from the list and adds other to the end (without checking)
import sys,re


changes = open(sys.argv[1],"r").read().split("\n")

aadd =[]
ra = []
for x in changes:
	x = x.strip()
	if len(x) == 0:
		continue
	if x[0] == "-":
		if x[-1] != "*":
			ra.append("%s=y" % x[1:])
		else:
			ra.append("%s.+=.*" % x[1:-1])
			pass
	else:
		# appeneded
		aadd.append(x)
		pass
print ra
rai = re.compile("|".join(ra))

for y in sys.stdin:
	l = y.strip()
	if rai.match(l):
		continue
	print l

for x in aadd:
	print x