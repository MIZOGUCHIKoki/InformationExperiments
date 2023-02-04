AS = arm-none-eabi-as 
LD = arm-none-eabi-ld
LDFRAGS = -T ../raspbian.lds -m armelf

.PHONY: clean mizo mika

%: %.s

%: %.o print_r0.o
	$(LD) $(LDFRAGS) $+ -o $@

%.o: %.s
	$(AS) $< -o $@

%.o: %.o



mika: isprime
	scp $< 172.21.43.172:

clean:
	rm -f *.o *~ *.out print_r0 tribo grouping test
