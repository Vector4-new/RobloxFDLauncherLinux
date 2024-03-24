# Roblox Filtering Disabled Linux Launcher 🐧
![Placeholder](https://github.com/Vector4-new/RobloxFDLauncherLinux/assets/119701717/c7ecc390-2199-47c0-a278-8880205ead49)

Allows you to run Roblox clients and host servers on Linux.  

### Current clients and servers:
Status|Architecture
-|-
💩|Client isn't implemented to the launcher. (Currently all clients are implemented.)
❌|Doesn't work (Client is detected by the launcher but will more than likely not work)  
🟡|Kinda works (Client will probably work but there might be issues such as lag and what not)  
✅|Works (Client is supposed to work flawlessly, at least it did while testing)  

* ✅ 2008M <needs mfc90 to function>
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
* 🟡 2022M

## Install the Dependencies 📁

## Debian Based Distros 🍥 (Ubuntu,Linux Mint..)
Install [Wine](https://wiki.winehq.org/Download) 🍷
```
sudo apt install docker
sudo apt install docker-compose
sudo systemctl start docker
```
## Arch-Based Distros (SteamOS,Manjaro..)
```
sudo pacman -S wine
sudo pacman -S docker
sudo systemctl start docker
```
* Clone the repository 📋:
  ```
  git clone https://github.com/Vector4-new/RobloxFDLauncherLinux
  ```
* Install the webserver 🛠️:
  ```sh
  cd RobloxFDLauncherLinux
  cd webserver
  ./install.sh
  ```
*  You should start up the server when it asks you to download all binaries needed.
* Download the clients from https://aeplexi.itch.io/roblox-filtering-disabled (download `FilteringDisabled.7z`)
* Extract the folders `Clients` and `shared` into the root folder (where the webserver folder is)  
  Example layout:
  ```
  |->webserver
  |->Clients
  |->Shared
  |->host.sh
  |->join.sh
  |->customize.sh
  ```
  
## Starting and stopping the webserver ⭐ 
### Starting 🚀
* Go into the `webserver` directory.
* Run `./start.sh`.
* Alternatively you can just input this into a terminal and it should start.
*  ```
    /home/$USER/RobloxFDLauncherLinux/webserver/start.sh
    ```
### Stopping ⛔
* Go into the `webserver` directory.
* Use `./stop.sh`. if you want to pause the webserver. You should usually use this unless an update occurred.
* Use `./kill.sh` if the webserver has issues or you want to kill it outright. This should only really be used if you've updated or issues occurred.
* Alternatively you can just input this into a terminal and it should stop/kill.
* ```
   /home/$USER/RobloxFDLauncherLinux/webserver/stop.sh
* ```
  /home/$USER/RobloxFDLauncherLinux/webserver/kill.sh
  ```
## Hosting servers 🌐
* [Start the webserver](https://github.com/Vector4-new/RobloxFDLauncherLinux#starting-and-stopping-the-webserver) if you haven't.
* Run `./host.sh` with the arguments `client version`, `path to map`, and `port`. Port should be between 1024 and 32767 (to avoid collisions with the internal port used by RCCService). 2005 is a common port used.
  Example:
  ```sh
  /home/$USER/RobloxFDLauncherLinux/host.sh 2016L "/home/$USER/RobloxFDLauncherLinux/maps/2007Crossroads.rbxl" 2005
  ```
* Players can now connect to your server by using the port you inputted.
## Joining servers 🖥️
* [Start the webserver](https://github.com/Vector4-new/RobloxFDLauncherLinux#starting-and-stopping-the-webserver) if you haven't.
* Run `./join.sh` with the arguments `client version`, `IP`, `port` and `username`.
  Example:
  ```sh
  /home/$USER/RobloxFDLauncherLinux/join.sh 2016L 127.0.0.1 2005 "John Doe"
  ```
## Documenation 📄 (Work-in-progress)

https://github.com/Vector4-new/RobloxFDLauncherLinux/blob/main/HostScripts.md

https://github.com/Vector4-new/RobloxFDLauncherLinux/blob/main/JoinScripts.md

https://github.com/Vector4-new/RobloxFDLauncherLinux/blob/main/customize.md

https://github.com/Twig6943/RobloxGraphicsSwitcherForLinux/tree/main/RFD (2020L configs will more than most likely not work.)
## Known issues ⚠
### Hosting 🌐
•Hosting 2014M does not work.  
•2015M either does not stop the server when interrupted, or takes a long time.  
•Hosting 2022M may not work.
### Joining 🖥️
•2008M will not launch without [mfc90 (X86)](https://www.microsoft.com/en-us/download/details.aspx?id=26368). You can use something like winetricks to install it.  
•Joining 2014M might not load CoreScripts, meaning parts of your GUI (i.e. playerlist and backpack) may be missing.  
•Joining 2022M may not work.  
•You might experience weird gpu glitches if you have an nvidia gpu. If you do experience the said issue try using the 2021E client or 2020L with the OpenGL/Vulkan flags dxvk/wined3d might get rid of the gpu issues if you want to use the older clients without gpu issues switch to dxvk if you were using wined3d or maybe vice versa. Another thing you might try to fix the said issue is tinkering with your nvidia control panel settings. 
If you've found a new issue/bug please let us know over at our discord. (Discord:https://discord.gg/wqbSbt5GQ4)

### Last launcher update 🔔
Feb 16, 2024

### Credits 💯
You can contact anyone on discord:
@vector4.new, @twig6843, @dr.patrikking, @ardishco, @tux963, @rasp.pi, @whoman0385, @woff3037
