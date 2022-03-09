## Scenario

A wicked user tries to steal secret files from the company's internal network. He first copies the secret files with `cp`, as well as some other files, to his shared folder. Finally, those files are exfiltrated to the internet by `Lighttpd`.

### Similar scenario

[ProTracer: Towards Practical Provenance Tracing by Alternating Between Logging and Tainting](https://friends.cs.purdue.edu/pubs/NDSS16.pdf)

An employee copies some files to a public page by vim, and causes the information leakage.

## Implementation

### sources
Ubuntu 16.04: http://mirror.nus.edu.sg/ubuntu-ISO/16.04/
coreutils: https://github.com/Icegrave0391/attack-scenarios/releases/tag/coreutils
Lighttpd: https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.53.tar.gz

wget https://www.nano-editor.org/dist/v2.5/nano-2.5.0.tar.gz
./configure --prefix=/home/chuqi/local/nano --disable-mouse
export MYNANO=/home/chuqi/local/nano/bin/nano

### Deploy

**Lighttpd server (insider threat user's IP)**

* build and install

```
# coreutils (download from github release and unzip)
cd coreutils
./bootstrap
CC="gcc -g" CFLAGS="-Wno-error" ./configure --prefix=/home/chuqi/local/coreutils
make && make install

# Lighttpd 
wget https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.53.tar.gz --no-check-certificate
cd lighttpd-1.4.53
./configure --prefix=/home/chuqi/local/lighttpd  --without-bzip2
make && make install
```

* configure file

Download the `lighttpd.conf` file in this `/insider-threat/etc` github dir.
```
mkdir /home/chuqi/local/lighttpd/etc && cd /home/chuqi/local/lighttpd/etc
mv lighttpd.conf /home/chuqi/local/lighttpd/etc/lighttpd.conf
```

* web sources

Modify the `var.server_root` field in the configure file.

* deploy
```
/home/chuqi/local/lighttpd/sbin/lighttpd -f /home/chuqi/local/lighttpd/etc/lighttpd.conf
```


**Operations (Victim IP1)**

0. Start Lighttpd server

Use the command shown in section deploy.

1. Copy sensitive files to the shared lighttpd folder

```
/home/chuqi/local/coreutils/bin/cp src dst
```

**Exploit (External IP2)**    

Access victim's web-server on attacker's browser:
```
IP1:8580/xxx
```
