---
layout: post
title: "5 Basic Principles of Linux System Security"
date: 2015-02-26 17:36:03
categories: Linux
author: Michael Boelen
tags: [hardening, secure, basics, principles, security]
---


#### Extract
>5 Basic Principles of Linux System Security
It is still common that people do not know where to start when it comes to information security. With 5 basic principles we can improve the Linux system security and question ourselves if we have done enough.
&nbsp;
1. Know your system(s)
The first principle is about knowing what your system is supposed to do. What is its primary role, what software packages does it need and who needs access?
By knowing the role of the system you can better defend it against known and unknown threats.
&nbsp;
Security Measures:
&nbsp;

Password policy
Proper software patch management
Configuration management
Documentation

&nbsp;
2. Least Amount of Privilege
Each process running, or package installed, might become a target. Security professionals call this the &#8220;attack surface&#8221;. What you want is to minimize this attack surface by removing unneeded components, limit access and by default use a &#8220;deny unless&#8221; strategy. This latter means that access by default is blocked, unless you allow it (whitelisting).
Security Measures:
&nbsp;

Use minimal/basic installation
Only allow access to people who really need it


3. Perform Defense in Depth
Protect the system by applying several layers of security. This principle is named &#8220;defense in depth&#8221; and can be compared with an onion: to get to the core, you have to peel of layer by layer. One broken defense might help us protect against full compromise.
Security Measures:
&nbsp;

IPtables / Nftables
Hardening of software components


4. Protection is Key, Detection is a Must
Security focuses on the protection of assets. While this is a primary objective, we should consider that one day our defenses are broken. Therefore we want to know this as soon as possible, so we can properly act. This is where principle 3 and 4 both are linked. Set-up proper detection methods, similar to the trip wires used by the military.
Security Measures:
&nbsp;

Linux audit framework
Remote Logging
Create backups and test them

&nbsp;
5. Know your Enemy
&nbsp;
You can only protect a system the right way, if you know what threats you are facing. Why would this system be a target and who would be targeting it? Perform a risk analysis and determine what potential threats your system might endure.
&nbsp;
Security Measures:
&nbsp;

Vulnerability scans
Penetration tests
Risk analysis

&nbsp;
The post 5 Basic Principles of Linux System Security appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/5-basic-principles-of-linux-system-security/)

id:  205852
