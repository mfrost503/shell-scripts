#!/bin/bash
box=""
action=""
vagrantPath="/Users/mattfrost/vagrant/"
function usage()
{
    echo "Usage: manage-vm -b <folder with vagrant file> -a <vagrant action to perform>"
}

function die()
{
    echo >&2 "$@"
    usage
    exit 1
}

[ "$#" -eq 2 ] || [ "$#" -eq 4 ] || [ "$1" == '-h' ] || die "You must provide a box and an action"
if [ "$1" == "-b" ]; then
    echo $2 | grep -E -q '^[A-Za-z0-9_-]+$' || die "Invalid box name"
fi

if [ "$3" == "-b" ]; then
    echo $4 | grep -E -q '^[A-Za-z0-9_-]+$' || die "Invalid box name"
fi

while getopts ":b:a:h:box:action:help:" opt; do
    case $opt in
        b | box )    box="$OPTARG"
                        ;;
        a | action ) action="$OPTARG"
                        ;;
        h | help )   usage
                     exit
                        ;;
    esac
done

case $action in
    up ) ;;
    suspend ) ;;
    halt );;
    ssh ) ;;
    provision ) ;;
    version )  ;;
    help ) ;;
    reload ) ;;
    status ) ;;
    * ) usage
        exit
        ;;
esac
box=$(echo $box | tr -d '\r')
action=$(echo $action | tr -d '\r')
path=$(echo $vagrantPath | tr -d '\r')
vagrant="cd $path$box && vagrant $action"
echo $vagrant
eval $vagrant
