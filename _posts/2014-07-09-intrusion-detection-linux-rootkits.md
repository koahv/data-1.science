---
layout: post
title: "Intrusion detection: Linux rootkits"
date: 2014-07-09 08:55:50
categories: Linux
author: Michael Boelen
tags: [intrusion detection, rootkit]
---


#### Extract
>Intrusion detection: Linux rootkits
Rootkits
Rootkits are installed components on a server by a person with malicious intent. The main goal is hiding its presence and avoid the eye of the system administrator. Rootkits usually consist of a set of tools, to manipulate the Linux kernel, alter output to the screen or avoid some software from doing its tasks.
Nowadays rootkits are less popular than they were before. One of the reasons is the increased security in the Linux kernel, making it harder to circumvent some areas (like using some system calls). Still they occur, or in a slightly different form. For example backdoors are still very popular. Often the attacker doesn&#8217;t even need full root access to abuse a system for other purposes. Helping in a Distributed Denial of Service (DDoS), sending spam, or act as a hop to attack other systems, to name a few.
Detection methods
Since rootkits are malicious, they should be detected as soon as possible.
File integrity tools
One method to detect alterations to a system is with the help of file integrity tools. These suites consist of a file database, checksums and utilities to check the current state compared with an earlier moment in time. Well-known tools are AIDE, Samhain and Tripwire in this area.
Rootkit scanners
Specialized tools exist to detect for traces of rootkits. These rootkit scanners search for common and uncommon files, compare the outputs of different utilities and try to trick a rootkit in revealing itself again. Rootkit Hunter and Chkrootkit are the most known tools.
Log file analysis
Suspicious events like daemons crashing could be a first trace in a system break-in. While not directly related with a rootkit, monitoring log files for special events will definitely help in protecting a system from a different level.
Conclusion
For detecting rootkits we advice the combination of file integrity tools and rootkit scanners. The latter aren&#8217;t always 100% reliable in detection, but usually they are still the best bet in detecting a rootkit.
Tools
Some tools mentioned in this post:

Rootkit Hunter
Chkrootkit
OSSEC
AIDE (Advanced Intrusion Detection Environment)
Tripwire

Stay secure!
Enjoyed reading the article? Share your discovery with others:The post Intrusion detection: Linux rootkits appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/intrusion-detection-linux-rootkits/)

id:  191541
