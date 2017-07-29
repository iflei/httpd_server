#include <pthread.h>
#include "httpd.h"
#include "thread_pool.h"

void* accept_request(void* arg)
{
	int sock = (int)arg;
	//线程分离,无需主线程等待
	//pthread_detach(pthread_self()); //线程池不需要线程退出
	return (void*)request_handle(sock);
}

int main(int argc, char* argv[])
{
	//先从配置文件读
	
	int listen_sock;
	if(argc == 2)
	  listen_sock = startup(atoi(argv[1]));
	else if(argc == 1) //使用默认端口
	  listen_sock = startup(8888);
	else
	{
		printf("Usage: %s [listen port]\n", argv[0]);
		exit(0);
	}

	daemon(1, 0);//守护进程
	//第一个参数为0工作目录更改为根目录/
	//第二个参数为0默认打开的三个文件描述符重定向到/dev/null
	
	struct sockaddr_in remote;
	socklen_t len = sizeof(remote);

	//创建线程池
	if (tpool_create(8) != 0) {
		print_log("tpool_create failed", FATAL, __FILE__, __LINE__);
		exit(1);
	}

	while(1)
	{
		int conn_sock = accept(listen_sock, (struct sockaddr*)&remote, &len);
		if(conn_sock < 0)
		{
			print_log(strerror(errno), WARNING, __FILE__, __LINE__);
			continue;
		}
		//printf("New Connection! %s:%d\n", inet_ntoa(remote.sin_addr), ntohs(remote.sin_port));

		//pthread_t id;
		//if(pthread_create(&id, NULL, accept_request, (void*)conn_sock) != 0)
		//{
		//	print_log(strerror(errno), FATAL, __FILE__, __LINE__);
		//	close(conn_sock);
		//}

		if(tpool_add_work(accept_request, (void*)conn_sock) != 0)
		{
			print_log("tpool_add_work failed", FATAL, __FILE__, __LINE__);
			close(conn_sock);
		}
	}

	close(listen_sock);
	tpool_destroy();
	return 0;
}
