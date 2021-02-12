# SUBTUBE

![](https://tokei.rs/b1/github/nagy135/subtube?category=code)

![sxiv picker](screen.png)

Easy to use script that lets you watch your subscribed youtube channels with no distraction that youtube page has. Script has couple of dependecies, and my personal version has modified sxiv, therefore screenshot is not accurate to most of you (just showing off possibilities).

# DEPENDECIES

This project has couple of dependecies you have to have. If you use arch or almost any normal linux distribution, this should be easy to get for you.

* [sxiv](https://github.com/muennich/sxiv)
* [youtube-dl](https://github.com/ytdl-org/youtube-dl)
* [mpv](https://github.com/mpv-player/mpv)
* [dunst](https://github.com/dunst-project/dunst)
* [xob](https://github.com/florentc/xob)

First 3 are core, while latter 2 will be optional in future. As of now, I recommend having all of those.
**Dunst** is simply notification daemon that is heavily used. If you dont install dunst, you still get some notification (because you probably have different one), but dunst supports images and stacking.
**XOB** is progress bar, it shows u progress of update process. You can completely avoid having it and use `subtube secret_update` that doesnt spawn any progress bar anyway.

## ARCH
on arch based distro, get dependencies like this
```
pip install --user youtube-dl
sudo pacman -S sxiv, mpv, dunst
yay -S xob
```

if script stops working one day for you, you need to update your youtube-dl
```
pip install --user --update youtube-dl
```

## DEBIAN/UBUNTU

```
pip install --user youtube-dl
sudo apt install sxiv, mpv, dunst
```
youtube-viewer is not present on debian repo, install from source via link in *dependecies*. You will probably just need to run these commands

```
cd /tmp # or anywhere else if you wish to preserve repository
git clone https://github.com/florentc/xob
cd xob
make
sudo make install
```

# INSTALL

```
git clone https://github.com/nagy135/subtube
cd subtube
sudo make install
```
These commands will clone repository and install all the files to **/usr/bin**, **/usr/share/subtube**
If you want to change the code and rebuild it without loosing watched history, use `sudo make reinstall`

## UNINSTALL
removes all files created
```
sudo make uninstall
```

# USAGE

provides CLI interface via subtube (you might wanna check `subtube --help`)
```
subtube command
```
if ran without command, help is shown.
The optimal workflow you should try is to bind commands to key presses in key handler of your choice. I prefer this configuration:

Key press | command
--- | ---
super+y | `subtube play`
super+shift+y | `subtube update`

## COMMANDS

### init
starts initial update, fills seen database without actually downloading thumbnails (update would download 5 latest videos from channels you probably saw)

```
subtube init
```

### update
reads subscribe list, downloads the newest 5 videos (if not seen yet) and allows you to play them (with play)
```
subtube update
```
or
```
subtube secret_update
```
to avoid notification (I use it with crontab 30 min interval)

### play
brings up sxiv thumbnail selection, where (default sxiv bindings) **m** marks thumbnail and **q** closes it and starts playing all of marked videos (if any).
```
subtube play
```

### add
adds new subscribed channel

```
subtube add "https://www.youtube.com/channel/UCYO_jab_esuFRV4b17AJtAw/videos"
```

note that we use url of videos folder, not channel. This is because we find new videos by parsing page html (link has to point to videos folder!)

# SXIV integration
if you add following lines to your sxiv config (~/.config/sxiv/exec/key-handler) you will be able to use queue feature, you will be able to show video title as notification or remove thumbnails.

After install of sxiv, create config folder and key handler script like this
```
mkdir -p ~/.config/sxiv/exec
touch ~/.config/sxiv/exec/key-handler
```

then add this content to a file  (If this case statement already exists, so just copy 4 lines inside.)

```
#!/bin/bash

case "$1" in
    "n")      while read file; do subtube name $file; done ;; # notify video title
    "t")      while read file; do subtube name $file; done ;; # notify video title (alias)
    "q")      while read file; do subtube add_queue $file; rm $file; done ;; # adds video to queue
    "r")      while read file; do rm $file; done ;; # remove thumbnail
esac
```
then make it executable
```
chmod +x ~/.config/sxiv/exec/key-handler
```

this allows you to use sxiv prefix (ctrl+x) in combination with key inside quotes to perform additional actions

# CRONTAB
put these lines to you crontab file to download new thumbnails every 10 minutes.
There is little issue with this showing notification on some systems. You might have to google a little to make it work.
But once your crontab can regularly spawn `notify send 'title' 'body'`, it will work and refresh new videos regularly.
```
*/10 * * * *  XDG_RUNTIME_DIR=/run/user/$(id -u) subtube secret_update
```

# BSPWM
i m using it on bspwm, so there is "one-shot sticky floating small middle screen" rule with notification if too many thumbnails to fit

# FUTURE WORK
* TOP PRIORITY: AUR
* make repo of my "mpv history" script, that can play already played videos via rofi launcher
