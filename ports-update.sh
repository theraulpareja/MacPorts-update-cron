#!/usr/bin/env bash

# Global vars
LOGDIR=/var/log/ports-update
LOG=$LOGDIR/ports-update.log
NSYSLOG=/etc/newsyslog.d/ports-update.conf
PORT=/opt/local/bin/port
REBOOTDELAY=180

if [ "$EUID" -ne 0 ]; then
    echo "[ERROR]: Please run as root"
    exit 1
fi

echo "*** $(date +"%d-%m-%Y:%T") *****" >> $LOG
if [[ "$OSTYPE" != "darwin"* ]]; then
    echo "[ERROR]: This bash scripts expects to run MacPorts in a mac osx operating system" | tee -a $LOG
    exit 2
else
    # Check newsyslog format in https://www.freebsd.org/cgi/man.cgi?newsyslog.conf(5)
    if [ ! -f $NSYSLOG ]; then
        echo "[INFO]: Seems like this is the very first time, let's configure log rotation for this script for you" >> $LOG
        echo "$LOG  :                  600  2     1024      *     J" > $NSYSLOG
    fi

    if [ ! -d $LOGDIR ]; then
        echo "[INFO]: Creating logs directory" >> $LOG
        mkdir -p $LOGDIR
    fi
    echo "Updating MacPorts base:" >> $LOG
    echo "[DEBUG]: Uptime at the moment of ports update $(uptime)" >> $LOG
    echo "[DEBUG]: Will wait $REBOOTDELAY seconds to let the networking service to wake up" >> $LOG
    sleep $REBOOTDELAY 
    $PORT selfupdate >> $LOG
    if [ $? -eq 0 ]; then
        echo -e "MacPorts base sources updated, consider to upgrade outdated ports with:\n\tport upgrade outdated " | tee -a $LOG
        echo -e "************************************\n" >> $LOG
    else
        echo "[ERROR]: Something went wrong with MacPorts base update please check logs in $LOG"
        exit 3
    fi
fi
