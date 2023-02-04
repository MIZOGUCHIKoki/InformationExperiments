AS = nasm -felf
LD = ld -m elf_i386

testf: print_eax_frac.o average.o cos.o test.o print_eax.o print_eax_int.o
	$(LD) $+ 

%.o: %.s
	$(AS) $<

.PHONY: clean test

clean:
	rm -f *.o *~ *.out 

test:	testf
	./a.out | cat -v

