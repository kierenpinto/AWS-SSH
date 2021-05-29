#!/bin/bash
echo ${@:1};
directory=$(dirname $0)

configuration=$(dirname $0)/vm_list.csv
# Reference https://ryanstutorials.net/bash-scripting-tutorial/bash-if-statements.php 

# Check if there has is a first argument suggesting a server name
if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit 1
fi

# If the first argument is a question mark 
if [ "$1" = "?" ] 
# || ["$1" = "-h"] || ["$1" = "--help" ];
then
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
	
} < $configuration



if [ "$server" = "$name" ];then
    echo "Connecting to $name $user@$host";
    key_path=$(realpath -L $directory/$key);
    echo "Using key $key_path";
    # If there is no second argument specifying scp 
    if [ -z "$2" ]
    then 
        ssh -i $key_path $user@$host;
    else 
    # If there is a second argument

        if [ "$2" = "cpf" ] # If the second Argument is cpf (Copy From)
        then 
            # Copy from the remote host to the localhost
           scp -i $key_path $user@$host:$3 $4  "${@:5}"
        elif [ "$2" = "cpt" ] # If the second Argument is cpt (Copy To)
        then
            # Copy to the remote host from the localhost
            scp -i $key_path $3 $user@$host:$4 "${@:5}"
        else
            echo "Invalid Command";
        fi
    fi
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

