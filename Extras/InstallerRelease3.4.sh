#!/bin/bash
echo Make sure you have Wine, git, wget and aria2c installed.
sleep 5
cd
git clone https://github.com/Vector4-new/RobloxFDLauncherLinux
aria2c https://archive.org/download/filtering-disabled_202403/filtering-disabled_202403_archive.torrent --dir=/home/$USER/RobloxFDLauncherLinux/rfdextraction --seed-time=0
unzip /home/$USER/RobloxFDLauncherLinux/rfdextraction/filtering-disabled_202403/FilteringDisabled.zip -d /home/$USER/RobloxFDLauncherLinux/rfdextraction
sudo cp -r /home/$USER/RobloxFDLauncherLinux/rfdextraction/FilteringDisabled/bin/Webserver /home/$USER/RobloxFDLauncherLinux/
sudo chown -R $USER /home/$USER/RobloxFDLauncherLinux/Webserver
sudo mv /home/$USER/RobloxFDLauncherLinux/Webserver /home/$USER/RobloxFDLauncherLinux/Webserver_2022M
sudo cp -r /home/$USER/RobloxFDLauncherLinux/rfdextraction/FilteringDisabled/bin/Clients /home/$USER/RobloxFDLauncherLinux/
sudo cp -r /home/$USER/RobloxFDLauncherLinux/rfdextraction/FilteringDisabled/bin/shared /home/$USER/RobloxFDLauncherLinux/
sudo rm -r /home/$USER/RobloxFDLauncherLinux/rfdextraction
sudo cp /home/$USER/RobloxFDLauncherLinux/Extras/index.php /home/$USER/RobloxFDLauncherLinux/Webserver_2022M/www/
sudo chown -R $USER /home/$USER/RobloxFDLauncherLinux/shared
sudo chown -R $USER /home/$USER/RobloxFDLauncherLinux/Clients
sudo chown -R $USER /home/$USER/RobloxFDLauncherLinux/webserver
sudo chown -R $USER /home/$USER/RobloxFDLauncherLinux/ManuelHostScripts/2022M_Maps
echo "RFD is now installed for further info view https://github.com/Vector4-new/RobloxFDLauncherLinux/ or README.MD"
echo "Make sure you have the dependencies installed for your distribution for it to work properly"
sleep 5
