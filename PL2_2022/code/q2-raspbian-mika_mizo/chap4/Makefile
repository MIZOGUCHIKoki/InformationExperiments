AS = arm-none-eabi-as 
LD = arm-none-eabi-ld
LDFRAGS = -T ../raspbian.lds -m armelf

.PHONY: clean mizo mika

%: %.s

%: %.o
	$(LD) $(LDFRAGS) $+ -o $@

%.o: %.s
	$(AS) $< -o $@

%.o: %.o


mizo: hms
	scp $< 250373b@172.21.43.173:

mika: isprime
	scp $< 172.21.43.172:

clean:
	rm -f *.o *~ *.out max range printdec
