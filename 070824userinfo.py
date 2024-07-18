#!/usr/bin/python3

import subprocess

directory='/home'

# the main list of user information
user_dbase=[]

## 
# Get a list of the users in the home directory

# Run the `ls` command in the specified directory and capture the output
result = subprocess.run(['ls', directory], stdout=subprocess.PIPE, text=True)

# Get the output as a string
output = result.stdout

# Split the output string into a list of filenames
file_list = output.split('\n')

# Remove any empty strings from the list (in case there are trailing newlines)
file_list = [filename for filename in file_list if filename]

# file_list now contains the name of the users in the /home directory
## 

## 
# loop through the names in file_list and grep for those names in /etc/passwd
# use awk to get the home directory field and the full name
# add those to a list

for name in file_list:
	# Get the line from /etc/passwd
	grep_result=subprocess.run(["grep", '^'+name, "/etc/passwd"], stdout=subprocess.PIPE, text=True)

	# Get the first two fields from the line in /etc/passwd
	awk_result=subprocess.run(["awk", "-F:", '{print $1;print $6}'], input=grep_result.stdout, stdout=subprocess.PIPE, text=True)

	# strip the newline from the result
	output = awk_result.stdout.rstrip()
	
	# Now that the output is stored, split it up into a list
	user_dbase.append(output.split())
	

# temporary fix for the empty first entry - remove the first entry from the list
user_dbase.pop(0)
#
##

##
# 
#  get the size of each user's home directory
# this variable will be used to keep track of where to append the directory size
n = 0

# use du to get the size of the files in the user's home directory
for user_info in user_dbase:
	result = subprocess.run(['du', '-s', user_info[1]], stdout=subprocess.PIPE)
	user_dbase[n].append(result.stdout.decode('utf-8').split()[0])
	n = n+1

#
##

##
#
# print the final list of user information
#
# print the initial header
print("Username       | Home Directory         | Disk Usage ")
print("-----------------------------------------------------")
# print the user information using left justification to fill out the blanks
for user_info in user_dbase:
	print(user_info[0].ljust(15)+"|"+user_info[1].ljust(24)+"|"+user_info[2])
	
