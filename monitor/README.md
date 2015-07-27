## Monitor

Monitoring solutions can be expensive, they are definitely worth their while; but there may be things
that you want to monitor without having to pay a King's Ransom. This script provides a way to check vital
measurables on a web server, straight from your command line.

As you may, or may not know, you can remotely send Unix commands to a remote server with the ssh command. For example,
`ssh user@host.com 'uptime'`, will login to the remote server and execute the `uptime` command and output the 
results to STDOUT. If there are 10 different commands, you'd have to login 10 times every time you wanted to monitor something.

### What does this do?

Right now this script is going to make sure that Apache and MySQL are running, it's going to check the server load with uptime and
it's going to check the disk storage. It makes some assumptions about what is reasonable, for example (0.00 - 0.50) load will analyze
as Good! 0.51 - 1.00 will be analyzed as "the high side of good" and 1.01+ will be analzyed as "Higher than acceptable". The same
assumptions are made with storage < 60% is good, 60%-80% is a warning, 80%+ needs to be addressed right away.


### What's next

This isn't meant to replace the large paid options, but might serve as a nice little stop gap if you need. I have a few features in mind,
including but not limited to:

* Configuration of processes: provide a config file of all the processes you expect to have running
* Mail script configuration: provide a script that is capable of sending warning/error emails
* Configuration of limits: provide a configuration for the threshhold of alerts and warnings.
