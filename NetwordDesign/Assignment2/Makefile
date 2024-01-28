CC = gcc
CFLAGS = 
OBJS = client.o ErrorHandling.o
HOST = localhost
PORT = 1234
MSG = "test"
PROGRAM = client

all: $(PROGRAM)

$(PROGRAM): $(OBJS)
	$(CC) $(CFLAGS) -o $@ $^
# $^ means all the files on the right side of the colon (list of dependencies).
# $@ means the file on the left side of the colon (the target name).
# $< means the first item in the dependencies list.
# $? means all the dependencies that are newer than the target.

%.o: %.c
	$(CC) $(CFLAGS) -c $<
# -c means compile only, do not link.(generate .o file)

.PHONY: clean
clean:
	rm -f *.o $(PROGRAM) a.out
exec: $(PROGRAM)
	./$(PROGRAM) $(HOST) $(MSG) $(PORT)