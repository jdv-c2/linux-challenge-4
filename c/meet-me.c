#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
   setuid(geteuid());
   system("/usr/bin/whoami | figlet");
   system("/usr/bin/echo");" 
   return 0;
}

