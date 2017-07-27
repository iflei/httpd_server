ROOTPATH=$(shell pwd)
CONF=$(ROOTPATH)/conf
WWWROOT=$(ROOTPATH)/wwwroot
RELEASE=$(ROOTPATH)/release
CFLAGS=-D_DEBUG_
CXXFLAGS= #
LDFLAGS=-lpthread
BIN=httpd
SRC=$(wildcard *.c)
OBJ=$(patsubst %.c,%.o,$(SRC))
WARNINGS=-Wall

$(BIN):$(OBJ)
	$(CC) $^ -o $@ $(LDFLAGS)

%.o:%.c
	$(CC) -c $< $(LDFLAGS) $(WARNING)

.PHONY:clean install 
clean:
	rm -rf $(OBJ) $(BIN) $(RELEASE)/*

install: 
	@mkdir -p $(RELEASE)
	@cp $(ROOTPATH)/cgi/calculator $(WWWROOT)/cgi-bin
	@cp -r $(WWWROOT) $(RELEASE)
	@cp httpd $(RELEASE)
