# MacPorst-update-cron

This repo is intended to host a simple bash script to be run by a cron on your Mac OSX to perform regular updates of the MacPorts base

## Why use a script to update MacPorts with a cron?

Is helpful to have regular updates of the MacPorts base, sometimes this process can take a while and if it can be done in the background, it can save you some waiting minutes and go straight to install brand new ports or upgrade those potentially outdated, another benefit of it is obviously that you can fullty control when you want the updates to hapen and the script will provide youlogs of the updates by default in `/var/log/ports-update` and take care of the logrotation setting up the newsyslog config.


## How to install

* Clone the repo or just copy `ports-update.sh` in your Mac OSX workstation filesystem.
* Make sure `ports-update.sh` has execution rights
* Become root and create a cron entry via terminal with just typing `crontab -e` and edit the cron to run the script at your will 
 
