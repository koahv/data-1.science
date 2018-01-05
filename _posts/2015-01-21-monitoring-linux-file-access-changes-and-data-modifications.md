---
layout: post
title: "Monitoring Linux File access, Changes and Data Modifications"
date: 2015-01-21 17:06:12
categories: Linux
author: Michael Boelen
tags: [auditing, intrusion detection, linux, change management, data, evm, file access, file integrity, file integrity monitoring, file modification, ima]
---


#### Extract
>Monitoring File access, Changes and Data Modifications
&nbsp;
Linux has several solutions to monitor what happens with your data. From changing contents to who accessed particular information, and at what time.
For our auditing toolkit Lynis, we researched and tested several solutions over the last few years. In this article we have a look at these solutions to monitor file access, changes and modifications to the data and beyond.
What is Data?
Data is a collection of bits, ordered in such a way it gives meaning to humans. The related information stored in data blocks, can be as simple as text, or become a visible representation like an image. Data is usually the most important part on a system, which means it has to be properly safeguarded.
Data versus Meta-data
Besides the information stored for us, the system needs to store a little bit of information as well. For example a data block on disk, might need some supporting information to know where it is stored. This data is usually not useful for us, but certainly for the system to retrieve the information, especially when we ask for it. This &#8220;data about data&#8221; is called meta-data. So besides protecting data, we have to take the protection of meta-data in mind as well.
Monitoring File Access
The first level of monitoring is who is accessing specific files. This helps us understand what particular files are being accessed, by what process and by whom. To accomplish this task, we can use the Linux audit framework. The framework is written by Red Hat and uses &#8220;watches&#8221; on files and directories to determine what should be monitored. Additionally it can monitor processes, including the underlying system calls which are performed by them.
Adding watches
To protect our kernel configuration, we can determine who accesses the sysctl.conf file. This file stores kernel settings, so it interesting to start with this file. To have this file monitored, we need to add a watch on the file.
auditctl -w /etc/sysctl.conf -p a -k kernel
The parameter -w sets the watch, followed by the file name. The -p defines the related permission action (a = attribute change, r = read, w = write, x = execute). It looks similar to file permissions, but actually it is slightly different. With the -k we define a custom key, which simplifies searching at a later moment. It is also helpful to categorize events.
Reporting watches
Now we have defined our watch, we can search for it with the earlier defined key.
ausearch -k kernel
Running this command gives us the following output:
File access monitoring with Linux audit framework
When looking at this output, you might be overwhelmed by all the fields available. Additionally some fields actually have rather strange values, like an architecture of c000003e (which actually equals x86_64).
The most important fields are the purple box, showing what object was hit and the green box revealing the process (or binary), followed by the defined key. In this case both the cat command and vim editor have opened the file
In this screenshot we can also see a failed syscall in the yellow box, with the value 89. To determine what syscall this is, we first have to look it up:
ausyscall &#8211;dump
This will show all available syscalls for our particular system architecture. So in this case a call to &#8220;getrusage&#8221;, to retrieve process statistics from the kernel.
Monitoring specific functions
We can use the Linux audit framework also for monitoring specific system calls, or functions. We have to use the -S followed by the system call.
auditctl -a always,exit -S openat -F success=1
The -a always,exit defines to write out an event at exit time of the related system call.
For example when you want to monitor all successful &#8220;openat&#8221; calls, add this system call and tell auditctl only to log successful requests. In this case you might get a message that the system call is unclear, as it is found on multiple architectures. Find the related system call ID with ausyscall openat and add the ID instead. Even better is specifying the architecture together with the system call, as it is easier to read (example: -F arch=b64 -S openat).
For more tips regarding the Linux audit framework, have a look at our other article Configuring &amp; Auditing Linux Systems with the Audit Daemon
File Integrity Monitoring
Another interesting level to monitor file changes, is by implementing file integrity tooling. Linux has several options for this, varying from simple tools up to kernel modules.
File Integrity Tools
The easiest way to verify if a file has been changed, is using tools. Simple tools like md5sum or shasum can help with detecting changes. Also specialized tools like AIDE and Samhain are a great help to set-up automatic monitoring and alerting.
Since setting up these tools are worth a blog post of their own, it will be covered in a separate post.
Integrity Measurement Architecture (IMA)
The most extensive option is monitoring files with IMA. This security module allows the system to create and monitor hashes for files and block unauthorized changes.
IMA has a few modes it can operate in, like fix and appraise. In &#8220;fix mode&#8221; the system allows the administrator to set hash values along each file. These hashes are small strings of text to help the system detect changes and are stored in extended attributes (xattrs) of the file system.
Digital signatures
Additionally IMA supports digital signing. This ensures you that the contents of the file is correct (or unaltered). Additionally because it is signed, you can validate the signature. So if a file is to be changed, it also needs proper signing.
Since IMA is a very extensive way of monitoring, we will cover more in other blogs posts. It&#8217;s a very exciting subject and a great help to protect your data.
Extended Verification Method (EVM)
Where IMA monitors the file contents, EVM performs monitoring of the file attributes. It also allows hashing and digital signing. It&#8217;s a great extension to IMA, to ensure that both contents and the attributes of a file are being unaltered.
Monitoring File Attributes
To monitor file permissions, we can also use the audit framework. File permissions and ownership are part of the file attributes. The file attributes can be monitored with &#8220;-p a&#8220;.
Additionally, we can use the earlier covered EVM to ensure attributes are not changed by an unauthorized process or person.
Conclusion
Now we have looked at some of the tools, it should be clear that a lot of areas can be monitored on Linux systems. It is up to the administrator to define what files should be monitored and to which extent. From simply logging changes to attributes with the Linux audit framework, up to fully blocking altered files with IMA and EVM.
The post Monitoring Linux File access, Changes and Data Modifications appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/monitoring-linux-file-access-changes-and-modifications/)

id:  191487
