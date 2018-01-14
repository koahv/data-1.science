---
layout: post
title: "Securing mount points on Linux"
date: 2014-11-06 10:21:39
categories: Linux
author: Michael Boelen
tags: [hardening, storage, file system]
---


#### Extract
>Securing mount points Mount points are defined in /etc/fstab. They link a particular disk pointer to the related device (disk, partition or virtual device). By default the mount options are not focused on security, which gives us a room to further improve hardening of the system. This hardening is especially important considering our most precious data is stored here. Via mount options we can apply additional security controls to protect our data. Mount points Let&#8217;s have a look at our /etc/fstab file. Example output: # &lt;file system&gt; &lt;mount point&gt;   &lt;type&gt;  &lt;options&gt;       &lt;dump&gt;  &lt;pass&gt; proc            /proc           proc    defaults        0       0 In the options column, the related mount options are defined. In this particular case it has &#8220;defaults&#8221; for /proc, meaning the options rw, suid, dev, exec, auto, nouser, and async are set. rw = read write auto = mount automatically nouser = do not allow a user to mount the file sys...

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/securing-mount-points-on-linux/)

id:  191511
