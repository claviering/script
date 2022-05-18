#! /bin/sh
status=$(ifconfig en0 | tail -n 1)
echo $status
if [ ${#status} -eq 15 ]
then
    sudo ifconfig en0 down
    echo "down"
else
    sudo ifconfig en0 up
    echo "up"
fi