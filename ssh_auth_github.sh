#!/bin/bash

echo -e "\nWelcome to SSH Authentication in Github !\n"

while true; do
	read -p "Do you want to proceed? {y/n}: " yn
	case $yn in
		[yY] ) echo -e "nice choice;)\n";
			break;;
		[nN] ) echo exiting...;
			exit;;
		* ) echo invalid response;;
esac
done

# See if a key already exist
echo -e "Verification of existing SSH keys..."
ls -la ~/.ssh/
echo 
while true; do
	read -p "Do you want to proceed? {y/n}: " yn
	case $yn in
		[yY] ) echo -e "ok, we will create a new SSH key\n";
			break;;
		[nN] ) echo exiting...;
			exit;;
		* ) echo invalid response;;
esac
done

# Will create a new key
echo -e "Creation of a new SSH key..."
read -p "Enter the name of the SSH key: " key
read -p "Enter your email: " email
ssh-keygen -f ~/.ssh/$key -t ed25519 -C $email

# Starting the SSH agent
echo -e "\nStarting of the SSH agent...";
eval "$(ssh-agent -s)"

# Adding the key into the agent
echo -e "\nAdding the key into the agent..."
ssh-add ~/.ssh/$key

# Copy of the key in the clipboard
cat ~/.ssh/$key.pub | clip
echo -e "\nThe key has been copied in your clipboard"

# Adding the SSH key in Github
echo -e "\nNow you can add the key in Github (in Setting > SSH and GPG keys)\n"
echo "Thanks for using this script:)"
