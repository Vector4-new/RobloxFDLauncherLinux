# Roblox Filtering Disabled Linux Launcher 🐧
![Placeholder](https://github.com/Vector4-new/RobloxFDLauncherLinux/assets/119701717/c7ecc390-2199-47c0-a278-8880205ead49)

Allows you to run Roblox clients and host servers on Linux.

(This repo is going to be set to private, if roblox allows wine again.)

(You might not have good experience with non-debian based distros)

(Some clients might not work with xampp)

### Current clients and servers:
Status|Architecture
-|-
💩|Client isn't implemented to the launcher. (Currently all clients are implemented.)
❌|Doesn't work (Client is detected by the launcher but will more than likely not work)  
🟡|Kinda works (Client will probably work but there might be issues such as lag and what not)  
✅|Works (Client is supposed to work flawlessly, at least it did while testing)  

* ✅ 2008M (needs mfc90 to function)
* 🟡 2013L 
* 🟡 2014M 
* 🟡 2015M 
* ✅ 2016L
* ✅ 2017M
* ✅ 2018E
* ✅ 2018M
* ✅ 2018L
* ✅ 2019M
* ✅ 2020L
* ✅ 2021E
* 🟡 2022M (Requires a seperate webserver)

## Install the Dependencies 📁

## 🍥 Debian Based Distros 🍥 (Ubuntu,Linux Mint..)
Install [Wine](https://wiki.winehq.org/Download) 🍷
```
sudo apt install docker
sudo apt install docker-compose
sudo apt install git
sudo apt install wget
sudo apt install aria2
sudo apt install unzip
```

## 🎩 Fedora-based Distros 
```
placeholder
```
## Arch-Based Distros (SteamOS,Manjaro..)
```
sudo pacman -S wine --noconfirm
sudo pacman -S docker --noconfirm
sudo pacman -S docker-compose --noconfirm
sudo pacman -S git --noconfirm
sudo pacman -S unzip --noconfirm
sudo pacman -S wget --noconfirm
sudo pacman -S aria2 --noconfirm
```
* Run the installer ➡️ (this is for devilbox) (can be found in https://github.com/Vector4-new/RobloxFDLauncherLinux/releases/)
* (Run this ➡️ https://github.com/Vector4-new/RobloxFDLauncherLinux/releases/tag/3.8 after running the latest script if you want to try out the XAMPP Beta)

* Install the webserver (devilbox)🛠️:
  ```sh
  /home/$USER/RobloxFDLauncherLinux/webserver/install.sh
  ```
*  You should start up the server when it asks you to download all binaries needed.
## Starting and stopping the webserver ⭐ 
### Starting 🚀
* Go into the `webserver` directory.
* Run `./start.sh`. (devilbox)
* Alternatively you just input this into a terminal and it should start . (devilbox)
   ```
   sudo /home/$USER/RobloxFDLauncherLinux/webserver/start.sh
   ```
   For XAMPP (experimental) use
   ```
    sudo /opt/lampp/lampp start
   ```
  For /Webserver_2022M (might not work) use
   ```
    /home/$USER/RobloxFDLauncherLinux/Webserver_2022M_start.sh
   ```
### Stopping ⛔
* Go into the `webserver` directory.
* Use `./stop.sh`. if you want to pause the webserver. You should usually use this unless an update occurred.
* Use `./kill.sh` if the webserver has issues or you want to kill it outright. This should only really be used if you've updated or issues occurred.
* Alternatively you can just input this into a terminal and it should stop/kill.
* (These 2 commands are for devilbox)
  ```
  sudo /home/$USER/RobloxFDLauncherLinux/webserver/stop.sh
  ```
  ```
  /home/$USER/RobloxFDLauncherLinux/webserver/kill.sh
  ```
  
  For XAMPP (experimental) use
  ```
  sudo /opt/lampp/lampp stop
  ```
  For 2022M webserver (UwAmp)
  
  ```
  sudo kill UwAmp
  sudo wineserver -k
  ```
  
  
## Hosting servers 🌐
* [Start the webserver](https://github.com/Vector4-new/RobloxFDLauncherLinux#starting-and-stopping-the-webserver) if you haven't.
* Run `./hostnew.sh` if you're going to host a server with devilbox (you might need to mark it as executable first)
  ```sh
  /home/$USER/RobloxFDLauncherLinux/hostnew.sh
  ```
  * Run `./hostnew_xampp.sh` if you're going to host a server with xampp (you might need to mark it as executable first)
  ```sh
  /home/$USER/RobloxFDLauncherLinux/hostnew_xampp.sh
  ```
  * Run `./hostnew_2022M.sh` if you're going to host a server with Webserver_2022M (you might need to mark it as executable first)
  ```sh
  /home/$USER/RobloxFDLauncherLinux/hostnew_2022M.sh
  ```
* Players can now connect to your server by using the port you inputted.
## Joining servers 🖥️
* [Start the webserver](https://github.com/Vector4-new/RobloxFDLauncherLinux#starting-and-stopping-the-webserver) if you haven't.
* Run `./joinnew.sh` (you might need to mark it as executable first)
  ```sh
  /home/$USER/RobloxFDLauncherLinux/joinnew.sh
  ```
## Documenation 📄 (Work-in-progress)

https://github.com/Vector4-new/RobloxFDLauncherLinux/blob/main/HostScripts.md

https://github.com/Vector4-new/RobloxFDLauncherLinux/blob/main/JoinScripts.md

https://github.com/Vector4-new/RobloxFDLauncherLinux/blob/main/customize.md

https://github.com/Twig6943/RobloxGraphicsSwitcherForLinux/tree/main/RFD (2020L configs will more than most likely not work.)
## Known issues ⚠
#EXPERIMENTAL XAMPP VERSION


•Anything barely works if you're using XAMPP beta version.

•You might experience permissions issues with XAMPP!

### Hosting 🌐
•Tycoon games saving doesn't work with devilbox/xampp. If you're going to host a tycoon game use hostnew_2022M.sh (Run Webserver_2022M_start.sh before!!! ) That being said it should be all good with devilbox (not with xampp anything barely works with xampp) if you're just joining the tycoon game.

•2022M Hosting/Joining doesn't work with devilbox/xampp. Use Webserver_2022M_start.sh

•Hosting 2014M does not work.  
•2015M either does not stop the server when interrupted, or takes a long time.  

•2022M requires [Microsoft Edge WebView2](https://archive.org/details/edge-webview-2-runtime-123.0.2420.53) (This installer tends to only work with Wine 9.5!)
### Joining 🖥️
•2008M will not launch without [mfc90 (X86)](https://www.microsoft.com/en-us/download/details.aspx?id=26368). You can use something like winetricks to install it.  
•Joining 2014M might not load CoreScripts, meaning parts of your GUI (i.e. playerlist and backpack) may be missing.  

•2022M Hosting/Joining doesn't work with devilbox/xampp. Use Webserver_2022M_start.sh

•2022M requires [Microsoft Edge WebView2](https://archive.org/details/edge-webview-2-runtime-123.0.2420.53) (This installer tends to only work with Wine 9.5!)

•You might experience weird gpu glitches if you have an nvidia gpu. If you do experience the said issue try using the 2021E client or 2020L with the OpenGL/Vulkan flags dxvk/wined3d might get rid of the gpu issues if you want to use the older clients without gpu issues switch to dxvk if you were using wined3d or maybe vice versa. Another thing you might try to fix the said issue is tinkering with your nvidia control panel settings. 
If you've found a new issue/bug please let us know over at our discord. (Discord:https://discord.gg/wqbSbt5GQ4)

### NixOS
If you're on NixOS and you're struggling with devilbox (XAMPP isn't available on NixOS) just use the Webserver_2022M_start.sh Do keep in mind that this script tends to not work with window managers (Gnome/KDE is recommended for this use case)  
#Fedora
placeholder
### Last launcher update 🔔
April 14, 2024

### Credits 💯
@vector4.new, @twig6843, @liquidovski
