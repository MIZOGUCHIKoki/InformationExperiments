AS = arm-none-eabi-as 
LD = arm-none-eabi-ld
OBJ = arm-none-eabi-objcopy
LDFRAGS = -m armelf
OBJFLAGS = -O binary



%.img: %.elf
	$(OBJ) $< $(OBJFLAGS) $@
	rm *.o *.elf 

count100sec.elf: count100sec.o display_row.o
	$(LD) $(LDFRAGS) $+ -o $@

bar.elf: bar.o 
	$(LD) $(LDFRAGS) $+ -o $@

ledtask.elf: ledtask.o
	$(LD) $(LDFRAGS) $+ -o $@

stopwatch.elf: stopwatch.o display_row.o writeProcess.o read_switch.o
	$(LD) $(LDFRAGS) $+ -o $@

%.elf: %.o 
	$(LD) $(LDFRAGS) $< -o $@

%.o: %.s 
	$(AS) $< -o $@

%: %.s

.PHONY: clean mizo mika 

mizo: file
	scp $< 250373b@172.21.43.173:
mika: file
	scp $< 172.21.43.172:

clean:
	rm -f *.o *~ *.out *.img *.elf
