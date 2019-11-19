# SUBTUBE
![sxiv picker](screen.png)

Easy to use script that lets you watch your subscribed youtube channels with no distraction that youtube page has. Script has couple of dependecies, and my personal version has modified sxiv, therefore screenshot is not accurate to most of you (just showing off possibilities).

# DEPENDECIES

This project has couple of dependecies you have to have. If you use arch or almost any normal linux distribution, this should be easy to get for you.

* [sxiv](https://github.com/muennich/sxiv)
* [youtube-dl](https://github.com/ytdl-org/youtube-dl)
* [mpv](https://github.com/mpv-player/mpv)
* [youtube-viewer](https://github.com/trizen/youtube-viewer)
* [dunst](https://github.com/dunst-project/dunst)

First 3 are core, while latter 2 will be optional in future. As of now, you need all of them.
**Youtube-viewer** provides (in my opinion) faster video loading and seeking and **dunst** is simply notification daemon that is heavily used. If you dont install dunst, you still get some notification (because you probably have different one), but dunst supports images and stacking (usefull to show update progress bar).

## ARCH
on arch based distro, get dependencies like this
```
pip install --user youtube-dl
sudo pacman -S sxiv, mpv, youtube-viewer, dunst
```

## DEBIAN/UBUNTU

```
pip install --user youtube-dl
sudo apt install sxiv, mpv, dunst
```
youtube-viewer is not present on debian repo, install from source via link in *dependecies*. You will probably just need to run these commands

```
cd /tmp # or anywhere else if you wish to preserve repository
git clone https://github.com/trizen/youtube-viewer
cd youtube-viewer
sudo cpan install CPAN ExtUtils::PkgConfig Module::Build inc::latest PAR::Dist Term::ReadLine::Gnu::XS Unicode::GCString LWP::Protocol::https Data::Dump JSON Gtk2 File::ShareDir
perl Build.PL
sudo ./Build installdeps
sudo ./Build install
```

# INSTALL

```
git clone https://github.com/nagy135/subtube
cd subtube
sudo make install
```
These commands will clone repository and install all the files to **/usr/bin**, **/usr/share/subtube**

## UNINSTALL
removes all files created
```
sudo make uninstall
```

# USAGE

provides CLI interface via subtube
```
subtube command
```
if ran without command, help is shown.
The optimal workflow you should try is to bind commands to key presses in key handler of your choice. I prefer this comfiguration:

Key press | command 
--- | --- 
super+y | `subtube play`
super+shift+y | `subtube update`
super+ctrl+y | `subtube play_queue`

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

### queue
this feature is simply to allow you to specify custom order of videos. If you mark videos with **m** they will be played in order they show inside sxiv. Look at **SXIV integration** for more information. Command bellow plays queued videos in your order
```
subtube play_queue
```


### clean
cleans thumbnails folder

```
subtube clean
```

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

# DUNST

Put this block to your dunst config to avoid notification spam of update progress. If you dont want this notification at all, try "secret_update" command.

```
[subtube]
    summary = *SUBTUBE - Update*
    set_stack_tag = 55
```

# CRONTAB
put these lines to you crontab file to download new thumbnails every 10 minutes.
```
*/10 * * * *  XDG_RUNTIME_DIR=/run/user/$(id -u) subtube secret_update
```

# BSPWM
i m using it on bspwm, so there is "one-shot sticky floating small middle screen" rule with notification if too many thumbnails to fit

# FUTURE WORK
* make youtube-viewer optional dependency (run pure youtube-dl if needed)
* fix rofi_play, to allow to play video via it's title, not just thumbnail
* make repo of my "mpv history" script, that can play already played videos via rofi launcher
