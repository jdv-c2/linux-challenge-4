#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
   setuid(geteuid());
   system("whoami");
   return 0;
}



