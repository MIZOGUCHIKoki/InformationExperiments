AS = nasm -felf
LD = ld -m elf_i386

testf: print_eax_hex.o mul_10k.o print_eax.o mul_edx.o exp.o
	$(LD) $+ -o $@

%.o: %.s
	$(AS) $<

testo: FACT.o MULT.o exp2.o print_eax.o 
	$(LD) $+ -o $@
  
.PHONY: clean test

clean:
	rm -f *.o *~ *.out 

test:	testf
	./testf
