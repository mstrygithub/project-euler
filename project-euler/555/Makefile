all: euler555.exe

euler555.exe: euler555.cpp
	g++ -std=gnu++14 -O3 -march=native -flto -fwhole-program -fomit-frame-pointer -o $@ $<

test:
	PYTHONPATH="`pwd`" prove t/*.py
