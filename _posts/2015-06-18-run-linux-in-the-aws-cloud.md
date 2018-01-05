---
layout: post
title: "Run Linux in the AWS cloud"
date: 2015-06-18 16:44:44
categories: Linux
author: Rob Zwetsloot
tags: [tutorials, amazon, aws, cloud]
---


#### Extract
>Follow @LinuxUserMag
AWS, short for Amazon Web Services, is the equivalent of an online retailer for virtual infrastructure and cloud services, complete with an automated self-service checkout and rock-bottom prices. Amazon’s pay-as-you-go rendition of enterprise-class infrastructure services is welcomed by cost- conscious, performance-hungry users – from website owners who need to scale out on demand, to software developers and Linux administrators who only need a Linux box for a few hours. On AWS, there are no long-term commitments – you only pay for actual use.
With cost savings of as much as 72 per cent and more over a conventional data centre, it is no wonder that AWS quickly became the hot ticket in town. The research firm Gartner estimates the total global market share of AWS at a mind-bending 83 per cent. Arguably, the most important feature of Amazon’s cloud is not its sheer size but its affordability.
Amazon gives each new account owner a Free Usage Tier for a full year after they first register: https://aws.amazon.com/free.
So, thanks to its low prices, no up-front investment, its granular administrative controls and the freedom to run your own infrastructure in your own way, AWS has turned into an open source stronghold where Linux reigns supreme.
￼If you want to run your own Linux box in the cloud, look no further than EC2
Resources
Web browser
Phone number
Email address
Credit card number
SSH client (optional)
Step-by-step
Step 01 Create a new AWS root account
To get started with AWS, navigate to it in a web browser and click on ‘Create a Free Account’. At this point you could sign in with your existing Amazon credentials but this isn’t always a good idea. Should you ever need to terminate your AWS account, you would also lose access to your account with Amazon, the online retailer. For this reason, most users prefer to register with another email address just to be safe, in case anything happens in the future.
Step 02 Complete the registration process
During registration, AWS will ask you to provide your contact details including an email address, your phone number and a credit card number. Amazon will then verify that you are human via an automated phone call. Your credit card number serves to confirm your identity as the payer and Amazon will keep it on file. As long as you only use services that are within your Free Tier capacity allotment, your card will not be charged at any point.
The registration process creates an AWS root account, which grants you access to all AWS infrastructure services. It has nothing to do with a root account on a Linux system, even though the underlying concept is very similar.
Never use your AWS root credentials for administrative work on your account except during your initial sign-in in the next step.
Step 03 Sign in to your AWS root account
The browser-based administrative interface on Amazon – the AWS Management Console – is the main switchboard for your AWS infrastructure and services. You can access it at the AWS site from the pull-down menu called My Account or directly as well. In either case, use the credentials of your AWS root account (your email address and your AWS root password). Make sure you never do this on a public network or public computer because if your credentials were intercepted, you could lose access to your entire infrastructure while still footing the bill. For this reason, Amazon recommends that after the initial sign-in, you immediately create a less privileged IAM user for your daily interactions with AWS and link it to an MFA device for multifactor authentication
(which is a topic for another tutorial altogether).
Step 04 Navigate the AWS Management Console
Quite predictably, the Console is peppered with AWS lingo so pervasive that even the toughest occasionally shake their heads in disbelief. To fire up a Linux box in the AWS cloud, you want to navigate to EC2 (Elastic Compute Cloud). For DNS services and domain name registration, head towards Route 53. If all you need is some storage that should remain easily accessible, you don’t actually need a Linux box – instead, go straight to the S3 (Simple Storage Service) section of the Console. The simplest way to get to your destination is by using the AWS logo in the upper left-hand corner of the Console, as this gives you access to the list of available services.
Step 05 Choose your AWS region
Some AWS services, particularly EC2, require you to select an AWS region. A region is a set of interconnected data centres, called AWS zones, with a common tax jurisdiction and identical pricing. You can utilise services in any of the nine AWS regions, not just your default one, and combine them to suit you. Typically, you would pick the most cost-effective one or combine several regions that are closest to the location of your end users to minimise latency. It’s important to remember that your EC2 dashboard shows infrastructure that you are paying for only in the region currently selected. This is a common trick of AWS: watching resource consumption in the dashboard of a wrong region, so beware.
Step 06 Launch a new EC2 instance
Navigate to the EC2 section of the AWS Management Console. This part of the interface grants you access to a variety of infrastructure services which enable you to build and run your own Linux box in the AWS cloud, a so-called EC2 instance of Linux.
Each EC2 instance represents a host that runs in a virtualised environment in isolation from other virtual machines, which makes it very cost-effective and reasonably safe. In order to start your own Linux server in the cloud, click on Launch Instance in the EC2 Dashboard. You can also click on the link Instance in the left- hand navigation pane of the AWS Management Console and then on the button Launch Instance.
Step 07 Select a Linux-based AMI
The storage configuration of an instance is described using a machine definition called an AMI (Amazon Machine Image). An AMI specifies, among other things, the contents of the boot volume. Select an AMI based on a Linux distribution of your choice from the list in section Quick Start (not a database instance, an Amazon RDS instance doesn’t grant you superuser access at the OS level). Instances labelled ‘Free tier eligible’ do not incur any costs so long as you remain within the time allotment of up to 720 hours per month throughout the first 12 months after your account is first registered.
Step 08 Choose an instance type
The instance type defines the performance characteristics of your Linux box in terms of its clock speed, available RAM, internal storage and network capabilities. The only instance type that qualifies for the free usage tier is t2.micro.
Make your choice and then click ‘Next: Configure Instance Details’.
Step 09 Configure instance details
On the next screen, you can select how many instances to start, whether you want them to be persistent (leave the Purchasing option check box deactivated), if they should have their own privileges to access your AWS services (IAM role>None), and configure networking. It is best to launch an EC2 instance n a virtual private cloud (VPC), which is a fancy way of saying that Amazon will isolate it from other users’ instances by means of smart routing. Older AWS accounts may also offer an option labelled ‘EC2-Classic’, which does not have this protection, so if you see it, don’t use it.
In the menu ‘Auto-assign Public IP’, select ‘Use subnet setting (Disable)’. Set the IAM role to None and shutdown behaviour to Stop.
If you enable ‘Termination protection’, AWS won’t let you destroy the instance using the Terminate command in the Console until you remove this protection.
Leave the other options unchanged and click on ‘Next: Add Storage’.
Step 10 Attach storage
If you need additional volumes, you can create and attach them now. Free Tier covers up to 30GB of General Purpose (SSD) storage giving you a maximum baseline performance of slightly under 100 IOPS (see ‘EBS Volumes’ boxout for more information).
Now click on ‘Next: Tag Instance’.
Step 11 Tag your Linux Instance
Tags on AWS are key value pairs that store information that can help you to organise your AWS resources. Using tags is purely optional. Don’t sweat it – you can always edit tags later if you need to. If nothing comes to mind, click on Next>Configure Security Groups.
Step 12 Configure security groups
Think of Security Groups as settings for an AWS firewall that specify ‘Enable rules for inbound and outbound traffic’. For each Linux instance, you need to enable ingress access (inbound traffic) on TCP port 22 for SSH from at least one IP address (yours). Unless you are on a static IP (or an IP range), you may have to enable access from anywhere. If you need other services, add the corresponding rules (eg open port 80 for HTTP and 443 for HTTPS if you want to run a web server). Then click on ‘Review and Launch’.
Step ￼￼13 Create or select a key pair
Verify your settings and hit Launch. The wizard will ask you to create or select a key.
Passwords are out, key pairs are in. A private key is what authenticates you as the administrator of your Linux instance. SSH will attempt to verify the authenticity of your private key, based on a copy of a corresponding public key that AWS is about to save in the appropriate location of the Linux system on your instance.
You could generate your key pair yourself and upload the public key to the EC2 console, or you can ask Amazon to create a key pair for you, which is faster. Select ‘Create a new key pair’, give it a name, download the private key to your computer and correct access privileges on it:
chmod 400 /path/to/yourPrivateKey.pem
Once this is done, you can launch your instance. It will show up in the section Instances of the AWS Management Console for EC2.
Step 14 Assign an EIP to your EC2 instance
Unless you chose to auto-assign a public IP to your instance, it does not have a Public DNS entry yet and is inaccessible from the outside. Click on the link Elastic IPs in the left-hand navigation pane of the EC2 console. Here you need to obtain a new elastic IP address for your AWS account (Allocate New Address) and associate it with your instance (Associate Address).
Step 15 Connect to your Linux instance
Wait until your instance passes both health checks and reports its state as ‘running’. Now you should be able to connect to it using any stand-alone SSH client or the Java-based client that Amazon provides. Navigate to the Instances section of the Console, select your instance from the list and click on the Connect button to view instructions. Start an SSH client and enter something like this:
ssh -i /path/to/yourPrivateKey.pem username@XX.XX.XXX.XX
The username is usually either ec2user or root, but technically the creator of the AMI can set it to whatever they want. If your initial username is anything other than root, you can assume superuser privileges using the command:
sudo su
If you attached any additional volumes to your instance (besides the volumes that came with the AMI), now is the time to format them, mount them and add them to /etc/fstab.
Follow @LinuxUserMag

#### Factsheet
>factsheet unavailable

[Visit Link](http://www.linuxuser.co.uk/tutorials/run-linux-in-the-aws-cloud)

id:  141905
