#!/usr/bin/env python

import sys

if sys.version_info > (3,):
    long = int
    xrange = range

S_0 = 290797
S = S_0

def brute(m):
    s_s = [S_0]
    for i in xrange(1,m+1):
        s_s.append((s_s[-1] * s_s[-1]) % 50515093)

    mysum = long(0)
    for i in xrange(1,m+1):
        for j in xrange(i,m+1):
            mysum += min(s_s[i:(j+1)])

    return mysum

a = []
s = long(0)

m = 10000
for j in xrange(1,m+1):
    S = ((S * S) % 50515093)
    n = []
    i = j
    for t in a:
        tS = t['S']
        if tS > S:
            if t['i'] < i:
                i = t['i']
        else:
            n.append(t)
    n.append({'i':i,'S':S})
    a = sorted(n,key=lambda (t):t['i'])
    for t in xrange(0,len(a)):
        bottom = (1 if t == 0 else a[t]['i'])
        top = (j if t == len(a)-1 else a[t+1]['i']-1)
        val = (a[t]['S'] if t < len(a) else S)
        s += val * (top - bottom +1)
    # s -= S
    # if (s != brute(j)):
      #  print("Wrong for N=%d ; good=%d bad=%d" % (j, brute(j), s))
      #  raise RuntimeError

print(("M(%d) = %d") % (m, s))
