# MacPorst-update-cron

This repo is intended to host a simple bash script to be run by a cron on your Mac OSX to perform regular updates of the MacPorts base


## How to install

* Clone the repo or just copy `ports-update.sh` in your Mac OSX workstation filesystem.
* Make sure `ports-update.sh` has execution rights
* Become root and create a cron entry via terminal with just typing `crontab -e` and edit the cron to run the script at your will 