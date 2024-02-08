CC = gcc
CFLAGS = 
CMOBJS = myio.o
SOBJS = server.o $(CMOBJS)
COBJS = client.o $(CMOBJS)
HOST = localhost
PORT = 10000
CLIENT = Client.out
SERVER = Server.out

$(CLIENT): $(COBJS)
	$(CC) $(CFLAGS) -o $@ $^
$(SERVER): $(SOBJS)
	$(CC) $(CFLAGS) -o $@ $^
# $^ means all the files on the right side of the colon (list of dependencies).
# $@ means the file on the left side of the colon (the target name).
# $< means the first item in the dependencies list.
# $? means all the dependencies that are newer than the target.

%.o: %.c
	$(CC) $(CFLAGS) -c $<
# -c means compile only, do not link.(generate .o file)

.PHONY: clean client server
clean:
	rm -f *.o *.out
server: $(SERVER)
	./$(SERVER)
client: $(CLIENT)
	./$(CLIENT) $(HOST) $(PORT)
