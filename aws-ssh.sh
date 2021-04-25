#!/bin/bash

configuration=~/AWS/EC2/vm_list.csv


if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

if [ "$1" = "?" ]; then
	while IFS=, read -r name user host key
	do 
		echo $name
	done < $configuration
	exit
fi


server=$1
{
	read # skip first line
	while IFS=, read -r name user host key
	do
		if [ "$server" = "$name" ];then
			break;
			#exit 1
		fi
	done
	
} < ~/AWS/EC2/vm_list.csv

if [ "$server" = "$name" ];then
	echo "Connecting to $name $user@$host";
	ssh -i $key $user@$host;
else 
	echo "No Match Found";
fi





#cat ~/AWS/EC2/vm_list.csv |while IFS=, read -r name user host key
#do
#	echo "Name $name";
#	echo "User $user";
#	echo "Host $host";
#	echo "Key  $key";
#done

#ssh -i ~/AWS/EC2/AmazonLinuxMarch2021Test.pem ec2-user@IP_Address

