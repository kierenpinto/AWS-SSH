# Simple SSH Utility for AWS

This utility allows you to connect to SSH sessions easily using .pem private key file(s). A CSV file is used to store the IP/Domain of the session, the username, and the path to the private key file. Each cloud VM is denoted by a name. 

## The CSV File
The CSV file must be named `vm_list.csv`. 

The CSV file must be setup in the following form:

```
Name,User,Host,Key
vm1,ec2-user,35.80.30.231,~/path/to/folder/key.pem
vm2,ec2-user,example.com,~/path/to/folder/key.pem
```

The first row are the column headers and must be present in all CSV.

- Name - An alias given to the VM
- User - the username used to start an SSH session
- Host - the IP address or Domain of the VM
- Key - the path to the private key


## Usage

Run install.sh

It will add awsssh as a command (in your .bashrc). You must restart your terminal.

If you type
```
awsssh ? 
``` 

It will list all the Names or Aliases you can use.

Then to use a vm type:

```
awsssh vm1
```