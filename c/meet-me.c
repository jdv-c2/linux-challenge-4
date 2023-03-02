#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
   setuid(geteuid());
   system("figlet NICE TO MEET YOU");
   system("whoami");
   system("/usr/bin/whoami");
   return 0;
}

