ROOTPATH=$(shell pwd)
CONF=$(ROOTPATH)/conf
WWWROOT=$(ROOTPATH)/wwwroot
RELEASE=$(ROOTPATH)/release
CFLAGS=-D_DEBUG_
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
	@cd cgi;make clean;
	@cd sql_cgi;make clean;
	@rm -rf $(OBJ) $(BIN) $(RELEASE)/*

install: 
	@cd cgi;make;
	@cd sql_cgi; make;
	@mkdir -p $(RELEASE)
	@cp $(ROOTPATH)/sql_cgi/proxy_ip $(WWWROOT)/cgi-bin
	@cp $(ROOTPATH)/cgi/calculator $(WWWROOT)/cgi-bin
	@cp -r $(WWWROOT) $(RELEASE)
	@cp httpd $(RELEASE)
