#!/bin/bash
#
# dock -- reconfigure monitors and window manager when laptop is un/docked
#

#--------------------------------------- PRELIMINARIES ------------------------

# Restrict executable search path
PATH="/usr/local/bin:/usr/bin:/bin:/home/rrosa/bin"

# Script name for logging
me=`basename $0`

nonroot=rrosa
# If running as root (e.g., via a udev rule or devd action), become normal user
[ `id -u` -eq 0 ] && {
    logger  -t $me "running as root; becoming ordinary user $nonroot"
    exec su -c $0 - $nonroot
}

# Ensure X is running
pgrep X > /dev/null 2>&1 || {
    logger -t $me "unable to find X server PID"
    exit 1
}

# Set DISPLAY in case X is up but the environment variable isn't defined (can
# happen, for example, when run via udev or devd).
[ -z "$DISPLAY" ] && {
    logger -t $me "X server up but DISPLAY not defined; setting to :0.0"
    export DISPLAY=":0.0"
}

#-------------------------------------------- MAIN ----------------------------

# do your monitor toggle stuff here
laptopScreen=eDP1
secondMonitor=DP2-1
thirdMonitor=DP2-2

logger -t $me $@

logger -t $me "Monitors: $laptopScreen, $secondMonitor, $thirdMonitor"

# force turn off
if [[ -z $4 ]]; then
    logger -t $me "Checking if monitors are on"
    isOn=`xrandr | grep "${secondMonitor}" | grep "+0"`
    enableSecond=`xrandr | grep "${secondMonitor} connected"`
    enableThird=`xrandr | grep "${thirdMonitor} connected"`
else
    isOn=on
fi

if [[ -z "$enableSecond" ]]; then
    logger -t $me "Turning off $secondMonitor"
    xrandr --output $secondMonitor --off
else
    logger -t $me "Turning ON $secondMonitor"
    xrandr --output $secondMonitor --auto --left-of $laptopScreen --rotate right
fi

if [[ -z "$enableThird" ]]; then
    logger -t $me "Turning off $thirdMonitor"
    xrandr --output $thirdMonitor --off
else
    logger -t $me "Turning ON $thirdMonitor"
    xrandr --output $thirdMonitor --auto --above $laptopScreen
fi

# Reload this, apparently udev resets this?
xmodmap ~/.Xmodmap
touchpad.sh --disable
#------------------------------------------------------------------------------

##############################################
# Editor config:                             #
##############################################
# Local Variables:                           #
# indent-tabs-mode: nil                      #
# sh-basic-offset: 4                         #
# fill-column: 96                            #
# End:                                       #
##############################################
# vim: set expandtab shiftwidth=4 tabstop=4: #
# vim: set textwidth=96:                     #
##############################################
