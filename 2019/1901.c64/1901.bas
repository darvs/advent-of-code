12 print "the tyranny of the rocket equation"
20 open 1,8,2,"0:1901.seq,s,r"
21 t = 0: t2 = 0
25 for l = 0 to 1
30   input#1,m
35   f = int(m/3)-2
40   t = t + f
42   for l2 = 0 to 1
43     if f > 0 then l2 = 0
44     if f < 0 then f = 0
45     t2 = t2 + f
47     f = int(f/3)-2
49   next l2
50   l=255 and st
60 next l
70 close 1
75 print "total #1: ";: print t
78 print "total #2: ";: print t2
80 if st and 64 then print "ok"
