---
layout: post
title: "Understanding Shared Libraries in Linux"
date: 2018-02-20
categories: Linux
author: Tecmint
tags: [C standard library, Library (computing), C (programming language), Digital technology, Computing, Computer programming, Software, Areas of computer science, Software engineering, Computers, Computer engineering, Software development, Information technology management]
---


#### Digest
>In programming, a library is an assortment of pre-compiled pieces of code that can be reused in a program. Libraries simplify life for programmers, in that they provide reusable functions, routines, classes, data structures and so on (written by a another programmer), which they can use in their programs. For instance, if you are building an application that needs to perform math operations, you don’t have to create a new math function for that, you can simply use existing functions in libraries for that programming language. Examples of libraries in Linux include libc (the standard C library) or glibc (GNU version of the standard C library), libcurl (multiprotocol file transfer library), libcrypt (library used for encryption, hashing, and encoding in C) and many more.

#### Extract
>In programming, a library is an assortment of pre-compiled pieces of code that can be reused in a program. Libraries simplify life for programmers, in that they provide reusable functions, routines, classes, data structures and so on (written by a another programmer), which they can use in their programs. For instance, if you are building an application that needs to perform math operations, you don’t have to create a new math function for that, you can simply use existing functions in libraries for that programming language....

#### Factsheet
>In programming, a library is an assortment of pre-compiled pieces of code that can be reused in a program. Libraries simplify life for programmers, in that they provide reusable functions, routines, classes, data structures and so on (written by a another programmer), which they can use in their programs. Linux supports two classes of libraries, namely: Static libraries – are bound to a program statically at compile time; Dynamic or shared libraries – are loaded when a program is launched and loaded into memory and binding occurs at run time. Dynamic or shared libraries can further be categorized into: Dynamically linked libraries – here a program is linked with the shared library and the kernel loads the library (in case it’s not in memory) upon execution; Dynamically loaded libraries – the program takes full control by calling functions with the library. Shared libraries are named in two ways: the library name (a.k.a soname) and a “filename” (absolute path to file which stores library code). For example, the soname for libc is libc.so.6: where lib is the prefix, c is a descriptive name, so means shared object, and 6 is the version. And its filename is: /lib64/libc.so.6. Note that the soname is actually a symbolic link to the filename.

[Visit Link](https://www.linux.com/news/understanding-shared-libraries-linux)


