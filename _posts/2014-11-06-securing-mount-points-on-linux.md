---
layout: post
title: "Securing mount points on Linux"
date: 2015-09-30
categories: Linux
author: Michael Boelen
tags: [Mount (computing), Computer file, File system, Device file, Setuid, Disk partitioning, Superuser, Operating system technology, Information retrieval, Computers, Computer engineering, Computing, System software, Digital technology, Computer architecture, Software, Computer data, Information technology management, Data management, Utility software, Data, Storage software, Areas of computer science]
---


#### Digest
>digest unavailable

#### Extract
>Securing mount points Mount points are defined in /etc/fstab. They link a particular disk pointer to the related device (disk, partition or virtual device). By default the mount options are not focused on security, which gives us a room to further improve hardening of the system. This hardening is especially important considering our most precious data is stored here. Via mount options we can apply additional security controls to protect our data. Mount points Let&#8217;s have a look at our /etc/fstab file. Example output: # &lt;file system&gt; &lt;mount point&gt;   &lt;type&gt;  &lt;options&gt;       &lt;dump&gt;  &lt;pass&gt; proc            /proc           proc    defaults        0       0 In the options column, the related mount opti...

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/securing-mount-points-on-linux/)


