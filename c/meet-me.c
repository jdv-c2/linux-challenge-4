#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>

int main()
{
   setuid(geteuid());
   system("figlet NICE TO MEET YOU");
   return 0;
}

