#!/bin/bash

### Define some colors
Color_Off="\033[0m"       # Text Reset
Green="\033[0;32m"        # Green
Red="\033[0;31m"          # Red
Cyan="\033[0;36m"         # Cyan

### INITIALIZATION AND DEFAULTS
DIRECTORY="./"
FILETYPE="f"
FILENAME=""
SEARCH=""
INSENSITIVE=0

## Trying to create a relatively decent looking usage page...
function usage()
{
    echo -e "$Green"
    echo Usage:
    echo -e "$Color_Off"
    echo "   Finder is a script that will allow you to search files for a specific term."
    echo "   By default, it searches in the current directory, recursively - but it can be configured to search anywhere."
    echo "   Here's a look at some of the options:"
    echo -e "$Cyan"
    echo "      -s | Search Term - required for every call"
    echo "      -d | Directory - (optional) defaults to ./ a different directory can be provided using this flag"
    echo "      -f | filename - (optional) can be entered as a full filename or *.php, which would look in all files with .php in the name"
    echo "      -t | file type - (optional) defaults to 'f' for files, 'd' can be provided"
    echo "      -i | case insensitive - (optional) performs a case insensitive search"
    echo -e "$Green"
    echo "Example command:"
    echo -e "$Color_Off"
    echo -e "$Red"
    echo     "finder -s database -t f -d ./ -f *.php"
    echo -e "$Color_Off"
}

## Loop through all the provided parameters and assign vars
while getopts ":s:f:d:t:hi" opt; do
    case $opt in
        s|--search ) SEARCH="$OPTARG"
            ;;
        d|--dir ) DIRECTORY="$OPTARG"
            ;;
        f|--file ) FILENAME="$OPTARG"
            ;;
        t|--type ) FILETYPE="$OPTARG"
            ;;
        i ) INSENSITIVE=1 
            ;;
        h ) usage
            exit 0
            ;;
        * ) ;;
    esac
done

## Check for empty string, if found throw usage and exit
case $SEARCH in
    "" )    usage
            exit 
            ;;
    * )     ;;
esac

## Check for d | f type otherwise throw usage and exit
case $FILETYPE in
    d ) ;;
    f ) ;;
    * ) usage
        exit
        ;;
esac

## Remove any carriage return characters from the arguments
DIRECTORY=$(echo $DIRECTORY | tr -d '\r') 
SEARCH=$(echo $SEARCH | tr -d '\r') 
FILETYPE=$(echo $FILETYPE| tr -d '\r') 
FILENAME=$(echo $FILENAME | tr -d '\r') 

## Build the first part of the find command
COMMAND="find $DIRECTORY -type $FILETYPE"

## If the filename isn't empty add the -name argument to find
if [ ! -z $FILENAME ]; then
    COMMAND="$COMMAND -name '$FILENAME'"
fi

## Add the next component of the command to find
COMMAND="$COMMAND -print0 | xargs -0"

## if -i flag was set add i flag to grep command
if [ $INSENSITIVE -gt 0 ]; then
    COMMAND="$COMMAND grep -ni '$SEARCH'"
else
    COMMAND="$COMMAND grep -n '$SEARCH'"
fi

### After the concatenation, run what we have
eval $COMMAND
