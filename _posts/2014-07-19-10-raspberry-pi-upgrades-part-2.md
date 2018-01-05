---
layout: post
title: "10 Raspberry Pi upgrades part 2"
date: 2014-07-19 17:06:40
categories: Linux
author: Rob Zwetsloot
tags: [features, raspberry pi, baraometric pressure, picoborg, pitft, stereo, weather]
---


#### Extract
>Follow @LinuxUserMag
Find out the first six essential Raspberry Pi upgrades in part one of our feature.
Pi-sized portable display with touchscreen
What is it?
The PiTFT is a 2.8-inch capacitive TFT LCD touchscreen that&#8217;s been specifically designed with the Raspberry Pi in mind by the project gurus over at Adafruit. It&#8217;s capable of slotting directly on top of the Raspberry Pi and is about as big as the Pi is itself.
The PiTFT touchscreen adds a ton of functinality to any Raspberry Pi
Why do it?
There are numerous reasons why you&#8217;d want to add such a screen to a Raspberry Pi but they all generally come down to the fact that the Pi is very small and very portable and most monitors are not. While you could VPN in via a phone if you&#8217;re on the go, the screen is connected directly to the Pi and doesn&#8217;t involve awkward wireless networking. Also as a touchscreen you don&#8217;t need to bring along other input devices, as it&#8217;s powered off the Raspberry Pi as well.
This opens it up to a world of possibilities. Portable computer, touchscreen control pad, video camera&#8230; anything that could benefit from your Raspberry Pi having a screen and human input while away from your main monitor.
How to use it?
All you need to get it to work is the PiTFT from our friends at Pimoroni. Soldering required. Turn the Raspberry Pi off and slot it into the GPIO. Make sure it&#8217;s still connected to a conventional screen and turn it back on again, staying in command line mode. Right now the PiTFT will not turn on as you need to configure the Raspberry Pi, and more specifically Raspbian, to support it.
Once you&#8217;re logged in you can start the process by downloading files with:
$ wget http://adafruit-download.s3.amazonaws. com/libraspberrypi-bin-adafruit.deb
$ wget http://adafruit-download.s3.amazonaws. com/libraspberrypi-dev-adafruit.deb
$ wget http://adafruit-download.s3.amazonaws. com/libraspberrypi-doc-adafruit.deb
$ wget http://adafruit-download.s3. amazonaws.com/libraspberrypi0-adafruit.deb
$ wget http://adafruit-download.s3.amazonaws. com/raspberrypi-bootloader-adafruit-112613.deb
Install them all with sudo dpkg -i -B *.deb and then give it a reboot. Once you&#8217;ve logged back in you can install the driver for the actual screen with:
$ sudo modprobe spi-bcm2708
$ sudo modprobe fbtft_device name=adafruitts rotate=90
$ export FRAMEBUFFER=/dev/fb1
$ startx
At this point you should be getting a picture on the screen, however once you reboot it won&#8217;t last. To exit it for now press CTRL+C. To make it work on boot we&#8217;ll first open /etc/modules and add:
spi-bcm2708
fbtft_device
Save that file and now open the Adafruit configuration file with:
$ sudo nano /etc/modprobe.d/adafruit.conf
&#8230; and add the following line:
options fbtft_device name=adafruitts rotate=90 frequency=32000000
That&#8217;s the screen rotated 90 degrees there, and now we need to do the same with the touch aspect to orient it properly. We need to create a directory and file to handle this:
$ sudo mkdir /etc/X11/xorg.conf.d
$ sudo nano /etc/X11/xorg.conf.d/99-calibration.conf
In this new file you&#8217;ll need to add:
Section "InputClass"
   Identifier "calibration"
   MatchProduct "stmpe-ts"
   Option "Calibration" "3800 200 200 3800"
   Option "SwapAxes" "1"
EndSection
It&#8217;s just about configured. Edit the &#8216;~/.profile&#8217; file by adding export FRAMEBUFFER=/dev/fb1 and save. Now after a reboot every time you use startx you&#8217;ll turn on the display; to have it turn on whenever the Pi is on install:
$ sudo apt-get install xserver-xorg- video-fbdev
After this, create the file /usr/share/X11/xorg. conf.d/99-fbdev.conf and add to it:
Section "Device"
   Identifier "myfb"
   Driver "fbdev"
   Option "fbdev" "/dev/fb1"
EndSection
Go to Raspbian configuration with raspi-config, enable the desktop and finally press Finish in order to perform a reboot. You should log in with the screen turned on.
The screen is a little small like this and it&#8217;s better for custom-designed interfaces, using Python or whatever you prefer. The touchscreen can also be calibrated with some extra software if it&#8217;s not precise enough for you as well.
Predict the weather
What you&#8217;ll need
Adafruit BMP180
Breadboard
Wires
What is it?
A barometric pressure sensor allows you detect changes in the air pressure. Coupled with a temperature sensor it can predict short-term changes in the weather.
The pressure sensor can aid you in forecasting the weather
Why do it?
Being able to predict the weather has the obvious benefits of knowing whether or not to bring an umbrella or sunglasses into work. However, you could also use it in home automation to open windows or close curtains when it&#8217;s hot or about to start raining.
Get up and running
Step 01 Enable i2c
In the terminal, open the modules file to activate the I2C pins by adding two lines. After the following, reboot:
$ sudo nano /etc/modules

i2c-bcm2708
i2c-dev

					
						
							GA_googleFillSlot("LUD_MidPage_MPU1");
						
					Step 02 Get the code
The software for the BMP is available from the Adafruit GitHub (github. com/adafruit). Download it and navigate to the relevant folder:
$ git clone https://github.com/adafruit/ Adafruit-Raspberry-Pi-Python-Code.git
$ cd Adafruit-Raspberry-Pi-Python-Code
$ cd Adafruit_BMP085
Step 03 Test your sensor
Now you&#8217;re almost ready to get some data by first installing a package and then testing. You can do this in the terminal with the following commands:
$ sudo apt-get install python-smbus
$ sudo python Adafruit_BMP085_example.py
Wiring up your pressure sensor is very simple
Control motors and steppers
What is it?
There’s a fundamental drive instilled in all tinkerers and it goes something very much like, ‘If you can, add motors to it’. The Raspberry Pi is no exception and in fact, adding motors to the Pi has become a cottage industry of its own, with everyone and their Kickstarter-funded dog looking for a piece of the action.
There are countless ways you can power motors with the Raspberry Pi, starting from a simple IC chip – the good old L293D – that can be breadboarded with relative ease. The easier option, though, is to purchase an add-on board with a suitable motor driver IC already installed. We’ve chosen to demonstrate the PicoBorg Reverse – a board so versatile they can be daisy-chained together to run a robot powerful enough to tow a caravan&#8230;
While tiny, the PicoBorg is still very powerful
Why use it?
Why add motor control to your Raspberry Pi? There’s a great range of project ideas, from a motorised dolly to move your camera during time-lapse photography shoots, to autonomous and remote-controlled robots able to scoot around the house. We picked PiBorg’s PicoBorg Reverse for a couple of reasons. It caters for the widest range of motor sizes, it doesn’t hog the entire GPIO header (a real bug-bear with many other solutions) and it offers its own expansion header so you can daisy-chain boards together and still access the all-important power and ground pins for further use. It’s far from being the cheapest motor driver on the market, but it’s certainly one of the most project-friendly and user-friendly.
How to use it
In terms of setting up, the guys at PiBorg have been incredibly thoughtful. The PicoBorg Reverse comes with two colour-coded three- pin cables to connect the board to your Raspberry Pi’s GPIO pins. It also comes with a mounting kit so you can easily connect the board to your Raspberry Pi without losing access to any of the connectors. With the board mounted and the two cables connected as per their instructions, the installation process turns to the software side of things. Check out the step-by-step software installation guide below for full details.
The Python library supplied with the PicoBorg Reverse is very full-featured and even allows for hardware immobilisation should there be any difficulties. The library itself also includes a Help() text function that breaks down and lists every function and its parameters in plain English.
PicoBorg Reverse software installation
If you thought the hardware was easy, the software is essentially automatic&#8230;
Step 01 Download the examples
Create a folder for the Python module and example scripts to go in. At the terminal type:
mkdir ~/picoborgrev
Navigate into the folder (cd ~/picoborgrev).
Step 02 Run the script
The PicoBorg Reverse uses I2C for communication, but instead of manually setting things up, all you need to do is unzip the download, change the permissions (with: chmod +x install.sh), then run the script simply by typing ‘./install.sh’ at the command prompt. It really is that straightforward.
Step 03 Check out the example programs
Assuming you’ve got your motors already connected, you’re ready to go. You’ll even find a new desktop shortcut on your Raspberry Pi with a small GUI program to help you get started. You can find all the example programs and Python library functions on the PiBorg website.
Add amplified stereo speakers
What is it?
The Adafruit Stereo Amplifier MAX98306 is a small board that connects to a Raspberry Pi on one end and stereo speakers on the other.
Turn your Raspberry Pi into a boom box with a little help from this amplifier
Why do it?
The Raspberry Pi has no on-board speakers and can only output via HDMI or the analogue audio jack. It&#8217;s not amplified well, so the output is rather quiet.
How to use it
Strip the wire on your headphone-style cable. Unravel one side of the cable and attach each part to either the positive (+) and negative (-) of the R or L side. Then, attach the other cable to the remaining side&#8217;s positive and negative . Wire up the speakers, attach VDD to power and GND to ground, choose a gain on the gain selector pins (start lower at first) and finally plug the jack into the Raspberry Pi.
Follow @LinuxUserMag

#### Factsheet
>factsheet unavailable

[Visit Link](http://www.linuxuser.co.uk/features/10-raspberry-pi-upgrades-part-2)

id:   24277
