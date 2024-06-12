#!/bin/bash
#This isn't finished
#Don't forget to mark this file as executable
#Wine 9.5 is for webview2

echo "This script is for amd64 systems if u have an x86 pc uncomment the lines related to x86 wine instead."
sleep 3
echo "This doesn't work with wayland window managers!"
sleep 3
echo "Make sure you have wine,wget,aria2,kitty,curl installed!"
sleep 3
echo "Read the docs if you're having issues!"
sudo apt-get install wget aria2 kitty curl
sudo pacman -S wget --noconfirm
sudo pacman -S aria2 --noconfirm
sudo pacman -S p7zip --noconfirm
sudo pacman -S kitty --noconfirm
sudo pacman -S wine --noconfirm
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
#Download the Icon
curl -o /home/$USER/.local/share/icons/hicolor/256x256/apps/FilteringDisabled.png -LJO https://github.com/Vector4-new/RobloxFDLauncherLinux/raw/main/Extras/RFD.png

#Install EdgeWebview to root prefix
sudo /home/$USER/FilteringDisabled/wine/wine-9.5-amd64/bin/wine /home/$USER/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53/EdgeWebview2Runtime_123.0.2420.53.exe
#sudo /home/$USER/FilteringDisabled/wine/wine-9.5-x86/bin/wine /home/$USER/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53/EdgeWebview2Runtime_123.0.2420.53.exe

#Rename Roblox Launcher.exe
sudo mv "/home/$USER/FilteringDisabled/Roblox Launcher.exe" "/home/$USER/FilteringDisabled/RobloxLauncher.exe"

#Part where it moves existing stuff to dedicated prefix
$prefix=/home/$USER/.local/share/wineprefixes/FilteringDisabled
WINEPREFIX=$prefix wine placeholder.exe
mv /home/$USER/FilteringDisabled /home/$USER/.local/share/wineprefixes/FilteringDisabled/drive_c/ProgramData

#Install EdgeWebview to dedicated prefix (ngl this is kinda useless) (Even the FilteringDisabled prefix is useless now that I think about it :( )
#/home/$USER/.local/share/wineprefixes/FilteringDisabled/drive_c/ProgramData/FilteringDisabled/wine/wine-9.5-amd64/bin/wine /home/$USER/.local/share/wineprefixes/FilteringDisabled/drive_c/ProgramData/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53/EdgeWebview2Runtime_123.0.2420.53.exe
#/home/$USER/.local/share/wineprefixes/FilteringDisabled/drive_c/ProgramData/FilteringDisabled/wine/wine-9.5-x86/bin/wine /home/$USER/.local/share/wineprefixes/FilteringDisabled/drive_c/ProgramData/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53/EdgeWebview2Runtime_123.0.2420.53.exe


#RM Useless Stuff
sudo rm -r /home/$USER/roblox-unfiltered
sudo rm -r /home/$USER/.local/share/wineprefixes/FilteringDisabled/drive_c/ProgramData/FilteringDisabled/edge-webview-2-runtime-123.0.2420.53

#Run RobloxLauncher.exe with sudo or else the webserver won't work! 
echo "Run RobloxLauncher.exe with sudo or else the webserver is probably not going to work!"
echo "For the desktop file make sure you have kitty installed!"

#Desktop Integration!

echo "[Desktop Entry]" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "Name=FilteringDisabled" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "Comment=placeholder" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "Icon=/home/$USER/.local/share/icons/hicolor/256x256/apps/FilteringDisabled.png" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "Exec=kitty sudo wine /home/twig/.local/share/wineprefixes/FilteringDisabled/drive_c/ProgramData/FilteringDisabled/RobloxLauncher.exe" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "Type=Application" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "Categories=Games;" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "StartupNotify=true" >> ~/.local/share/applications/FilteringDisabled.desktop
#echo "Path=$HOME/.local/share/wineprefixes/OnlyRetroRobloxHere/drive_c/ProgramData/OnlyRetroRobloxHere" >> ~/.local/share/applications/FilteringDisabled.desktop
echo "StartupWMClass=RobloxLauncher.exe" >> ~/.local/share/applications/FilteringDisabled.desktop
cp ~/.local/share/applications/FilteringDisabled.desktop ~/Desktop/FilteringDisabled.desktop
