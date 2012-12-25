#!/bin/sh
#Ventrilo Script v2.1.0_02 written by Crypt Keeper
#For ventrilo server v2.x

# Comments to support chkconfig on RedHat Linux
# chkconfig: 2345 64 36

#Replace the values of VENPATH and VENSRV with your ventrilo path and server name.
#Replace the value of VENUSER with the account name that ventrilo runs under.
VENPATH=/home/ventrilo
VENSRV=$VENPATH/ventrilo_srv
VENUSER=ventrilo
VENPORT=3784

if [ "$UID" -ne 0 ]; then
  echo "You must be root to run this script"
  exit 64
fi

check_pid (){
  if [ -e $VENPATH/$1.pid ]; then
    PID=`cat $VENPATH/$1.pid`
  else
    PID=0
  fi
}

start (){
  if [ -z $1 ]; then
    PORT=${VENPORT}
  else
    PORT=$1
  fi
  su ${VENUSER} -c "${VENSRV} -f${VENPATH}/${PORT} -d"
  check_pid ${PORT}
  if [ ${PID} -ne 0 ]; then
    renice -20 ${PID}
    echo
    echo "Ventrilo server on Port ${PORT} Started."
    echo
    exit 0
  else
    echo
    echo "ERROR Ventrilo server on Port ${PORT} Failed to Start"
    echo
    exit 1
  fi
}

stop (){
  if [ -z $1 ]; then
    PORT=${VENPORT}
  else
    PORT=$1
  fi
  check_pid ${PORT}
  if [ ${PID} -ne 0 ]; then
    kill $PID
    echo
    echo "Ventrilo server on Port ${PORT} with PID ${PID} Stopped."
    echo
    exit 0
  else
    echo
    echo "ERROR Ventrilo server on Port ${PORT} Not Running."
    echo
    exit 1
  fi
}

case $1 in
  -h|--help)
    echo
    echo "Ventrilo Script originally by Crypt Keeper"
    echo "  start   (port# optional. Default will use ${VENPORT})"
    echo "  stop    (port# optional. Default will use ${VENPORT})"
    echo "  restart (port# optional. Default will use ${VENPORT})"
    echo "  status  (port# optional. Default will use ${VENPORT})"
    echo
  ;;
  [sS][tT][aA][rR][tT])
    start
    ;;
  [sS][tT][oO][pP])
    stop
    ;;
  [rR][eE][sS][tT][aA][rR][tT])
    stop
    start
    ;;
  [sS][tT][aA][tT][uU][sS])
    check_pid
    if [ ${PID} -ne 0 ]
    then
      echo
      echo "Ventrilo server on Port ${PORT} -Running- with PID ${PID}"
      echo
      exit 0
    else
      echo
      echo "Ventrilo server on Port:"$2" -Not Running-"
      echo
      exit 1
    fi
    ;;
  * )
    echo
    echo "Invalid Argument $1"
    echo "-h|--help for usage"
    echo
    exit 1
  ;;
esac
exit 0