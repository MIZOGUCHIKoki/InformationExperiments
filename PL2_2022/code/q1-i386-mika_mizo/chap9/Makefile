AS = nasm -felf
LD = ld -m elf_i386

test_sort: test_sort.o sort.o print_eax.o
	$(LD) $+ -o $@

%.o: %.s
	$(AS) $<

.PHONY: clean test

clean:
	rm -f *.o *~ *.out 

test: test_sort answer.txt
	./test_sort | diff - answer.txt
