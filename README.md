# RobloxFDLauncherLinux
Allows you to run Roblox clients and host servers on Linux.  

### Current clients and servers:
💩=Not even recognized by the launcher (Unsupported)

❌=Doesn't work (Client is detected by the launcher but will more than likely not work) 

🟡=Kinda works (Client will probably work but there might be issues such as lag and what not)

✅=Works (Client is supposed to work, at least it did while testing)

* 🟡 2008M
* 💩 2013L
* 🟡 2014M
* 💩 2015M
* ✅ 2016L
* ✅ 2017M
* ✅ 2018E
* ✅ 2018M
* ✅ 2018L
* 💩2019M
* 💩2020L
* ✅ 2021E
* ❌ 2022M

## Installing
* Clone the repository:
  ```sh
  git clone https://github.com/Vector4-new/RobloxFDLauncherLinux
  ```
* Install the webserver:
  ```sh
  cd RobloxFDLauncherLinux
  cd webserver
  ./install.sh
  ```
  You should start up the server when it asks you to download all binaries needed.
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
  
## Starting and stopping the webserver
### Starting
* Go into the `webserver` directory.
* Run `./start.sh`.
### Stopping
* Go into the `webserver` directory.
* Use `./stop.sh` if you want to pause the webserver. You should usually use this unless an update occurred.
* Use `./kill.sh` if the webserver has issues or you want to kill it outright. This should only really be used if you've updated or issues occurred.

## Hosting servers
* [Start the webserver](https://github.com/Vector4-new/RobloxFDLauncherLinux#starting-and-stopping-the-webserver) if you haven't.
* Run `./host.sh` with the arguments `client version`, `path to map`, and `port`. Port should be between 1024 and 32767 (to avoid collisions with the internal port used by RCCService).
  Example:
  ```sh
  /home/$USER/RobloxFDLauncherLinux/host.sh 2021E "/home/$USER/RobloxFDLauncherLinux/maps/2007Crossroads.rbxl" 2005
  ```
* Players can now connect to your server by using the port you inputted.
## Joining servers
* [Start the webserver](https://github.com/Vector4-new/RobloxFDLauncherLinux#starting-and-stopping-the-webserver) if you haven't.
* Run `./join.sh` with the arguments `client version`, `IP`, `port`, `username`, `user ID`.
  Example:
  ```sh
  /home/$USER/RobloxFDLauncherLinux/join.sh 2021E 127.0.0.1 2005 "John Doe" 1029384756
  ```

## Known issues
### Joining
2008M will not launch without [mfc90 (X86)](https://www.microsoft.com/en-us/download/details.aspx?id=26368). You can use something like winetricks to install it.  
Joining 2014M might not load CoreScripts, meaning parts of your GUI (i.e. playerlist and backpack) may be missing.  
Joining 2022M may not work.  
### Hosting
Hosting 2014M does not work.  
2015L crashes when attempting to stop the server.  
Hosting 2022M may not work.

### Last launcher update
8/16/2023

### Credits
You can contact anyone on discord:
@vector4.new, @jetray.4509 (creator of the original launcher for windows), @twig6843, @dr.patrikking, @ardishco, @tux963, @rasp.pi, @whoman0385, @woff3037
