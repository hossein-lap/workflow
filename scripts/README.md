# scripts

Shell scripts

**Optional:**

- Create `$HOME/.local/bin` directory and add it to the `PATH` variable.
Then put these scripts on the `~/.local/bin` dir.

## dmenu scripts

This section is all about scripts thar have been written using `dmenu`.
So `dmenu` is the main dependency.

### dm-shot.sh

Take screenshot using `scrot` and `dmenu`.

- Dependencies
	- scrot
	- (n)sxiv
	- xclip
	- dunst (or any notification manager)

### dm-kill.sh

Search and kill processes.

- Dependencies
	- ps
	- awk
	- sed
	- dunst (or any notification manager)

### dm-srun.sh

Run custom make scripts from `~/.local/bin` and
`~/.local/dev/hossein-lap/scripts/` which they are not
part of my `$PATH` variable.

- Dependencies
	- No extra dependencies

### dm-usb.sh

Manage usb devices.

1. Mount
1. Unmount
1. Eject

- Dependencies
	- lsblk
	- grep
	- udisks2
	- dunst (or any notification manager)

### dm-record.sh

Record from screen using `ffmpeg`
with options to whole screen or active window,
with or without sound, sound of mic or system.

- Dependencies
	- ffmpeg
	- xdpyinfo
	- awk
	- pulseaudio

### dm-exit.sh

To reboot, poweroff and lock the screen.
To this script works, you need to add a rule
to `sudoers` file for `/bin/reboot` and `/bin/shutdown`
to sudo not asking for a password.

- Dependencies
	- sudo
	- slock
	- sudo rule to run `shutdown` and `reboot` commands without asking for a password

## imageMagick scripts

This section is all about scripts that have been written for
image manipulation using `ImageMagick`. So `ImageMagick` is the main dependency.

### im-color.sh

Change specific color in photo.

- Dependencies
	- No extra dependencies

### im-negate.sh

Negate photo's color

- Dependencies
	- No extra dependencies

### im-shadow.sh

Add shadow border to photos.

- Dependencies
	- No extra dependencies

## Other sctipts

### lfub

Just a simple `lf` file-manager runner.

- Dependencies
	- ueberzug
	- bat
	- perl-file-mimeinfo (`mimetype`)

### wcam.sh

Show webcam with no sound from `/dev/video0`.

- Dependencies
	- mplayer

### tb.sh

Send command output to a pastebin service ([termbin.com](termbin.com)).

- Dependencies
	- netcat (GNU or OpenBSD)

### note-take.sh

A daily note-taking script with `markdown` and using `vim` text editor.

- Dependencies
	- vim

### note-build.sh

Build `pdf` and `html` files from daily notes.

**Neededd to be used inside vim**.

- Dependencies
	- pandoc
	- Rmarkdown
	- LaTeX
	- groff
	- st

### xrate.sh

Set second keyboard layout and Keypress dely

- Dependencies
	- xrate

### theping.sh

Show the ping of 1.1.1.1 in `slstatus` program

- Dependencies
	- ping

### cmus-tmux.sh

Run `cmus` inside `tmux` as mpd alternative.

- Dependencies
	- st
	- cmus
	- tmux

### r.sh

Run programs inside terminal and separate them from shell

- Dependencies
	- nohub
