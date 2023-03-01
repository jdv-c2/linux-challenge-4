#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>

#define MAX_TICKET_LENGTH 20
#define PATH "/usr/share/.linux-adventures/"

int main(){
   char ticket[MAX_TICKET_LENGTH];
   char correct_ticket[] = "2023-CI-CY-219";
   
   if (getuid() == 6543) {
      printf("Tickets please!\n");
      printf("Enter your ticket_number: ");
      fgets(ticket, MAX_TICKET_LENGTH, stdin);

      ticket[strcspn(ticket, "\n")] = 0;

      if (strcmp(ticket correct_ticket) == 0) {
         system("/bin/cat " PATH "hotel/doorman"); 
      } else {
         printf("Invalid ticket. Try again.\n");
      }
   } else {
      printf("Only the doorman can operate the ticket scanner!\n");
   }

   return 0;
}
