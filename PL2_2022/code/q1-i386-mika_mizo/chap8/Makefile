AS = nasm -felf
LD = ld
LDFLAGS = -m elf_i386

test_memsqsum: test_memsqsum.o memsqsum.o
	$(LD) $(LDFLAGS) $+ -o $@

%.o: %.s
	$(AS) $<

.PHONY: clean test

clean:
	rm -f *.o *~ *.out 

test: test_memsqsum
	./test_memsqsum
	make clean
