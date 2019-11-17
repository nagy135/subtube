# SUBTUBE

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

## update
```
subtube update # or subtube secret_update to avoid notification (I use it with crontab 30 min interval)
```

# DUNST

Put this block to your dunst config to avoid notification spam of update progress. If you dont want this notification at all, try "secret_update" command.

```
[subtube]
    summary = *SUBTUBE - Update*
    set_stack_tag = 55
```
