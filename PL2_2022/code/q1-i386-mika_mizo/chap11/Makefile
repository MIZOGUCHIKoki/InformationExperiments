AS = nasm -felf
LD = ld -m elf_i386

testf: print_eax_int.o max_abs.o  test.o print_eax.o
	$(LD) $+ -o $@

%.o: %.s
	$(AS) $<

.PHONY: clean test

clean:
	rm -f *.o *~ *.out

test: testf
	./testf
