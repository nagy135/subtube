# SUBTUBE
![sxiv picker](sxiv_picker.png)

Easy to use script that lets you watch your subscribed youtube channels with no distraction that youtube page has. Script has couple of dependecies, and my personal version has modified sxiv, therefore screenshot is not accurate to most of you (just showing off possibilities).

# DEPENDECIES

This project has couple of dependecies you have to have. If you use arch or almost any normal linux distribution, this should be easy to get for you.

* sxiv
* youtube-dl
* youtube-viewer
* mpv
* dunst

First 2 are core, while latter 3 will be optional in future. As of now, you need all of them.

# INSTALL

```
git clone https://github.com/nagy135/subtube
cd subtube
sudo ./install.sh
```
These commands will clone repository and install all the files to **/usr/bin**, **/usr/local/share**

# USAGE

Run subtube to see help.

## init
starts initial update, fills seen database without actually downloading thumbnails (update would download 5 latest videos from channels you probably saw)

## update
reads subscribe list, downloads the newest 5 videos (if not seen yet) and allows you to play them (with play)
```
subtube update
```
or
```
subtube secret_update
```
to avoid notification (I use it with crontab 30 min interval)

## play
brings up sxiv thumbnail selection, where (default sxiv bindings) **m** marks thumbnail and **q** closes it and starts playing all of marked videos (if any).
```
subtube play
```

## add
adds new subscribed channel

```
subtube add "https://www.youtube.com/channel/UCYO_jab_esuFRV4b17AJtAw/videos"
```

note that we use url of videos folder, not channel. This is because we find new videos by parsing page html (link has to point to videos folder!)

## queue
this feature is simply to allow you to specify custom order of videos. If you mark videos with **m** they will be played in order they show inside sxiv. Look at **SXIV integration** for more information. Command bellow plays queued videos in your order
```
subtube play_queue
```


## clean
cleans thumbnails folder

```
subtube clean
```

# SXIV integration
if you add following lines to your sxiv config (~/.config/sxiv/exec/key-handler) you will be able to use qeueu feature, show video title of thumbnail and remove them.

```
case "$KEY" in
    "n")      while read file; do subtube name $file; done ;; # notify video title
    "t")      while read file; do subtube name $file; done ;; # notify video title (alias)
    "q")      while read file; do subtube add_queue $file; rm $file; done ;; # adds video to queue
    "r")      while read file; do rm $file; done ;; # remove thumbnail
esac
```
this allows you to use sxiv prefix (ctrl+x) in combination with key inside quotes to perform aditional actions

# DUNST

Put this block to your dunst config to avoid notification spam of update progress. If you dont want this notification at all, try "secret_update" command.

```
[subtube]
    summary = *SUBTUBE - Update*
    set_stack_tag = 55
```
