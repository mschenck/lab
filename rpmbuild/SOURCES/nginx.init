#!/bin/sh
#
# nginx - this script starts and stops the nginx daemon
#
# chkconfig:   - 85 15
# description:  Nginx is an HTTP(S) server, HTTP(S) reverse \
#               proxy and IMAP/POP3 proxy server
# processname: nginx
# config:      /etc/nginx/nginx.conf
# config:      /etc/sysconfig/nginx
# pidfile:     /var/run/nginx.pid

# Source function library.
. /etc/rc.d/init.d/functions

# Source networking configuration.
. /etc/sysconfig/network

# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0

nginx="/usr/sbin/nginx"
prog=$(basename $nginx)

NGINX_CONF_FILE="/etc/nginx/nginx.conf"

[ -f /etc/sysconfig/nginx ] && . /etc/sysconfig/nginx

lockfile=/var/lock/subsys/nginx

start() {
    [ -x $nginx ] || exit 5
    [ -f $NGINX_CONF_FILE ] || exit 6
    echo -n $"Starting $prog: "
    daemon $nginx -c $NGINX_CONF_FILE
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
}

stop() {
    echo -n $"Stopping $prog: "
    killproc $prog
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}

restart() {
    configtest_q || configtest || return 6
    stop
    start
}

reload() {
    configtest_q || configtest || return 6
    echo -n $"Reloading $prog: "
    killproc $nginx -HUP
    echo
}

configtest() {
  $nginx -t -c $NGINX_CONF_FILE
}

configtest_q() {
    configtest >/dev/null 2>&1
}

rh_status() {
    status $prog
}

rh_status_q() {
    rh_status >/dev/null 2>&1
}

# Upgrade the binary with no downtime.
upgrade() {
    local pidfile="/var/run/${prog}.pid"
    local oldbin_pidfile="${pidfile}.oldbin"

    configtest_q || configtest || return 6
    echo -n $"Staring new master $prog: "
    killproc $nginx -USR2
    retval=$?
    echo 
    sleep 1
    if [[ -f ${oldbin_pidfile} && -f ${pidfile} ]];  then
        echo -n $"Graceful shutdown of old $prog: "
        killproc -p ${oldbin_pidfile} -QUIT
        retval=$?
        echo 
        return 0
    else
        echo $"Something bad happened, manual intervention required, maybe restart?"
        return 1
    fi
}

case "$1" in
    start)
        rh_status_q && exit 0
        $1
        ;;
    stop)
        rh_status_q || exit 0
        $1
        ;;
    restart|configtest)
        $1
        ;;
    force-reload|upgrade) 
        rh_status_q || exit 7
        upgrade
        ;;
    reload)
        rh_status_q || exit 7
        $1
        ;;
    status|status_q)
        rh_$1
        ;;
    condrestart|try-restart)
        rh_status_q || exit 7
        restart
	    ;;
    *)
        echo $"Usage: $0 {start|stop|reload|configtest|status|force-reload|upgrade|restart}"
        exit 2
esac
