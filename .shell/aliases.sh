#!/bin/sh

#alias su="clear; cat ~/.root.motd; su"

# colors
if [ -x /usr/bin/dircolors ]; then
    # TODO: Removed at the moment as its 1341 bytes in env
    #test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias sl='ls'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Private browser
alias incognito="chromium --incognito"

# Screenshots
alias screenshot="echo 'Protip: use -s to select'; scrot '$HOME/Screenshots/%F_%T.png'"
# Take a screenshot and send it to dropbox
alias screeul="echo 'Protip: use \"screenul -s\" to select'; scrot '$HOME/Screenshots/%F_%T_ul.png' -e 'dropbox_uploader.sh upload \$f /Screenshots/$(echo \$n | md5sum | sed "s/ .*$//").png && dropbox_uploader.sh share /Screenshots/$(echo \$n | md5sum | sed "s/ .*$//").png'"

# Todos:
#alias todos="grep "todo" -sirn {README,T{ODO,odo}{S,s,},N{OTE,ote}{S,s,},*.{c,h,cc,c++,hh,py,ml,s,asm,z80,sh,js}}"

# Social/News
alias irc='weechat -r "/connect vps;"'
alias news="slrn"

# Git
alias gitlog="git --no-pager log --oneline --decorate"

# EPITA
function mbox()
{
	local NAME=$1
	shift
	mutt -F"/home/pim/.mailconfs/$NAME" $@
}

# LSE
#alias liza='mpdcron -k; MPD_HOST=liza.lse.epita.fr mpdcron'
#alias sgoinfre='sudo mount -t nfs sgoinfre:/sgoinfre sgoinfre -o defaults,nfsvers=3,noatime,nolock,udp'
#alias lse_mail="mutt -F/home/pim/.mailconfs/lse_at_pimzero_com"

# Visual
alias compton_nice="compton -CGb --backend glx  --vsync opengl"

alias suspend='systemctl suspend'
alias pm-suspend='suspend'

#alias sixel='img2sixel ~/Downloads/0ZxObMJ.jpg'

#alias dash='PS1="\$(whoami)@\$(cat /proc/sys/kernel/hostname):\$PWD\\\$ " src/dash -o emacs'

alias qemu-kvm='qemu-system-x86_64 -enable-kvm'


alias gdb='gdb -q'

#alias uptimes='for i in dusk localhost vps.pimzero.com pimzero@ftp.pimzero.com; do echo -ne "$i,"; ssh $i -- uptime; done | column -t -s","'

alias checkpatch='~/Data/linux/scripts/checkpatch.pl'

alias ocaml='rlwrap ocaml'

#alias startx='exec env -i SSH_AUTH_SOCK="$SSH_AUTH_SOCK" XDG_SEAT=$XDG_SEAT XDG_SESSION_TYPE=$XDG_SESSION_TYPE INVOCATION_ID=$INVOCATION_ID XDG_SESSION_CLASS=$XDG_SESSION_CLASS XDG_VTNR=$XDG_VTNR XDG_SESSION_ID=$XDG_SESSION_ID XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR JOURNAL_STREAM=$JOURNAL_STREAM DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS PATH="$PATH" XAUTHORITY="$XAUTHORITY" startx'
#alias startx='exec env -i SSH_AUTH_SOCK="$SSH_AUTH_SOCK" XDG_SEAT=$XDG_SEAT XDG_SESSION_TYPE=$XDG_SESSION_TYPE INVOCATION_ID=$INVOCATION_ID XDG_SESSION_CLASS=$XDG_SESSION_CLASS XDG_VTNR=$XDG_VTNR XDG_SESSION_ID=$XDG_SESSION_ID XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR JOURNAL_STREAM=$JOURNAL_STREAM DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS PATH="$PATH" XAUTHORITY="$XAUTHORITY" HOME=$HOME USER=$USER startx'
#alias startx='exec env env --unset={SHELL,HOME,EDITOR,PWD,CAML_LD_LIBRARY_PATH,OCAML_TOPLEVEL_PATH,MANPATH,OPAM_SWITCH_PREFIX,PYTHONSTARTUP,SLSH_PATH_ENV,PERL5LIB,INVOCATION_ID,NNTPSERVER,TERM,_,OLDPWD,MAIL,HG,OPAMNOENVNOTICE,PERL_LOCAL_LIB_ROOT,PAGER,SHLVL,PERL_MM_OPT,VISUAL,USER,PERL_MB_OPT} startx'
#alias startx='exec env env --unset={SHELL,EDITOR,PWD,CAML_LD_LIBRARY_PATH,OCAML_TOPLEVEL_PATH,MANPATH,OPAM_SWITCH_PREFIX,PYTHONSTARTUP,SLSH_PATH_ENV,PERL5LIB,INVOCATION_ID,NNTPSERVER,TERM,_,OLDPWD,MAIL,HG,OPAMNOENVNOTICE,PERL_LOCAL_LIB_ROOT,PAGER,SHLVL,PERL_MM_OPT,VISUAL,PERL_MB_OPT} startx'
alias startx='exec env -i \
	DBUS_SESSION_BUS_ADDRESS="$DBUS_SESSION_BUS_ADDRESS" \
	HOME="$HOME" \
	INVOCATION_ID="$INVOCATION_ID" \
	JOURNAL_STREAM="$JOURNAL_STREAM" \
	PATH="$PATH" \
	SSH_AUTH_SOCK="$SSH_AUTH_SOCK" \
	USER="$USER" \
	XAUTHORITY="$XAUTHORITY" \
	XDG_RUNTIME_DIR="$XDG_RUNTIME_DIR" \
	XDG_SEAT="$XDG_SEAT" \
	XDG_SESSION_CLASS="$XDG_SESSION_CLASS" \
	XDG_SESSION_ID="$XDG_SESSION_ID" \
	XDG_SESSION_TYPE="$XDG_SESSION_TYPE" \
	XDG_VTNR="$XDG_VTNR" \
	startx'

alias dotfiles='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
