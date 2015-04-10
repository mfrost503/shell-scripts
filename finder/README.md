## FINDER

This script will allow you to search the files in a directory for a specfic term. This script uses the `find` command, xargs and grep to search. By default the command will search the current directory. There are flags available that allow you to search a different directory, to search for directories, to search files by extension and make a case insensitive search. By default all searches are case sensitive, searching all file types and look for files and not directories. Below is an example of the available flags for this script.

### Arguments:

* -s - required - term that you are searching the files for
* -d - optional - directory to search (default: ./)
* -t - optional - only values are `d | f` (default: f)
* -f - optional - filename to search for (example: \*.php searches all files with .php in the name
* -i - optional - turn on case insensitivity
* -h - optional - show help message

Command: `finder -s require`

I've found this useful for finding terms in code and other files. The output, by default will list the file, line number and give a brief output of the term in the results.

### Installation

* Clone this repo 
* Ensure +x permission is set `chmod +x finder.sh`
* If you want it globally available you can copy to /usr/bin or some other path in your $PATH ENV Variable `cp finder.sh /usr/bin/finder`
* Run with either `/path/to/finder.sh` or `finder` (if you placed it in a $PATH dir
