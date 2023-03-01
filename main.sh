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

   for i in {1..10}; do
      touch /birthday/grand-ballroom/table-$i
   done

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

   useradd doorman_x -M -d /birthday/grand-ballroom -s /bin/bash -G 6543 2> /dev/null 

	useradd juggler_t -M -d /birthday/floor-6/room-6l7 -s /bin/bash -G 6543 2> /dev/null  
   chown -R  juggler_t:juggler_t /birthday/floor-6/room-617

	useradd elephant_p -M -d /birthday/floor-1/room-101 -s /bin/sh -G 6543 2> /dev/null  
   chown -R  elephant_p:circus_cyber /birthday/floor-1/room-101

	useradd rabbit_r -M -d /birthday/floor-5/room-505 -s /bin/sh -G 6543 2> /dev/null  
   chown -R rabbit_r:rabbit_r /birthday/floor-5/room-505 

   useradd fortune_m -M -d /birthday/floor-6/room-603 -s /bin/bash -G 6543 2> /dev/null
   chown -R fortune_m:fortune_m /birthday/floor-6/room-603 

   cp /bin/bash /bin/clownshell
	useradd clown_e -M -d /birthday/floor-7/room-707 -s /bin/clownshell -G 6543 2> /dev/null  
   chown -R clown_e:clown_e  /birthday/floor-7/room-707
   chown clown_e:circus_cyber /bin/clownshell
   chmod u+s /bin/clownshell 

   # Guests
	useradd guest_1 -M -d /birthday/floor-2/room-202 -s /bin/bash -G 6543 2> /dev/null  
	useradd guest_2 -M -d /birthday/floor-2/room-204 -s /bin/bash -G 6543 2> /dev/null  

	useradd guest_3 -M -d /birthday/floor-2/room-208 -s /bin/bash -G 6543 2> /dev/null  
   chown -R guest_3:circus_cyber /birthday/floor-2/room-208
   chmod 700 /birthday/floor-2/room-208 
   cp /etc/skel/{.bashrc,.bash_logout,.profile} /birthday/floor-2/room-208/

	useradd guest_4 -M -d /birthday/floor-2/room-212 -s /bin/bash -G 6543 2> /dev/null  
	useradd guest_5 -M -d /birthday/floor-2/room-214 -s /bin/bash -G 6543 2> /dev/null  

   chpasswd < .passwords

   # Application
   apt update && apt install -y gcc 

   # ---> Target 1 <---
   mkdir -p /home/tutor
   mv tutor/* /home/tutor/
   tar -czf exercises.tar.gz exercise-*  
   
}

main
