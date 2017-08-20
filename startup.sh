#!/bin/bash
PWD=`pwd`
mysql_lib=${PWD}/sql_conn/lib
export LD_LIBRARY_PATH=$mysql_lib
bin=httpd
conf=${PWD}/conf/httpd.conf

function usage()
{
	printf "Usage: %s start(-s) | stop(-t) | restart(-r)\n" "$0"
}

function start()
{
	pid=`pidof $bin`
	if [ $? -eq 0 ]
	then
		printf "httpd already running!\npid id $pid\n"
		return
	fi

	port=$(grep -E 'PORT' $conf | awk '{print $NF}')
	./$bin $port
	pid=`pidof $bin`
	printf "httpd start, OK!\npid is $pid\n"
}

function stop()
{
	pid=`pidof $bin`
	if [ $? -ne 0 ]
	then
		printf "httpd id not running!\nfailed\n"
		return
	fi

	killall $bin
	printf "httpd stoped, OK!\n"
}

if [ $# -ne 1 ]
then
	usage
	exit 1;
fi

case $1 in
	start | Start | -s | -S)
		start
	;;
	stop | Stop | -t | -T)
		stop
	;;
	restart | Restart | -r | -R)
		stop
		start
	;;
	*)
		usage
		exit 2
	;;
esac
