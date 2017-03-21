# i3
i3 config and support scripts

For ubuntu 16.04 do:

    git clone git@github.com:rlrosa/i3.git
    cd i3
    # backup current settings
    cp ~/.config/i3/config ~/.config/i3/config.bkp
    cp ~/.i3status.conf ~/.i3status.conf.bkp
    # use new settings
    cp i3.conf ~/.config/i3/config
    cp i3status.conf ~/.i3status.conf

To setup multiple monitors you'll need to tweak the i3.conf file to fit your setup, then run:

    mkdir ~/bin
    cp monitor-toggle.sh ~/bin/
    chmod +x ~/bin/monitor-toggle.sh
    # follow instructions in dock.rules to complete.
