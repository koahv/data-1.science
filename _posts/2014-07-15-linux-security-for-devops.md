---
layout: post
title: "Linux Security for DevOps"
date: 2014-07-15 08:10:22
categories: Linux
author: Michael Boelen
tags: [development, linux, system administration, devops]
---


#### Extract
>Linux Security for DevOps
During the last years the role of DevOps evolved. This person could be described as the hybrid: a system administrator with development skills, or the developer which is also infrastructure savvy. With Linux and so many available tooling, it is becoming easier for people to learn both development and managing infrastructures.
We are especially interested in Linux security for DevOps and what they can apply.
Automation is key
Repeating work is not only boring, but also a waste of time. Every step which is repeated, might be a great candidate for automation. With solutions like Puppet, is has become easy to automate installations, software installation and configuration.
Security from the start
Whenever possible, tighten up your defenses. For example, roll-out iptables on each machines by default, with a standard strict template. When a particular system has to become a web server, let Puppet open up the related web ports.
Software patching
Most system administrators are aware of the difficulties when dealing with many different software versions. Therefore, keep an eye on software upgrades and embed software patch management in your routines. Especially security patches should be evaluated at the moment they are released and put into production when appropriate.
Log &amp; Event management
Automate the collection, parsing and alerting for suspicious events. If you are a puppet master, you want to know exactly what is going on. As highlighted in the first point, automation is key. Manual activities should only be done for the exceptions, outliers and control activities.
Befriend your CMDB
The configuration management database, or CMDB, is the central place where all information about systems are located. Properly interfacing with your CMDB will save a lot of time. Most solutions have a way to interact and gather data, like in XML/JSON format.
At the very moment a system is installed, decommissioned or offline, all related components should up-to-date. You don&#8217;t want to turn on a system, which was just replaced by another one.
Don&#8217;t build your own islands
While it might be great to build your own solutions, try to leverage existing solutions within the company. From the previously mentioned CMDB, used software components, documentation tools or developer repositories. Focus on automation and using the core components which already exist.
Perform audits
Screenshot of a Unix security audit performed with Lynis.
Besides automation, also include running regular audits. Simply trusting your configuration management solution is not enough. The Plan-Do-Check-Act cycle is the perfect method to apply. Keep on improving in steps and don&#8217;t forget the &#8220;Check&#8221;.
Security audits will give new insights and room for improvement. If you are keen on keeping your system healthy, perform regular checks. This includes for unauthorized users, specific events in your log files.
Don&#8217;t be shy to let others audit your environment. This includes IT auditors, a consultant or colleague. You can&#8217;t know and have it all. Others might challenge you to think about the best possible solution, while you thought you already had it. There is always room for improvement and it is usually your friendly coworkers who can see it. Trust on your knowledge and be open for input.
The post Linux Security for DevOps appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/linux-security-for-devops/)

id:  191539
