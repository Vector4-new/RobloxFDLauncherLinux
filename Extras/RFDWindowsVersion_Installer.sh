#This isn't finished
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
#Desktop Stuff
wget https://github.com/Vector4-new/RobloxFDLauncherLinux/blob/main/Extras/RFD.png?raw=true -O "/home/$USER/.local/share/applications/RFD.png"
wget https://raw.githubusercontent.com/Vector4-new/RobloxFDLauncherLinux/main/Extras/desktop_win.sh -O "/home/$USER/FilteringDisabled/desktop_win.sh"  
chmod +x /home/$USER/FilteringDisabled/desktop_win.sh 
exec /home/$USER/FilteringDisabled/desktop_win.sh
