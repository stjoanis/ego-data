# 2020-09-25 : sf
if [ $TERM == dumb ];then return 0;fi
TPUT=/usr/bin/tput;CBLUE=`$TPUT setaf 4`;CRED=`$TPUT setaf 1`;CNORMAL=`$TPUT op`
alias wh='alias | /usr/bin/which --tty-only --read-alias --show-tilde'
pm(){ if [ $# = 0 ];then pm $(pwd -P);else pmDIR=$(cd $1 && pwd);if ! echo $PATH|(/bin/egrep "(^|:)$pmDIR($|/$|:|/:)">/dev/null);then export PATH=$pmDIR:$PATH;fi;fi;}
pml(){ if [ $# = 0 ];then pml $(pwd -P);else pmDIR=$(cd $1 && pwd)
if ! echo $LD_LIBRARY_PATH|(/bin/egrep "(^|:)$pmDIR($|/$|:|/:)">/dev/null);then export LD_LIBRARY_PATH=$pmDIR:$LD_LIBRARY_PATH;fi;fi;}
pa(){ echo ${CBLUE}-- PATH$CNORMAL;perl -e '($_=$ENV{PATH})=~s/:|$/\n/g and print';echo;echo ${CRED}-- LD_LIBRARY_PATH$CNORMAL
perl -e '($_=$ENV{LD_LIBRARY_PATH})=~s/:|$/\n/g and print';}
alias rm=? x+='chmod +x' m=more l.='ls -ald .*' ..='cd ..' ct='column -t' f_=firefox
if [ `uname` == "Linux" ]
then # Linux
alias vi=vim l='ls -lh --color' lt='l -rth' lS='lt -S' grep='grep --color' gi='grep -i' gx='grep -v "^$\|^#"'
fl(){ find $(pwd -P) -type f -name "*$1*" -exec ls -lh --time-style=long-iso {} \; | sort -k 6,7 | ct;}
ff(){ if [ $# -eq 1 ];then STR=$1;C_C=always;else STR=.;C_C=never;fi;RPWD=$(pwd -P)
find $RPWD \( -type f -o -type l -o -type d \) -name "*$1*"|sed "s#$RPWD\(.*\)#$CBLUE$PWD$CNORMAL\1#g"|grep --color=$C_C "$1";}
else # Solaris
export TERM=vt100;alias l='ls -lh' lt='l -rt';stty columns 160
#fl(){ find $PWD -type f -name "*$1*" -print | xargs ls -lrt;}
alias fl="find $PWD -type f -print0 | xargs -0 stat --format '%Y %y %n' | sed 's/\.[[:digit:]]\{9\} +[[:digit:]]\{4\}//' |sort"
ff(){ if [ $# -eq 1 ];then STR=$1;else STR=.;fi;find $(pwd -P) \( -type f -o -type l -o -type d \) -name "*$1*";}
fi
export EDITOR=vi HISTSIZE=1000 HISTCONTROL=ignoreboth HST=`hostname|awk -F'.' '{print $1}'`
export CCC=2
# Konsole
#export PS1="\$( RET=\$?; [[ \$RET != 0 ]] && echo \"\[\033[1;91m\][\$RET]\")\033[32m\u@\033[38;5;\${CCC}m\h \[\033[34m\t \[\033[37m${all_pi}\[\033[48m${ORACLE_SID}\[\e[0m\] \033[33m\$PWD\033[0m\]\n\[\e[44;1;37m\]\#\[\e[0m\] ";sch(){ grep -i $1 /tmp/$(hostname|cut -d\. -f1).dat; }
# Gnome
#export PS1="\$( RET=\$?; [[ \$RET != 0 ]] && echo \"\[\033[1;91m\][\$RET]\")\\033[0;32m\u@\033[38;5;\${CCC}m\h\\033[0;34m \t \\033[0;33m\$PWD \n\\033[44;1;37m\#\\033[0;39m "
# Konsole
export PS1="\033[32m\u@\h \[\033[34m\t \[\033[48m${ORACLE_SID}\[\e[0m\] \033[33m\$PWD\033[0m\]\n\[\e[44;1;37m\]\#\[\e[0m\] "
#pi(){ for ETH in $(ifconfig |grep -o "^[[:alnum:]\|:|\.]\+"); do ipaddress=$(set -- $(ifconfig ${ETH});echo $7|cut -d: -f2);echo "${ETH} "$CRED$ipaddress$CNORMAL;done|column -t;}
pi(){ for ETH in $(ls /sys/class/net); do ipaddress=$(ip a show $ETH|grep ^[[:space:]]*"inet "|awk '{print $2}'); echo "${ETH} "$CRED$ipaddress$CNORMAL; done;}
all_pi=$(pi|grep -v "^lo" |awk '{print $2}'|grep -v "^[[:alpha:]]\|^$"|paste -s -d\|)
#export PROMPT_COMMAND='RETRN_VAL=$?;logger -p local6.debug "$(whoami) [$$]: $(history 1 | sed "s/^[ ]*[0-9]\+[ ]*//" ) [$RETRN_VAL]"'
run_sch(){ find $(df -h|grep "/dev"|awk '{print $NF}') -xdev \( -type f -o -type l \) | awk -F\; '{print $0}' > /tmp/$(hostname |cut -d. -f1).dat;}
cnv(){ FICH=$1;tr -d '\015'<$FICH>conv_ascii_unix_dos;mv conv_ascii_unix_dos $FICH;}
unalias cdd 2>/dev/null;cdd(){ cd `dirname $1`;};hi(){ history|grep ${1:-" "};}
f(){ if [ $# = 0 ]; then for i in *; do echo $PWD/`basename $i`;done;else for i in *$1*;do echo $PWD/`basename $i`; done; fi;}
# search in PATH
ffp(){ pmDIR=$(pa|grep ^/);find $pmDIR -name "*$1*" 2>/dev/null;}
ff_(){ if [ $# -eq 1 ];then STR=$1;else STR=.;fi;RPWD=$(pwd -P)
find $RPWD \( -type f -o -type l -o -type d \) -name "*$1*"|grep --color=never "$1";}
tk(){ tkprof $1 ${1//trc/tk};}

DISP(){ export DISPLAY=$1:0.0;};sid(){ export ORACLE_SID=$1;};-(){ cd -;};ww(){ dig +short txt $1.wp.dg.cx;}
pw(){ echo link_PWD: `pwd`;echo real_PWD: `pwd -P`;}
### DOUBLON ### pi(){ for ETH in $(ifconfig |grep -o "^[[:alnum:]\|:|\.]\+"); do ipaddress=$(set -- $(ifconfig ${ETH});echo $7|cut -d: -f2);echo "${ETH} "$CRED$ipaddress$CNORMAL;done|ct;}
[[ -f ~stjoanis/.b ]] && (cat ~stjoanis/.b > /tmp/.b;chmod 777 /tmp/.b)
alias bazel='ssh root@10.100.0.1' aigle='ssh -o "ServerAliveInterval 60" es581500@193.52.21.73'
#TERM=vt100
pm ~/Bin 2>/dev/null;pm /opt/bin 2>/dev/null
alias tns='export TNS_ADMIN=$ES/tns' dba='rlwrap sqlplus / as sysdba' oconf='env|grep -v PS1|egrep --color "SQL|TNS|NLS|ORA|LANG|LIBRARY"' sq='rlwrap sqlplus' rman='rlwrap rman'
alias trhtml='\ls -C1 *.html | while read; do mv "$REPLY" "$(echo $REPLY|tr -c "[:alnum:].\n" "_")" 2>/dev/null; done'
pt(){ echo -ne "\033]0;$HST $1\007";[ -n "$KONSOLE_DCOP_SESSION" ] && dcop $KONSOLE_DCOP_SESSION renameSession ${1:-$(uname -n)":"$PWD};echo -n;}; #echo -ne "\033]0;$HST\007"
# SHORT: pt(){ echo -ne "\033]0;$(hostname|cut -c1)$(hostname|grep -o [[:digit:]]):$(whoami|cut -c1) $1\007";}
rpmf(){ \which $1 | xargs rpm -qf;};pu(){ ORACLE_SID=$PWD;pushd $1;};po(){ unset ORACLE_SID;popd $1;}
# display config_file content and dir
dp(){ sed -e '/^[ \t]*[#;]/d' -e '/^$/d' $1;echo;echo;}
st(){ echo $* | xargs -n 10 stat --printf "%n¤%x\\n" | awk -F\¤ '{ printf "%-30s Access: %s\n", $1, $2 }' ;};alias sts='st *|sort -k 3,4'
alias psa='ps -L -e -o user,pcpu,cpu,pid,ppid,nice,state,start,cputime,args' lb='lsblk -o NAME,KNAME,MAJ:MIN,FSTYPE,MOUNTPOINT,LABEL,UUID,SIZE,STATE,SCHED,TYPE'
# Search in Files : arg1 Pattern [arg2 file_Suffix]
sf () { if [ "$1" = "-i" ]; then IGN="-i"; PAT=$2; S=$3; else IGN=""; PAT=$1; S=$2; fi; if [ -z $S ]; then F="*"; else F="*.$S"; fi; find . -name "$F" -type f -exec grep $IGN --color -H "$PAT" {} \; 2>/dev/null;}
# Cluster
export CLUSTER=alcor,castor,pollux m=/var/log/messages
alias o=drbd-overview c1='crm_mon -rAf' da=drbdadm zero_m='truncate --size 10 /var/log/messages'
alias p="pdsh -t 2 -w $CLUSTER" mp=mmpush dmp='for i in *; do mp $i; done'
alias t='multitail -ev irq /var/log/messages'
alias msd="mount /dev/mmcblk0p1 /mnt/sd";function pdf(){ du --max-depth=1 --one-file-system -h $@ |sort -h; }
alias o='osd_cat -l40 -o100 -i800 -d120 -A left -p top -cblue -f "fixed" &'
c(){ for ((x=1; x<=9; x++)); do echo -e "${x}:\033[38;5;${x}mColor\033[000m"; done| xargs -l3 echo;echo -n "choose> ";read -s -N 1 CCC 2>/dev/null || read -s CCC;echo;}
> /tmp/.$$.cd 2>/dev/null
cd(){ builtin cd "$@" && pwd >> /tmp/.$$.cd;}
xc(){ CCD=($(uniq /tmp/.$$.cd|tail -10));for i in ${CCD[@]};do echo $i;done|nl -v0;echo -n "choose> ";read -n 1 CD 2>/dev/null||read CD;echo;cd ${CCD[$CD]};}
#if [ $USER != root ];then
if [ -z "$SSH_CLIENT" ];then
  xmodmap -e "keycode 48 = bar percent"
  xmodmap -e "keycode 34 = asciicircum asciitilde"
  xmodmap -e "keycode 35 = dollar numbersign dollar sterling currency dead_macron"
  xmodmap -e "keycode 51 = asterisk backslash"
# LENOVO # xinput set-button-map $(xinput list | grep "HID 04b3:310d" |cut -d= -f2|awk '{print $1}') 1 3 2
#  xinput set-button-map 7 1 3 2
  xinput set-button-map $(xinput list | grep -im1 "optical" |cut -d= -f2|awk '{print $1}') 1 3 2
  xinput set-button-map $(xinput list | grep -im1 "GlidePoint" |cut -d= -f2|awk '{print $1}') 1 3 2
  xinput set-button-map $(xinput list | grep -im1 "Razer" |cut -d= -f2|awk '{print $1}') 1 3 2
fi

kh(){ [[ -n "$1" ]] && (KH=$1 ; sed -i "s/^$KH.*//g" ~/.ssh/known_hosts;VAR=$(timeout 1 getent ahostsv4 $KH|head -1|awk '{print $1}');if $(grep -q [[:digit:]] <<< $VAR); then sed -i "s/^$VAR.*//g" ~/.ssh/known_hosts; fi);}

#bind -x '"\ew":"~/osd_xsel.sh"'					 # display primary / clip (A-w)
#bind -x '"\ec":"~/osd_pwd-to-xsel.sh"'           # copy primary to clip (A-c)
#bind -x '"\ev":"echo -n $(date -I)|xsel -i -b"'  # transfert date to clip (A-v) / (C-S-v)
#bind -x '"\ep":"/root/Bin/pwd-to-xsel.sh"'       # copy PWD to clip (C-S-v)
#bind '"\e*": insert-last-argument'

export LANG=C
ex(){ exportfs -i -o rw,no_root_squash *:$(readlink -f $1);}
p=~/Project_CS;alias t2="tree -d -L 2" t3="tree -d -L 3"
hl() { GREP_COLORS="mc=0;46:ms=31:mt=01;41" grep --color "$2\|" $1;}
alias get.b="tftp kingston -c get .b"
alias pl='tac $m|grep -m1 DHCPOFFER|grep -o "142.1.[[:digit:]\.]*"'
alias b="unalias -a ; . ~/.bashrc" j="/opt/local/bin/jedit 2>/dev/null"
pi_(){ echo $USER@$(pi|head -1|awk '{print $NF}'|sed "s,/[[:digit:]][[:digit:]],,"):$PWD/$1;}

#BASHISHDIR="/usr/local/share/bashish"                 ## line added by bashish
#TTY=`tty 2>/dev/null` && if test "x$BASHISHDIR" != x;then       ## line added by bashish
#test "$BASHISH_OLDPATH"||BASHISH_OLDPATH="$PATH"                ## line added by bashish
#PATH="$HOME/.bashish/launcher:$BASHISHDIR/lib:$BASHISH_OLDPATH" ## line added by bashish
#BASHSISH_CP=437                                                 ## line added by bashish
#TEST_TERM="$TERM" _bashish_utfcheck && BASHISH_CP=utf8          ## line added by bashish
#ENV="$HOME/.profile"                                            ## line added by bashish
#export BASHISH_CP BASHISH_OLDPATH TTY ENV                       ## line added by bashish
#. "$BASHISHDIR/main/prompt/sh/init"                             ## line added by bashish
#fi                                                              ## line added by bashish
alias v="virsh list --all --title"
#loadkeys ~/dumpkeys.new
var_xbindkeys=$(pgrep xbindkeys)
[ ! -z "${var_xbindkeys##*[!0-9]*}" ] || xbindkeys
