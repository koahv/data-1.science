---
layout: post
title: "Use the command line to organise files"
date: 2014-08-19 14:00:38
categories: Linux
author: Rob Zwetsloot
tags: [tutorials, bash, cli, command ine]
---


#### Extract
>Follow @LinuxUserMag
So computing is clouding over, but you have half a lifetime’s ‘stuff’ randomly saved across hard drives and thumb drives. Family photos; downloaded eBooks; text files helpfully named ’Notes’ and ’Misc’; PDFs of instruction manuals, brochures and cartoons; HOWTOs in HTML form; music and video files; lots of old source code; and even files you don’t even know how to open.
Spring has come and gone and still your disordered archive sits quietly but accusingly. It’s time to do something about it – but drag- and-drop sorting through everything will take ages. Instead, let’s brush up on some command line shortcuts and combine a tidying exercise with a learning opportunity.
Why do this from the command line? There are times when drag-and-drop is a convenient way to move files around but &#8211; for most operations involving several files in multiple directories &#8211; the command line can be a lot quicker. Not only that, but repetitive operations can be automated with scripts and scheduled jobs, as we’ll see later.
Read on and learn how to find files, automatically zip them up, collect them in backup partitions and send them securely to a remote server at scheduled intervals.
Step-by-step
Step 01 Big list
There are many ways to see how big a file is. Right-click>Properties in a GUI file manager or ls -l filename, but ls -lhS (h to give human readable units) gives you a good look at the whole directory, ordered by file size.

Step 02 Du it
But if you&#8217;re just looking for disk use – not every file attribute – the disk use program, du, will be your best friend. Best of all, it searches recursively within directories.
Step 03 Pipe up
One of the great powers of *nix shells is piping commands together with the | pipe. This takes the output of one program and feeds it as the input to the command after the |.
Step 04 Sort it out
For example, feeding output to sort – in particular sort -n -r, which puts a list in numerical order (-n), from largest to smallest. -h tells sort to take into account KiB, MiB, etc, rather than -n&#8217;s ignorance of units.

Step 05 In depth
du’s recursive nature, while handy for discovering what&#8217;s filling your subdirectories, is a pain when you&#8217;re looking for a less detailed overview. Setting depth to 1 is some help&#8230;

Step 06 In the loop
While this combination is in part a workaround for non-GNU versions of sorts, on some versions of *nix, it also has the bonus advantage of showing large individual files and introduces loops in the shell.

Step 07 Helpful find
A better look, if you&#8217;re concerned with files, not directories, may be achieved through properties of the helpful find command. Here we&#8217;re using -type f to limit the search to files, and -printf %k %p to show size (in KiB) and filename.

Step 08 Space hogs
Having identified the type of files that are taking up the most space, in order to hunt them across your disk drive you will need to use the case-insensitive -iname switch and apply find to the root directory.
Step 09 Take your time
Searching across the whole filesystem takes real time – eight minutes here – and throws up the odd /proc irrelevance, but it is thorough and may surprise you with disk hogs you’d forgotten about, like old mailboxes.

Step 10 Music and movement
We’re going to use find to locate all of the MP3 files on the system – or at least those within the home directory – and move them to another disk. But before we do this we need to know what not to move&#8230;

Step 11 Exclusions
You may have games, or perhaps system sounds, in MP3 format, so – having searched the find results to double-check on them all – tell find to ignore the directories where they can be found.

Step 12 Snapshot

					
						
							GA_googleFillSlot("LUD_MidPage_MPU1");
						
					You’re going to be moving, not copying – this is a space-saving exercise – so take a snapshot of where the files are before you make any changes. That way you’ll know where to put things back, if necessary!

Step 13 Executive step
Calling -exec allows a command – in this case /bin/mv, the move command – to execute on each of the outputs of find. This is the safest option, as it takes care of special characters, and works on most *nix variants.

Step 14 Xargs
xargs is faster – running over the entire output of find at once – but needs print0 (not on all *nix) to safely operate special characters. Note these last two commands are each on just one line, don&#8217;t hit Enter till the end.

Step 15 Scripted move
If the object of your spring clean is just to tidy similar files into one directory, the job is done – but not quite. The time to create backups is always right now, since you don&#8217;t know when your disk will fail, or if your laptop will be lost or stolen.
A short script will take those files you’ve collected together, zip them up into a tarball, compress it and put it on another mounted directory. You might rather move your backup to a remote file server, for example. We’ll examine the options over the next few steps.

Step 16 Arm box
Backups need somewhere convenient to go. If you don’t already have a media box or other file server, but want to set something up, we recommend using something that’s quiet, unobtrusive and has low-power consumption: an ARM device – whether an old NSLU-2, a firmware-modified router or the good old Pi – would all be good options here.
Step 17 More Pi please
The real decision is software. Keep it simple: Debian. Forget NFS, SAMBA, or other remote file system mounts&#8230;
Step 18 Secure backup server
&#8230; just install the OpenSSH daemon. Now you can use SCP – secure copy – to backup your files in your scripts. Here we’re using an old Ubuntu netbook to upcycle as a media and print server – and a programmable photo frame!

Step 19 Key or pwd?
Your SSH server has a public key, but adding one from your local machine (to match its private key) would enable you to automate logins without having to leave the SSH password in plain text in your scripts.
Step 20 Obscure your port
While we’ll leave SSH keys as an exercise for you (though we may return to it in a future issue), we do suggest opening /etc/ssh/sshd_ config on your backup server and changing the value of Port to a random high number.

Step 21 Secure copy
If you didn’t set up keys, then install Sshpass – it’s the best way to send a password to SCP in a script – and add the line above into your script. It’s all on one line.

Step 22 Keeping regular
Now you have a script, you can call it through cron to run regularly with crontab -e. For example, if you generate and/or download many PDFs in a working day, or have particular folders to save, put those in the script.

Step 23 Command line GUI
Before we go, having shown you the power of the command line, we&#8217;re not saying GUIs don’t have a place. Install MC and you&#8217;ll get all of the power of keyboard-driven commands in a two-pane terminal-based filemanager.

Step 24 More scripts
In a future issue we’ll go further with shell scripting: the chaining together of programs and built-in commands in short scripts to remove the repetition of running through the same operations time and again. Happy days!
Follow @LinuxUserMag

#### Factsheet
>factsheet unavailable

[Visit Link](http://www.linuxuser.co.uk/tutorials/use-the-command-line-to-organise-files)

id:   42506
