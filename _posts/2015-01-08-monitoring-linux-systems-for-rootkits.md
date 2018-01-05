---
layout: post
title: "Monitoring Linux Systems for Rootkits"
date: 2015-01-08 16:01:28
categories: Linux
author: Michael Boelen
tags: [malware, monitoring, rootkit]
---


#### Extract
>Monitoring Linux Systems
Detecting and preventing rootkits
Rootkits are considered to be one of the most tricky pieces of malware. Usually they are loaded onto the system by exploiting weaknesses in software. Next phase is being installed and hide as good as possible, to prevent detection. We have a look at a few security measures you can take to prevent this kind of threat.
&nbsp;
System Protection

Kernel
The kernel is the brain of the software system and decides what should be executed by the central processing unit. Any &#8220;damage&#8221; to this system decreases the integrity of the system and your data. So protecting the kernel against unauthorized modifications is an important step in keeping system secure.
&nbsp;
Modules
Linux was originally a monolithic kernel, consisting of all functions in one piece of software. Nowadays its flexible, allowing additional functionality to be loaded when required. The downside of this is the chance that malicious people use this to load new kernel module, which in their turn alter how the kernel functions. For example when requesting a process listing, the kernel might leave out specific processes. Rootkits use these kind of tricks to prevent detection and it shows (pun intended).
&nbsp;
Binaries
Next in line are software components and system utilities in particular. Tools like ps, ls, netstat and others are targeted by rootkits, to avoid detection.
&nbsp;
Intrusion Detection
While prevention is a good thing, detection is usually even more valuable. After all, if you can&#8217;t detect an intrusion, how do you know for sure you are safe? Let&#8217;s have a look at a few possibilities to perform malware and intrusion detection.
&nbsp;
File Integrity Monitoring
Objective: Monitor changes to files and binaries in particular
How
File integrity monitoring can be implemented on different levels. Even a small script collecting all hashes could be a start. Better would be the usage of file integrity tools, which can detect changes and perform intrusion detection. Common examples include AIDE, AFICK and Samhain.
If you want to go even a step further, you can use IMA and EVM, which are Linux security modules to do file integrity for all files. When the kernel sees a file which is changed, it refuses to execute the file. This is definitely the maximum level of protection.
&nbsp;
Malware Detection Tools
Object: Use proper tooling to detect malware.
Tools like Rootkit Hunter help with detection some forms of rootkits. ClamAV and LMD are other great examples of tools who can search for traces of malware.
&nbsp;
Intrusion Prevention
While full system hardening is preferred, we focus on some powerful methods to prevent the biggest threats to break in.
&nbsp;
Upgrade the System
Objective: stay up-to-date with software components
How
Upgrade on a regular basis software components. Also implement a strategy on how to deal with security upgrades in particular. Most Linux distributions have a way to split these security patches, so you can easily focus on those first.
Reboot
Additionally it is wise to check for a required reboot. Patching is a great first step, but the kernel itself should be reloaded if there is a new version. Sure, we also know uptime is important and your customers don&#8217;t like reboots. But there is personal data at stake and usually more important than that tiny window of downtime.
&nbsp;
Disable kernel modules
Objective: Disable loading of kernel modules, if system does not require it.
How
Check lsmod output, blacklist modules which are not being used by using the blacklist file. Additionally, disable loading all kernel modules for full protection.
&nbsp;
Blacklist Kernel Modules
Create a custom file in /etc/modprobe.d directory, like custom-blacklisted.conf.
For example our output looks like this:

root@ubuntu:/etc/modprobe.d# lsmod
 Module                  Size  Used by
 ppdev                  17671  0
 serio_raw              13462  0
 i2c_piix4              22155  0
 joydev                 17381  0
 parport_pc             32701  0
 mac_hid                13205  0
 lp                     17759  0
 parport                42348  3 lp,ppdev,parport_pc
 xts                    12914  1
 gf128mul               14951  1 xts
 dm_crypt               23177  1
 hid_generic            12548  0
 usbhid                 52570  0
 hid                   106148  2 hid_generic,usbhid
 psmouse               106678  0
 ahci                   25819  2
 libahci                32560  1 ahci
 e1000                 145174  0

So let&#8217;s blacklist these items with:
blacklist e1000
blacklist psmouse
blacklist usbhid
blacklist hid_generic
blacklist lp
blacklist mac_hid
blacklist ppdev
blacklist serio_raw
blacklist i2c_piix4
blacklist joydev
blacklist parport_pc
Surprisingly we still see some show up after rebooting the system.

root@ubuntu:/etc/modprobe.d# lsmod
Module                  Size  Used by
lp                     17759  0
parport                42348  1 lp
xts                    12914  1
gf128mul               14951  1 xts
dm_crypt               23177  1
hid_generic            12548  0
usbhid                 52570  0
hid                   106148  2 hid_generic,usbhid
psmouse               106678  0
ahci                   25819  2
libahci                32560  1 ahci
e1000                 145174  0

Some modules are still being loaded, like lp, usbhid and e100. This is due the modules being loaded at boot time. Some are actually needed, although the output looks like the module is being unused. For example e1000 is our network driver.
The lp module on the other hand is not needed, as can be seen by the dmesg output for lp: [  219.078098] lp: driver loaded but no devices found.
So we should disable this driver from /etc/modules:
Kernel modules to be loaded at boot time
After adding a hash to the line starting with &#8220;lp&#8221;, we reboot the system another time. This time it is gone. Due to the blacklist line, services like udev can not load it anymore. However, modprobe still can. So we have to put in another layer of defense: disable loading new kernel modules.
&nbsp;
Disabling Loading of Kernel Modules
To disable new modules from being loaded, a kernel setting have to be put in place via the sysctl command. By setting the value for kernel.modules_disabled to 1, no more kernel modules can be loaded.
Linux kernel modules being disabled with sysctl key
As can be seen in the screenshot above, the system refuses to turn on the setting again (even though it displays the value of 0). The great thing of this option is that attackers can&#8217;t disable this setting without rebooting the system. To keep things secure, you might want to monitor the system for unauthorized reboots as well.
&nbsp;
The post Monitoring Linux Systems for Rootkits appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/monitoring-linux-systems-for-rootkits/)

id:  191490
