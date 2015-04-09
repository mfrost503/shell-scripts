## Manage VMS

This is a simple shell script to manage your Vagrant VMs. It works by issuing a `cd` command and navigating to the directory
where you have all your VMs. From there it will issue the `vagrant` commands and issue those commands on your machines.

This is a first iteration, likely there will be a flag that will allow you to execute certain commands on all boxes.
The currently supported commands are:

* up
* suspend
* halt
* ssh
* provision
* version
* help
* reload
* status

Make sure this script has `+x` permission, copy it to your /usr/bin (or any other path in you $PATH env variable)
and access it directly from there.

To run a command on a single box:

`vms -b mybox -a up`

If you only have one box you can set the box variable in the script and run it like so:

`vms -a up`

Its nothing fancy but it saves me a little bit of time. Once I get the multi-vm support finished, it'll likely be a
huge time-saver for those who have to run multiple boxes.
