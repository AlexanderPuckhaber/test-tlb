test-tlb: test-tlb.c
	gcc -g -Wall -O test-tlb.c -o test-tlb -lm

run: test-tlb
	for i in 4k 8k 16k 32k 64k 128k 256k 512k 1M 2M 4M 6M 8M 16M 32M 64M 128M 256M ; do echo "$$i:"; ./test-tlb -H $$i 64; ./test-tlb $$i 64 ; ./test-tlb -Hr $$i 64; ./test-tlb -r $$i 64; done

my_run: test-tlb
	for s in 64 128 256 512 1024 2048 4096 8192 16384 ; do echo "$$i:"; perf stat -e dTLB-loads-misses,dTLB-loads ./test-tlb 2G $$s ; done
#
# 15485863 is a random prime number that is used as a index into
# the 128MB array. 15485863*4=61943452
odd-case: test-tlb
	./test-tlb 128M 61943452
