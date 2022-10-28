#!/bin/bash

touch $1.py
echo "#!/bin/python3" > ./$1.py
chmod +x ./$1.py
vim ./$1.py
