AS = arm-none-eabi-as 
LD = arm-none-eabi-ld
LDFRAGS = -T ../raspbian.lds -m armelf

.PHONY: clean copy-hello
hello: hello.o
	$(LD) $(LDFRAGS) $+ -o $@

%.o: %.s
	$(AS) $< -o $@

copy-hello: hello
	scp $< 172.21.43.173:

c-hello_sm: hello
	scp $< 172.21.43.172:

clean:
	rm -f *.o *~ *.out hello
