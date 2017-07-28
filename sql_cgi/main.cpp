#include "mysql_api.h"

int main(int argc, char** argv)
{
	if(argc != 4)
	  printf("error\n");

	char buf[1024];
	sprintf(buf, "insert into proxy_ip(conn_ip, remote_ip, remote_domain, access_time) values('%s', '%s', '%s', now())",argv[1], argv[2], argv[3]);
	DataBase db;
	if(!db.Connect())
	  return -1;

	db.Insert(buf);
	db.Select("select * from proxy_ip");
	return 0;
}
