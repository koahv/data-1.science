---
layout: post
title: "Securing mount points on Linux"
date: 2014-11-06 10:21:39
categories: Linux
author: Michael Boelen
tags: [hardening, storage, file system]
---


#### Extract
>Securing mount points
Mount points are defined in /etc/fstab. They link a particular disk pointer to the related device (disk, partition or virtual device). By default the mount options are not focused on security, which gives us a room to further improve hardening of the system. This hardening is especially important considering our most precious data is stored here. Via mount options we can apply additional security controls to protect our data.
Mount points
Let&#8217;s have a look at our /etc/fstab file.
Example output:

# &lt;file system&gt; &lt;mount point&gt;   &lt;type&gt;  &lt;options&gt;       &lt;dump&gt;  &lt;pass&gt;
proc            /proc           proc    defaults        0       0


In the options column, the related mount options are defined. In this particular case it has &#8220;defaults&#8221; for /proc, meaning the options rw, suid, dev, exec, auto, nouser, and async are set.

rw = read write
auto = mount automatically
nouser = do not allow a user to mount the file system
async = asynchronous saving of data, to improve performance

Since this is a virtual file system, which has no user data or binaries stored, we leave it with the defaults option.
Regarding the remaining options (suid, dev, exec), we will have a look at their &#8220;negative&#8221; opposites, to show how we can apply them to harden the system.
nodev
This option describes that device files are not allowed, like block or character devices. Normally these are only found under /dev and not seen on other mount points. Most mount points will work correctly when these are disabled, with the root file system as an exception.
Useful for: /boot /dev/shm /home /tmp /var and data partitions
Not suitable for: root (/)
noexec
With this option set, binaries can&#8217;t be directly executed.
Useful for: /boot /dev/shm /var and data partitions.
Not suitable for: root (/), /home (when using steam, wine or development) and /tmp (e.g. compiling applications might break)
nosuid
Do not use set-user-identifier (SETUID) or set-group-identifier (SETGID) bits to take effect. These bits are set with chmod (u+s, g+s) or unset (u-s, g-s) to allow a binary running under a specific user, which is not the active user itself. For example, to allow a normal user to run the ping command with root privileges. This is needed to allow opening a socket.
Useful for: /boot /dev/shm /home /tmp /var and data partitions
Not suitable for: root (/)
Apply system hardening
To harden mount points, replace the defaults entry and add the related options to the related field. When applying multiple options, separate them with a comma.
&nbsp;
The post Securing mount points on Linux appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/securing-mount-points-on-linux/)

id:  191511
