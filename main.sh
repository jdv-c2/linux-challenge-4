#!/bin/bash

# Provisioner script for third Linux adventures campaign
# Author: Johan de Vries 

set -e

main()
{  
   # Making birthday hotel 
   mkdir -p /birthday 2>/dev/null
   mv hotel/hotel /birthday/welcome.txt
   mkdir -p /birthday/floor-{1..8}/
   mkdir -p /birthday/{grand-ballroom,.basement}

   for i in {1..8}; do 
      mkdir /birthday/floor-${i}/room-${i}{01..24}; 
      for j in {01..24}; do 
         echo "Don't look through my stuff, nothing to see here!" > /birthday/floor-${i}/room-${i}${j}/suitcase
         echo "Once upon a time there was a hacker group called Circus Cyber..." > /birthday/floor-${i}/room-${i}${j}/book
         echo "I said, ooh, I'm blinded by the lights..." > /birthday/floor-${i}/room-${i}${j}/sunglasses
      done 
   done 

   # Create directory in /usr/share/
   mkdir -p /usr/share/.linux-adventures/{badge,hotel}

   # Setup groups
   groupadd -g 2000 business_development
   groupadd -g 3000 sales 
   groupadd -g 4000 training 
   groupadd -g 5000 compliance 
   groupadd -g 6000 analysts 
   groupadd -g 6543 circus_cyber

   # Normal users
	useradd john -m -s /bin/bash -c "John Tucker, 201, 877-555-2423,,Business Developer" -G 2000 2>/dev/null
	useradd alice -m -s /bin/bash -c "Alice Wonder, 202, 877-555-3112,,Sales" -G 3000 2>/dev/null
	useradd bob -m -s /bin/bash -c "Bob T. Miller, 203, 877-555-5144,,Internal Compliance" -G 5000 2>/dev/null
	useradd tutor -m -s /bin/bash -c "Jonathan Ben Ilan, 203,,,Cyber Instructor" -G 4000 2>/dev/null 
	useradd jenny -m -s /bin/bash -c "jenny davis, 201, 877-555-1212,,Junior data-analyst" -G 6000 2>/dev/null

   # Circus Cyber
   useradd circus_c -M -d /birthday/floor-8/room-824 -s /bin/sh -G 6543 2> /dev/null  
   chown -R circus_c:circus_cyber /birthday 
   chmod 700 /birthday/floor-{1..8}/room-*
   chmod 755 /birthday/floor-8/room-824

   useradd doorman_x -M -d /birthday/grand-ballroom -s /bin/bash -u 6543 -G 6543 2> /dev/null 

	useradd elephant_p -M -d /birthday/floor-1/room-101 -s /bin/bash -G 6543 2> /dev/null  
   cp /etc/skel/{.bashrc,.bash_logout,.profile} /birthday/floor-1/room-101/
   echo "cd /birthday/grand-ballroom" >> /birthday/floor-1/room-101/.bashrc
   chown -R  elephant_p:circus_cyber /birthday/floor-1/room-101

	useradd rabbit_r -M -d /birthday/floor-5/room-505 -s /bin/sh -G 6543 2> /dev/null  
   chown -R rabbit_r:rabbit_r /birthday/floor-5/room-505 

   useradd fortune_m -M -d /birthday/floor-6/room-603 -s /bin/sh -G 6543 2> /dev/null
   chown -R fortune_m:fortune_m /birthday/floor-6/room-603 

   cp /bin/bash /bin/clownshell
	useradd clown_e -M -d /birthday/floor-7/room-707 -s /bin/clownshell -G 6543 2> /dev/null  
   cp /etc/skel/{.bashrc,.bash_logout,.profile} /birthday/floor-7/room-707/
   echo "cd /birthday/grand-ballroom" >> /birthday/floor-7/room-707/.bashrc
   chown -R clown_e:clown_e  /birthday/floor-7/room-707

   # Guests
	useradd guest_1 -M -d /birthday/floor-2/room-202 -s /bin/bash -G 6543 2> /dev/null  
	useradd guest_2 -M -d /birthday/floor-2/room-204 -s /bin/bash -G 6543 2> /dev/null  

	useradd guest_3 -M -d /birthday/floor-2/room-208 -s /bin/bash -G 6543 2> /dev/null  
   cp /etc/skel/{.bashrc,.bash_logout,.profile} /birthday/floor-2/room-208/
   echo "cd /birthday/grand-ballroom" >> /birthday/floor-2/room-208/.bashrc
   chown -R guest_3:circus_cyber /birthday/floor-2/room-208

	useradd guest_4 -M -d /birthday/floor-2/room-212 -s /bin/bash -G 6543 2> /dev/null  
	useradd guest_5 -M -d /birthday/floor-2/room-214 -s /bin/bash -G 6543 2> /dev/null  

   chpasswd < .passwords

   # Application
   apt update && apt install -y gcc binutils figlet 

   # ---> Target 1 <---
   mkdir -p /home/tutor
   cp tutor/instruction-1 /home/tutor/ReadMe
   cp badge/badge /usr/share/.linux-adventures/badge/
   cp badge/badge.jpg tutor/badge-2  
   chmod 000 tutor/open-me
   gcc c/run-me.c -o tutor/run-me 
   chmod 444 tutor/run-me 

   tar -czf /home/tutor/exercises.tar.gz -C tutor exercise-{1..7} open-me run-me badge-2

   echo "tutor    ALL=(doorman_x) NOPASSWD: /birthday/grand-ballroom/ticket-scanner" >> /etc/sudoers

   # ---> Target 2 <---
   # Empty tables
   figlet "Guest 1" > /birthday/grand-ballroom/table-1
   chown guest_1: /birthday/grand-ballroom/table-1
   
   figlet "Guest 2" > /birthday/grand-ballroom/table-2
   chown guest_2: /birthday/grand-ballroom/table-2

   figlet "Guest 4" > /birthday/grand-ballroom/table-4
   chown guest_4: /birthday/grand-ballroom/table-4
   
   figlet "Guest 5" > /birthday/grand-ballroom/table-5
   chown guest_5: /birthday/grand-ballroom/table-5

   # Mission 1
   cp hotel/doorman /usr/share/.linux-adventures/hotel/ 
   gcc c/ticket-scanner.c -o /birthday/grand-ballroom/ticket-scanner
   chown doorman_x:circus_cyber /birthday/grand-ballroom/ticket-scanner

   # Mission 2
   cp hotel/table-3 /birthday/grand-ballroom/table-3
   chown guest_3: /birthday/grand-ballroom/table-3
   echo "The password of the elephant is: w7GTfP2z" > /birthday/floor-2/room-208/.secret 
   chown guest_3: /birthday/floor-2/room-208/.secret
   chmod 000 /birthday/floor-2/room-208/.secret

   # Mission 3  
   cp hotel/table-6 /birthday/grand-ballroom/table-6  
   chown elephant_p: /birthday/grand-ballroom/table-6
   cp hotel/elephant.jpeg /birthday/floor-1/room-101/elephant
   chown elephant_p: /birthday/floor-1/room-101/elephant

   # Mission 4
   cp hotel/table-7 /birthday/grand-ballroom/table-7  
   chown rabbit_r: /birthday/grand-ballroom/table-7

   echo "rabbit_r    ALL=(root) NOPASSWD: /usr/sbin/adduser" >> /etc/sudoers
   echo "wizard_o    ALL=(fortune_m) NOPASSWD: /bin/cat /birthday/floor-6/room-603/*" >> /etc/sudoers

   cp hotel/table-8 /birthday/grand-ballroom/table-8  
   chown fortune_m: /birthday/grand-ballroom/table-8

   # Mission 5
   cp hotel/table-9 /birthday/grand-ballroom/table-9  
   chown clown_e: /birthday/grand-ballroom/table-9

   cp hotel/table-10 /birthday/grand-ballroom/table-10 
   chown circus_c: /birthday/grand-ballroom/table-10
   gcc c/meet-me.c -o /birthday/floor-8/room-824/meet-me
   chmod 4755 /birthday/floor-8/room-824/meet-me
   chown circus_c: /birthday/floor-8/room-824/meet-me

   chmod 700 /birthday/grand-ballroom/table-*
}

main
