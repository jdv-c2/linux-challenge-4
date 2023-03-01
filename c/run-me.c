#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define MAX_PASSWORD_LENGTH 20
#define PATH "/usr/share/.linux-adventures/"

int main() {
   char password[MAX_PASSWORD_LENGTH];
   char correct_password[] = "cert_team_123!";

   printf("Enter your password: ");
   fgets(password, MAX_PASSWORD_LENGTH, stdin);

   // Remove trailing newline character
   password[strcspn(password, "\n")] = 0;

   if (strcmp(password, correct_password) == 0) {
      printf("Login successful!\n");
   } else {
      printf("Incorrect password. Try again.\n");
   }

   return 0;
}

