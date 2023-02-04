AS = arm-none-eabi-as 
LD = arm-none-eabi-ld
OBJ = arm-none-eabi-objcopy
LDFRAGS = -m armelf
OBJFLAGS = -O binary



%.img: %.elf
	$(OBJ) $< $(OBJFLAGS) $@
	rm *.o *.elf
sound.elf: sound.o settings.o
	$(LD) $(LDFRAGS) $+ -o $@

test.elf: test.o settings.o sound.o debug.o
	$(LD) $(LDFRAGS) $+ -o $@

jiho.elf: jiho.o display_row.o settings.o jiho_command.o
	$(LD) $(LDFRAGS) $+ -o $@

music.elf: music.o settings.o 
	$(LD) $(LDFRAGS) $+ -o $@

fade.elf: fade.o settings.o
	$(LD) $(LDFRAGS) $+ -o $@

doremi.elf: doremi.o
	$(LD) $(LDFRAGS) $+ -o $@

ra.elf: ra.o settings.o
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
