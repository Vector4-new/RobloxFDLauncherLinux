#This isn't finished
#Don't forget to mark this file as executable
#!/bin/bash
echo "This script is for amd64 systems if u have an x86 pc use the commented wine link instead"
sleep 3
echo "This doesn't work with wayland window managers!."
sleep 2
echo "Read the docs if you're having issues!"
sudo apt install wget aria2
sudo pacman -S wget --noconfirm
sudo pacman -S aria2 --noconfirm
sudo pacman -S p7zip --noconfirm
echo "RFD Windows version install script // Make sure you have Wine, wget and aria2c installed."
sleep 5
aria2c https://archive.org/download/roblox-unfiltered/roblox-unfiltered_archive.torrent --dir=/home/$USER --seed-time=0
7z x /home/$USER/roblox-unfiltered/FilteringDisabled.7z -o/home/$USER
mkdir /home/$USER/FilteringDisabled/wine
wget https://github.com/Kron4ek/Wine-Builds/releases/download/9.5/wine-9.5-amd64.tar.xz -O /home/$USER/FilteringDisabled/wine/wine-9.5-amd64.tar.xz
#wget https://github.com/Kron4ek/Wine-Builds/releases/download/9.5/wine-9.5-x86.tar.xz -O /home/$USER/FilteringDisabled/wine/wine-9.5-x86.tar.xz
tar -xf /home/$USER/FilteringDisabled/wine/wine-9.5-amd64.tar.xz -C /home/$USER/FilteringDisabled/wine
#tar -xf /home/$USER/FilteringDisabled/wine/wine-9.5-x86.tar.xz -C /home/$USER/FilteringDisabled/wine
aria2c https://archive.org/download/edge-webview-2-runtime-123.0.2420.53/edge-webview-2-runtime-123.0.2420.53_archive.torrent --dir=/home/$USER/FilteringDisabled --seed-time=0
sudo /home/$USER/FilteringDisabled/wine/wine-9.5-amd64/bin/wine /home/$USER/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53/EdgeWebview2Runtime_123.0.2420.53.exe
#sudo /home/$USER/FilteringDisabled/wine/wine-9.5-x86/bin/wine /home/$USER/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53/EdgeWebview2Runtime_123.0.2420.53.exe

#RM Stuff
sudo rm -r /home/$USER/roblox-unfiltered
sudo rm -r /home/$USER/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53

#Rename Roblox Launcher.exe
sudo mv "/home/$USER/FilteringDisabled/Roblox Launcher.exe" "/home/$USER/FilteringDisabled/RobloxLauncher.exe"
#Run RobloxLauncher.exe with sudo or else the webserver won't work! 
echo "Run RobloxLauncher.exe with sudo or else the webserver is probably not going to work!"
