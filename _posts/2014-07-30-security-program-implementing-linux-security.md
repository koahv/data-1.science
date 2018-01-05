---
layout: post
title: "Security Program: Implementing Linux Security"
date: 2014-07-30 14:03:09
categories: Linux
author: Michael Boelen
tags: [implementation, linux, project, security program]
---


#### Extract
>Security Program: Implementing Linux Security
With a proper security program, the security of Linux based systems can be greatly improved. In this article we have a look at how to prepare change properly. This way we can increase the chance to succeed with the security program.
Change Management
Almost everything is changing continuously, which is especially true in IT environments. Companies using ITIL have a process in place, named Change Management. Even if there is no formal process, changes in organizations should be properly prepared. Sure, things can change by just doing so, but usually the end goal may not be achieved. By focusing on the key elements of changing to achieve our preferred new situation, we increase the succeed ratio tremendously.
There are 4 key elements to achieve a change.

Need for change
Vision
Resources for improvement
Plan and first steps

1. Need for change
While it might be obvious for some people that something have to be changed, it is often unclear why the change has to occur. Other people might have to be sold on the idea of the change. Only when having all key people on-board, chances to succeed are much higher.
Additionally the need for change consists of some pressure. For example regarding time. There should be some sense of urgency, or else people won&#8217;t start moving.
Reasons for implementing security activities like system hardening or regular security audits, might be for compliance.
Define the need to change with lessons from the past, like:

Any intrusion / break-in
Lack of trust by customers
Requests from customers for compliance

2. Vision
Before trying to change something, get a clear image on what the outcome should be. Vision is needed to get closer to this outcome. Usually it consists of a set of insights, knowledge and decision making. Know your market, environment, company and people.
Also in information security we should have a clear vision in why we are here and what we try to achieve. When implementing Linux security in your environment, especially if it currently is based on ad hoc activities, take a few steps back first. Define the outcome, the possible constraints and the key people involved. Write down who is opposite of such change and who might be more than an enabler of the security program.
For the Linux security program, make sure to know at least these areas:

Used Linux/Unix versions (e.g. Red Hat, Solaris, mixed)
Available budget
Available resources
Deadlines

3. Resources
Nothing can be changed without resources. This includes the appropriate tooling for example. Sometimes existing tools might be used, or build upon tool kits and processes.
Besides tooling there is people and their knowledge. Does the company have enough in-house knowledge, or should an external consultant assist? Even if you have the knowledge, are these people available for side projects?
Then there is time, deadlines and the related pressure. Make sure there is enough time, or at least enough people to help completing tasks. Time killers include company politics, badly prepared meetings and distractions. Especially people working on projects to enable the change to happen, should not be distracted with (too much) operational tasks.
Required information:

Which people are active in project
Who has a need to know
Are there are any deadlines
Compliance applicable (SOx, PCI etc)

4. Plan
While actual change is especially visible in the execution, it is the planning upfront which makes the transition much smoother. Know possible threats, include what people need extra convincing, or what communication needs to happen.
Try to have a detailed plan upfront, so it is clear what needs to be done at what stage. Including communication, meetings and approvals (e.g. a moment for a go / no-go).
Tools to use:

Templates
Progress sheets
Change Management (ITIL)
Spreadsheet and databases (e.g. CMDB)

The outcome of using the right tools and the invested preparation, should be a clear plan with all activities includes. When it is time to start working on the first activities, the plan should be guidance for involved people.
Dealing with exceptions
Most projects will have sooner or later an exceptional event. Simple events like missing a deadline, due to a third party not fulfilling its promises for delivery. Other exceptions may include technical difficulties during implementation. With a clear plan, the amount of bad surprises should be limited. However if people know how they can report any inconsistencies, project risks can be decreased. Anything reported exceptions can be handled on a case-by-case basis. Determine upfront who has authority to collect exceptions and who is authorized take action or make a decision.
Program or Projects?
Implementing security on Linux based systems can be a very time consuming project. Therefore it might be better to embed it into a program, with many smaller projects.
Each project will then have a clear scope, time constraints and dedicated resources assigned. The big benefit is that change is directly visible, as now projects might just take a few hours (instead of days or weeks).
Core (Linux kernel)
With Linux being the core of the operating itself, it makes it the right location to start with. Determine what Linux kernel versions are being used within your environment. Determine what actions already have been taken to secure the kernel and the related components. This might include the way data is stored on the system (what file system is used?). What options are used to fortify the core of the operating system.
Determine the version of the used Linux kernels might give a great insight in software patch management. If old kernels are being used, chances are high that the system is vulnerable to attacks via the network, or locally. Usually exploiting tools being quickly available to abuse these weaknesses. This makes it important to start protecting the system from the inside out and patch management is one first step.
Software
There are two fundamental things when securing a system when it comes to software:

Use of what software components
Software and security patch management

While this document is not meant as a system hardening guide, the first piece is important to keep systems clean. Do not install tools which are not needed. Besides the additional space, it might give access to data in unexpected ways. In the worst case you might be even running an unused but vulnerable application!
Regarding software patch management you should define a clear plan on how to embed proper software and security patching. How are you going to deal with software updates and how with security updates in particular. Do they follow the same schedule, or are security patches given priority to limit the exposure of weaknesses? Depending on your organization and security policy, this might totally depend.
Networking
From a networking level things have become more interesting over the last years. Every system nowadays is interconnected, up to our mobile phones. Protecting the network stack is therefore an important part in securing systems.
One of the things for a security program could be the implementation of a firewall. Even if you already have a network firewall, the presence of a local firewall might have benefits. This is especially the case when having systems of multiple customers in the same VLANs, or accessible via the internet.
Users
Last, but definitely not least, is dealing with users. Not the people itself, but dealing with the AAA part of it:
1. Authentication
How are users connecting to the system and what kind of authentication controls might they use (password, smart card, token). Closely related are the implementation of password controls, defining the security and strength of these controls.
2. Authorization
After a user is successfully authenticated, we should know what each user is supposed to do on a system. This involves in determining what a user could access, in what groups it should be in and the related file system permissions. One of a common type of authorization control is the usage of sudo. If a &#8220;normal&#8221; user needs temporary privileged permissions, you do not want to hand them the root password. Properly implementing sudo gives users the possibility to do their work, while keeping the root password secret.
3. Accounting
For controlling our security, we should know upfront what a user is supposed to do. However, you might want to monitor behavior on the system for security reasons as well. Other reasons might be troubleshooting or debugging. In any case, tracking access and executed commands might be useful.
Safeguarding of Changes
Changing an environment, including Linux systems might be easy. However we should keep in mind the goal of the program and the related projects. Each change should be properly documented, approved and executed.
After each change has been done, documentation should be updated, so operational staff is aware of the change and use the right work instructions. Additionally, the system and change should be protected against other changes (e.g. undoing previous work). By properly monitoring the recently made change, we can control the improvements and make sure they stay in place.
&nbsp;
With all tips in this document given, good luck with your security program! If you need additional guidance or tips for your program, contact us via the About page.
&nbsp;
The post Security Program: Implementing Linux Security appeared first on Linux Audit.

#### Factsheet
>factsheet unavailable

[Visit Link](http://linux-audit.com/security-program-implementing-linux-security/)

id:  191534
