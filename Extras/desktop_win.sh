#This is cancelled!
# Prompt the user for their username
read -p "Enter your username: " username

goverlay_desktop_file="/home/$USER/.local/share/applications/rfd.desktop"
sudo tee "$goverlay_desktop_file" > /dev/null <<EOF
[Desktop Entry]
Name=Roblox Filtering Disabled (Windows)
Exec=sudo wine /home/$USER/FilteringDisabled/RobloxLauncher.exe
Icon=/home/$USER/.local/share/applications/RFD.png
Type=Application
Categories=Games;
EOF

# Replace USER_PLACEHOLDER with the actual username
sed -i "s|USER_PLACEHOLDER|$username|g" "$goverlay_desktop_file"
echo -e "\e[0;31mRFD is now installed. For further info, view https://github.com/Vector4-new/RobloxFDLauncherLinux/ or README.MD.\e"
sleep 5
