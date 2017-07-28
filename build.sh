#!/bin/bash
make;make install
PWD=`pwd`
mysql_lib=${PWD}/sql_conn/lib
export LD_LIBRARY_PATH=$mysql_lib
