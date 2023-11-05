#!/bin/bash

itemFile=$1
dataFile=$2
userFile=$3
num=0

while true
do
	echo "------------------------------"
	echo "User name: sangwon"
	echo "Student Number: 12223769"
	echo "[ MENU ]"
	echo "1. Get the data of the movie identified by a specific 'movie id' from 'u.item'"
	echo "2. Get the data of action genre movies from 'u.item'"
	echo "3. Get the average 'rating' of the movie identified by specific 'movie id' from 'u.data'"
	echo "4. Delete the 'IMDb URL' from 'u.item'"
	echo "5. Get the data about users from 'u.user'"
	echo "6. Modify the format of 'release date' in 'u.item'"
	echo "7. Get the data of movies rated by a specific 'user id' from 'u.data'"
	echo "8. Get the average 'rating' of movies rated by users with 'age' between 20 and 29 and 'occupation' as 'programmer'"
	echo "9. Exit"
	echo "---------------------------"



	read -p "Enter your choice [ 1-9 ] " num

	if [ $num -eq 1 ]
	then
		echo ""
		read -p "Please enter 'movie id'(1~1682): " mid
		echo ""
		cat $itemFile | awk -F\| -v id=$mid '$1==id {print $0}'
	elif [ $num -eq 2 ]
	then
		echo ""
                read -p "Do you want to get the data of 'action' genre movies from '$itemFile'?(y/n):" yn
		if [ $yn = "y" ]
		then	
			cat $itemFile | awk -F\| '$7==1 {print $1 " " $2'} | awk 'NR<=10 {print $0}'
		fi
		echo ""
	elif [ $num -eq 3 ]
	then 
		echo ""
		read -p "Please enter the 'movie id'(1~1682):" mid
		cat $dataFile | awk -v id=$mid '$2==id' | awk '{sum+=$3}  END {print sum/NR}'

	elif [ $num -eq 4 ]
	then
		echo ""
		read -p "Do you want to delete the 'ImDb URL' from 'u.item'?(y/n): " yn
		if [ $yn = "y" ]
		then
			cat $itemFile | awk -F\| '{print $1"|"$2"|"$3"|"$4"||"$6"|"$7"|"$8"|"$9"|"$10"|"$11"|"$12"|"$13"|"$14"|"$15"|"$16"|"$17"|"$18"|"$19"|"$20"|"$21"|"$22"|"$23"|"$24}' | awk 'NR<=10 {print $0}'
		fi
		echo ""
	elif [ $num -eq 5 ]
	then
		echo ""
		read -p "Do you want to get the data about users from 'u.user'?(y/n): " yn
		if [ $yn = "y" ]
		then 
			cat $userFile | awk -F\| '{print "user " $1 " is " $2 " years old " $3 " " $4}' | awk 'NR<=10 {print $0}' | sed -E 's/M/male/' | sed -E 's/F/female/'
		fi
		echo ""
	elif [ $num -eq 6 ]
	then
		echo ""
		read -p "Do you want to Modify the format of 'release data' in 'u.item'?(y/n): " yn
		if [ $yn = "y" ]
		then
			cat $itemFile | awk -F\| 'NR>=1673 && NR<=1682 {print $0}' | sed -E 's/([0-9]{2})-([A-Z][a-z][a-z])-([0-9]{4})/\3\2\1/' | sed -E 's/Jan/01/' | sed -E 's/Feb/02/' | sed -E 's/Mar/03/' | sed -E 's/Apr/04/' | sed -E 's/May/05/' | sed -E 's/Jun/06/' | sed -E 's/Jul/07/' | sed -E 's/Aug/08/' | sed -E 's/Sep/09/' | sed -E 's/Oct/10/' | sed -E 's/Nov/11/' | sed -E 's/Dec/12/'
		fi
		echo ""
	elif [ $num -eq 7 ]
	then 
		echo ""
		read -p "Please enter the 'user id'(1~943):" num
		echo ""
		cat $dataFile | awk -v id=$num '$1==id {print $2}' | sort -n | awk '{printf $0"|"}'
		echo ""
	elif [ $num -eq 9 ]
	then
		echo "Bye!"
		break	
	fi

done
