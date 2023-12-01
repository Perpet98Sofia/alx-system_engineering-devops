#!/usr/bin/env bash
# Reverting changes made by the previous script

# Assuming the original hosts file is stored as /etc/hosts.original
cp -f /etc/hosts /etc/hosts

# Remove the temporary hosts.new file if it exists
rm -f ~/hosts.new

echo "Reverted to the original hosts file."
