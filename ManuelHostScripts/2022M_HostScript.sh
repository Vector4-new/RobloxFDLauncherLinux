#!/bin/bash

# Ask user for IP address, port number, and username
map=$(whiptail --inputbox "Enter mapname without file extension:" 8 60 --title "Map file name" 3>&1 1>&2 2>&3)
port=$(whiptail --inputbox "Enter port number:" 8 60 --title "Port Number" 3>&1 1>&2 2>&3)
winebin=$(cat /home/$USER/RobloxFDLauncherLinux/settings/winebin.txt)

echo "Don't forget to start the 2022M webserver!" 
sleep 3
cd /home/$USER/RobloxFDLauncherLinux/ManuelHostScripts
"$winebin" /home/$USER/RobloxFDLauncherLinux/Clients/2022M/RobloxStudioBeta.exe -localPlaceFile "2022M_Maps/$map.rbxl" -task StartServer -port "$port"
