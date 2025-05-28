#!/bin/bash

# Create new user and set password
useradd -m -s /bin/bash ${username}
echo "${username}:${password}" | chpasswd
usermod -aG wheel ${username}

