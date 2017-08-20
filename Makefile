ROOTPATH=$(shell pwd)
CONF=$(ROOTPATH)/conf
WWWROOT=$(ROOTPATH)/wwwroot
RELEASE=$(ROOTPATH)/release
CFLAGS=-D_DEBUG_
LDFLAGS=-lpthread
BIN=httpd
SRC=$(wildcard *.cpp)
OBJ=$(patsubst %.cpp,%.o,$(SRC))
WARNINGS=-Wall

$(BIN):$(OBJ)
	$(CXX) $^ -o $@ $(LDFLAGS) -O3 

%.o:%.c
	$(CXX) -c $< $(LDFLAGS) 

.PHONY:clean install 
clean:
	@cd cgi;make clean;
	@cd sql_cgi;make clean;
	@rm -rf $(OBJ) $(BIN) $(RELEASE)
	@rm -rf tmp/*

install: 
	@cd cgi;make;
	@cd sql_cgi; make;
	@mkdir -p $(WWWROOT)/cgi-bin
	@mkdir -p $(RELEASE)
#@cp $(ROOTPATH)/sql_cgi/xxxxxx $(WWWROOT)/cgi-bin
	@cp $(ROOTPATH)/cgi/calculator $(WWWROOT)/cgi-bin
	@cp $(ROOTPATH)/cgi/compiler $(WWWROOT)/cgi-bin
	@cp -r $(WWWROOT) $(RELEASE)
	@cp httpd $(RELEASE)
