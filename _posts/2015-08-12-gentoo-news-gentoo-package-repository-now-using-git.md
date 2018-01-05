---
layout: post
title: "Gentoo News: Gentoo Package Repository now using Git"
date: 2015-08-12 00:00:00
categories: Linux
author: Gentoo News ()
tags: []
---


#### Extract
>Good things come to those who wait: The main Gentoo package repository (also known as the Portage tree or by its historic name gentoo-x86) is now based on Git.



Timeline

The Gentoo Git migration has arrived and is expected to be completed soon.
As previously announced,
the CVS freeze occurred on 8 August and Git commits for developers were opened soon after.
As a last step, rsync mirrors are expected to have the updated changelogs again on or after 12 August.
Read-only access to gentoo-x86 (and write to the other CVS repositories) was restored on 9 August following the freeze.

History

Work on migrating the repository from CVS to Git began in 2006 with a proof-of-concept migration project during the Summer of Code.
Back then, migrating the repository took a week and using Git was considerably slower than using CVS.
While plans to move were shelved for a while, things improved over the coming years.
Several features were implemented in Git, Portage, and other tools to meet the requirements of a migrated repository.

What changes?

The repository can be checked out from git.gentoo.org and is available via our Git web interface.

For users of our package repository, nothing changes:
Updates continue to be available via the established mechanisms (rsync, webrsync, snapshots).
Options to fetch the package tree via Git are to be announced later.

The migration facilitates the process of new contributors getting involved as proxy maintainers and eventually Developers.
Alternate places for users to submit pull requests, such as GitHub, can be expected in the future.

In regards to package signing, the migration will streamline how GPG keys are used.
This will allow end-to-end signature tracking from the developer to the final repository, as outlined in GLEP 57 et seq.

While the last issues are being worked on, join us in thanking everyone involved in the project.
As always, you can discuss this on our Forums or hit up @Gentoo.

#### Factsheet
>factsheet unavailable

[Visit Link](https://www.gentoo.org/news/2015/08/12/git-migration.html)

id:  185203
