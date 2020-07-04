# YLIGHT SUITE

A. YLIGHT utility to control Yeelight® bulbs  
B. YSUNLIGHT set color temperature to time of the day

## A. YLIGHT version 0.5 (2020-06)

YLIGHT - utility to control Yeelight® bulbs

*dependencies: netcat, jq*

### 1. Installation

Clone this repository:  
`git clone https://github.com/teegre/ylight.git`

then:  
`./install.sh`

### 2. Usage

LAN Control has to be enabled via Yeelight® mobile application:  
[https://www.yeelight.com/faqs/lan_control](https://www.yeelight.com/faqs/lan_control)

When done, bulbs on your local network have to be discovered. Enter:  
```
$ ylight --discover
ylight: OK
```

*If you get an error message, wait a few seconds and launch this command again.*

Show bulb status:  

```
$ ylight --status
name:       bulb
host:       xxx.xxx.x.xxx
port:       xxxxx
power:      off
brightness: 100%
color temp: 6500K
effect:     smooth
transition: 500 ms
```

In case you own more than one bulb:  
```
$ ylight --list
bulb1:xxx.xxx.x.xxx:xxxxx
bulb2:xxx.xxx.x.xxx:xxxxx
```

The first of the list will be used as default.
So, if you you want to turn *bulb2* on:  
```
$ ylight --name bulb2 --on
```

To set *bulb2* as default:  
```
$ ylight --set-default bulb2
default bulb set to: 'bulb2'
```

### 3. Options

OPTIONS:

|Option                       |Description                                                  |
|:----------------------------|:------------------------------------------------------------|
| --discover                  | retrieve and save bulbs IP and port on local network        |
| --set-name NAME             | set device name                                             |
| --set-default DEVICE_NAME   | set DEVICE_NAME as default device                           |
| -a, --name DEVICE_NAME      | send command to DEVICE_NAME                                 |
| -l, --list                  | print saved bulbs                                           |
| -s, --status                | display bulb status                                         |
| -n, --on                    | turn light **on**                                           |
| -f, --off                   | turn light **off**                                          |
| -t, --toggle                | **toggle** power                                            |
| -b, --brightness [+/-]VALUE | set **brightness** (1..100)                                 |
| -c, --color-temp [+/-]VALUE | set **color temperature** (1700..6500)                      |
| -T, --timer [DURATION]      | enable **timer** for a given duration                       |
|                             | (from 1 to 120 minutes). 0 to turn off current timer;       |
|	                          | if no argument is present, each call to the function        |
|	                          | set the timer with a preset duration                        |
|	                          | (30, 60, 90, 120 minutes or off, respectively)              |
| -S, --smooth [DURATION_MS]  | smooth transition time when changing settings (100..10000)  |
| -u, --sudden                | changes are applied immediately (ignore -S)                 |
| -N, --notify                | display a notification                                      |
| -h, --help                  | print this help and exit                                    |
| -V, --version               | print program version and exit                              |

### 4. Some examples

Turn light on, set brightness to 50% and color temperature to 4500K:  
`ylight -n -b 50 -c 4500`

Decrease brightness by 10% and turn light off:  
`ylight -b -10 -f`

## B. YSUNLIGHT version 0.5 (2020-07)

YSUNLIGHT - set color temperature according to time of the day.

Once per day, **ysunlight** connects to this website [https://sunrise-sunset.org](https://sunrise-sunset.org)  
to retrieve sunrise and sunset times in your city, then it sets the right color temperature.
If the light is currently turned off, color temperature will be set once you turn the light on.

*Dependencies: curl, jq, ylight*

### 1. Configuration

To be able to work, **ysunlight** needs to know:

 * Timezone
 * Latitude
 * Longitude

#### 1.1 Timezone

Type this command:  

```
$ timedatectl
               Local time: ven. 2020-07-03 11:34:50 CEST
           Universal time: ven. 2020-07-03 09:34:50 UTC
                 RTC time: ven. 2020-07-03 09:34:50
                Time zone: Europe/Paris (CEST, +0200)
System clock synchronized: yes
              NTP service: active
          RTC in local TZ: no

```
What we need is **Europe/Paris**

#### 1.2 Latitude and longitude

Follow the link: [https://latitude.to](https://latitude.to)  
and enter your *city name*, for instance, Paris

#### 1.3 Configuration file

Edit the file: `$HOME/.config/ylight/ysunlight.conf`  
and enter the previous info, ie.:  
```
timezone=Europe/Paris
latitude=48.85
longitude=2.35
```

Other settings can also be found:  
```
sunrise_duration=600
sunset_duration=600
sunrise_step_duration=60
sunset_step_duration=60
```

*All durations are in seconds.*

### 2. Enable and start ysunlight.service

```
$ systemctl --user enable ysunlight
```

```
$ systemctl --user start ysunlight
```

If everything went fine, you should see a notification  
indicating time of the day.

If something went wrong, check the log file at: `$HOME/.config/ylight/ysunlight.log`  
and also: `systemctl --user status ysunlight`

## C. TODO

YLIGHT: ability to send commands more than one bulb at once

