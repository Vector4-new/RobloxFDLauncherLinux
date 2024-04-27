sudo /opt/lampp/lampp stop
/home/$USER/RobloxFDLauncherLinux/webserver/stop.sh
winebin=$(cat /home/$USER/RobloxFDLauncherLinux/settings/winebin_2022M.txt)
sudo $winebin /home/$USER/RobloxFDLauncherLinux/Webserver_2022M/UwAmp.exe
