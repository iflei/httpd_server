ROOTPATH=$(shell pwd)
MYSQL_INC=$(ROOTPATH)/include
MYSQL_LIB=$(ROOTPATH)/lib
BIN=proxy_ip
SRC=$(wildcard *.cpp)
OBJ=$(patsubst %.cpp,%.o,$(SRC))

$(BIN):$(OBJ)
	$(CXX) $^ -o $@ -L$(MYSQL_LIB) -lmysqlclient
%.o:%.cpp
	$(CXX) -c $< -I$(MYSQL_INC)
.PHONY:clean
clean:
	rm -rf $(OBJ) $(BIN)
