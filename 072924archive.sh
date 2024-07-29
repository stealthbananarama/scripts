# set the archive directory
archive="${HOME}/archives/"

# set the archive formal name
name="scripts"

# set the directory to be archived
dir="${HOME}/scripts/"

# store today's date in mmddyy format
today=$(date +%m%d%y)

# create the archive
tar -czf "${archive}${today}${name}.tar.gz" "$dir"