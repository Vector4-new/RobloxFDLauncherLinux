#This isn't finished
#Don't forget to mark this file as executable
#!/bin/bash
sudo apt install wget aria2
sudo pacman -S wget --noconfirm
sudo pacman -S aria2 --noconfirm
echo "RFD Windows version install script // Make sure you have Wine, wget and aria2c installed."
sleep 5
aria2c https://archive.org/download/roblox-unfiltered/roblox-unfiltered_archive.torrent --dir=/home/$USER --seed-time=0
7z /home/$USER/roblox-unfiltered/FilteringDisabled.7z -o/home/$USER

#RM Stuff
sudo rm -r /home/$USER/roblox-unfiltered

#Rename Roblox Launcher.exe
sudo mv "/home/$USER/FilteringDisabled/Roblox Launcher.exe" "/home/$USER/FilteringDisabled/RobloxLauncher.exe"
#Run RobloxLauncher.exe with sudo or else the webserver won't work! 
echo "Run RobloxLauncher.exe with sudo or else the webserver is probably not going to work!"
