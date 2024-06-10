import subprocess

# creates a list of the dirs in /home
result = subprocess.run(['ls', '/home'], stdout=subprocess.PIPE)
# split up the output into a list
names = result.stdout.decode('utf-8').split()

#initialize an empty list
name_count=[]

# for each name in the list
# run du -s on /home/name
# and append that split up result to a list
n=0
for i in names:
	# result is going to be a list containing the output of du -s applied to names[n]
	result = subprocess.run(['du', '-s','/home/'+names[n]], stdout=subprocess.PIPE)

	# the append() method for list objects can be used to append the result gained to 
	# a list of dirs and dir sizes
	# what needs to be done, though, is to take only the first member of that resulting list
	# because that contains the size of the directory
	# the directory size also needs to be converted to an int
	name_count.append([names[n],int([result.stdout.decode('utf-8').split()][0][0])])
	n=n+1

# The list is ready to be sorted
new_name_count=sorted(name_count, key=lambda x: x[1], reverse=True)
print(new_name_count)

print(f"Username: {new_name_count[0][0]} is using the most space at {new_name_count[0][1]} MB")