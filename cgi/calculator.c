#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>

#define SIZE 8192

static int calculator(char* query)
{
	char* cur = query;
	while(*cur != '&')
	  cur++;
	
	*cur = 0;
	cur++;

	while(*query++ != '=');
	while(*cur++ != '=');
	int num1 = atoi(query);
	int num2 = atoi(cur);
	
	int add = num1 + num2;
	int sub = num1 - num2;
	int mul = num1 * num2;
	int div = 0;
	if(num2)
		div = num1 / num2;
	printf("add = %d<br/>", add);
	printf("sub = %d<br/>", sub);
	printf("mul = %d<br/>", mul);
	printf("div = %d<br/>", div);
	return 0;
}

int main()
{
	char method[SIZE/16];
	int content_len;
	char query[SIZE];
	if(getenv("METHOD") != NULL)
		strcpy(method, getenv("METHOD"));
	
	if(strcasecmp(method, "GET") == 0 && getenv("QUERY") != NULL)
		strcpy(query, getenv("QUERY"));
	else if(getenv("CONTENTLENGTH") != NULL)
	{
	    content_len = atoi(getenv("CONTENTLENGTH"));
	    ssize_t s = read(0, query, content_len);
		if(s > 0)
		  query[s] = '\0';
	}
	else
		printf("getenv error\n");

	return calculator(query);
}
