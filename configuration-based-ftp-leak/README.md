## Scenario

The victim FTP server administrator seeks for existing template configurations of the FTP server, and downloads several different template files via `curl`. Unfortunately, one of those configuration files is defective which mis-configured the root directory for the server, and allows users to access sensitive files.

One of the users accidentally finds he has permission to access sensitive data, and then transfers those files via FTP.

### Similar scenario

[OmegaLog: High-Fidelity Attack Investigation via Transparent Multi-layer Log Analysis](https://www.ndss-symposium.org/wp-content/uploads/2020/02/24270-paper.pdf)

[MPI: Multiple Perspective Attack Investigation with Semantics Aware Execution Partitioning](https://www.usenix.org/system/files/conference/usenixsecurity17/sec17-ma.pdf)

## Implementation

### sources

Ubuntu 16.04: http://mirror.nus.edu.sg/ubuntu-ISO/16.04/    
curl 7.44.0: https://github.com/curl/curl/releases/download/curl-7_44_0/curl-7.44.0.tar.gz    
proftpd 1.3.6: https://github.com/proftpd/proftpd/archive/refs/tags/v1.3.6b.tar.gz

### Deploy

**curl tool (Victim IP1)**
```
cd curl-7.44.0
./configure --prefix=/home/chuqi/local/curl \
--disable-ftp \
--disable-pop3 \
--disable-smtp \
--disable-imap \
--disable-gopher \
--disable-imap \
--disable-ldap \
--disable-ldaps \
--disable-proxy \
--disable-rtsp \
--disable-telnet \
--disable-tftp \
--disable-dict \
--without-libcurl \
--disable-shared \
--disable-libcurl-option
```

**FTP server (Victim IP1)**

* build and install
```
tar xzvf v1.3.6b.tar.gz && cd proftpd-1.3.6
./configure --prefix=/home/chuqi/local/proftpd
make && make install
```

* configure file

The default configuration file is at `/home/chuqi/local/proftpd/etc/proftpd.conf`. Nonetheless, we will not touch this file since this scenario is under a defective configuration file.

* ftp directories

Download the folder `ftp-source-root` under this github directory.
```
cp ftp-source-root /home/chuqi
```

* deploy
```
sudo /home/chuqi/local/proftpd/sbin/proftpd -c /path/to/configure/file
```

### Operations (Victim IP1)

1. Download different configuration files (including the defective configuration file) via curl

```
# /home/chuqi/local/curl/bin/curl -o mal-proftpd.conf -L https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/#configuration-based-ftp-leak/mal-proftpd.conf -o conf1.conf -L https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/configuration-based-ftp-leak/conf1.conf -o conf2.conf -L https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/configuration-based-ftp-leak/conf2.conf

/home/chuqi/local/curl/bin/curl -o conf1.conf 172.26.187.140:8080/data/conf1.conf \
                                -o conf2.conf 172.26.187.140:8080/data/conf2.conf \
                                -o conf3.conf 172.26.187.140:8080/data/conf3.conf \
                                -o conf4.conf 172.26.187.140:8080/data/conf4.conf \
                                -o conf5.conf 172.26.187.140:8080/data/conf5.conf \
                                -o conf6.conf 172.26.187.140:8080/data/conf6.conf \
                                -o conf7.conf 172.26.187.140:8080/data/conf7.conf \
                                -o conf8.conf 172.26.187.140:8080/data/conf8.conf \
                                -o conf9.conf 172.26.187.140:8080/data/conf9.conf \
                                -o conf10.conf 172.26.187.140:8080/data/conf10.conf \
                                -o conf11.conf 172.26.187.140:8080/data/conf11.conf \
                                -o conf12.conf 172.26.187.140:8080/data/conf12.conf \
                                -o conf13.conf 172.26.187.140:8080/data/conf13.conf \
                                -o conf14.conf 172.26.187.140:8080/data/conf14.conf \
                                -o conf15.conf 172.26.187.140:8080/data/conf15.conf \
                                -o conf16.conf 172.26.187.140:8080/data/conf16.conf \
                                -o conf17.conf 172.26.187.140:8080/data/conf17.conf \
                                -o conf18.conf 172.26.187.140:8080/data/conf18.conf \
                                -o conf19.conf 172.26.187.140:8080/data/conf19.conf \
                                -o conf20.conf 172.26.187.140:8080/data/conf20.conf \
                                -o conf21.conf 172.26.187.140:8080/data/conf21.conf \
                                -o conf22.conf 172.26.187.140:8080/data/conf22.conf \
                                -o conf23.conf 172.26.187.140:8080/data/conf23.conf \
                                -o conf24.conf 172.26.187.140:8080/data/conf24.conf \
                                -o conf25.conf 172.26.187.140:8080/data/conf25.conf \
                                -o conf26.conf 172.26.187.140:8080/data/conf26.conf \
                                -o conf27.conf 172.26.187.140:8080/data/conf27.conf \
                                -o conf28.conf 172.26.187.140:8080/data/conf28.conf \
                                -o conf29.conf 172.26.187.140:8080/data/conf29.conf \
                                -o conf30.conf 172.26.187.140:8080/data/conf30.conf \
                                -o conf31.conf 172.26.187.140:8080/data/conf31.conf \
                                -o conf32.conf 172.26.187.140:8080/data/conf32.conf \
                                -o conf33.conf 172.26.187.140:8080/data/conf33.conf \
                                -o conf34.conf 172.26.187.140:8080/data/conf34.conf \
                                -o conf35.conf 172.26.187.140:8080/data/conf35.conf \
                                -o conf36.conf 172.26.187.140:8080/data/conf36.conf \
                                -o conf37.conf 172.26.187.140:8080/data/conf37.conf \
                                -o conf38.conf 172.26.187.140:8080/data/conf38.conf \
                                -o conf39.conf 172.26.187.140:8080/data/conf39.conf \
                                -o conf40.conf 172.26.187.140:8080/data/conf40.conf \
                                -o conf41.conf 172.26.187.140:8080/data/conf41.conf \
                                -o conf42.conf 172.26.187.140:8080/data/conf42.conf \
                                -o conf43.conf 172.26.187.140:8080/data/conf43.conf \
                                -o conf44.conf 172.26.187.140:8080/data/conf44.conf \
                                -o conf45.conf 172.26.187.140:8080/data/conf45.conf \
                                -o conf46.conf 172.26.187.140:8080/data/conf46.conf \
                                -o conf47.conf 172.26.187.140:8080/data/conf47.conf \
                                -o conf48.conf 172.26.187.140:8080/data/conf48.conf \
                                -o conf49.conf 172.26.187.140:8080/data/conf49.conf \
                                -o conf50.conf 172.26.187.140:8080/data/conf50.conf \
                                -o conf51.conf 172.26.187.140:8080/data/conf51.conf \
                                -o conf52.conf 172.26.187.140:8080/data/conf52.conf \
                                -o conf53.conf 172.26.187.140:8080/data/conf53.conf \
                                -o conf54.conf 172.26.187.140:8080/data/conf54.conf \
                                -o conf55.conf 172.26.187.140:8080/data/conf55.conf \
                                -o conf56.conf 172.26.187.140:8080/data/conf56.conf \
                                -o conf57.conf 172.26.187.140:8080/data/conf57.conf \
                                -o conf58.conf 172.26.187.140:8080/data/conf58.conf \
                                -o conf59.conf 172.26.187.140:8080/data/conf59.conf \
                                -o conf60.conf 172.26.187.140:8080/data/conf60.conf \
                                -o conf61.conf 172.26.187.140:8080/data/conf61.conf \
                                -o conf62.conf 172.26.187.140:8080/data/conf62.conf \
                                -o conf63.conf 172.26.187.140:8080/data/conf63.conf \
                                -o conf64.conf 172.26.187.140:8080/data/conf64.conf \
                                -o conf65.conf 172.26.187.140:8080/data/conf65.conf \
                                -o conf66.conf 172.26.187.140:8080/data/conf66.conf \
                                -o conf67.conf 172.26.187.140:8080/data/conf67.conf \
                                -o conf68.conf 172.26.187.140:8080/data/conf68.conf \
                                -o conf69.conf 172.26.187.140:8080/data/conf69.conf \
                                -o conf70.conf 172.26.187.140:8080/data/conf70.conf \
                                -o conf71.conf 172.26.187.140:8080/data/conf71.conf \
                                -o conf72.conf 172.26.187.140:8080/data/conf72.conf \
                                -o conf73.conf 172.26.187.140:8080/data/conf73.conf \
                                -o conf74.conf 172.26.187.140:8080/data/conf74.conf \
                                -o conf75.conf 172.26.187.140:8080/data/conf75.conf \
                                -o conf76.conf 172.26.187.140:8080/data/conf76.conf \
                                -o conf77.conf 172.26.187.140:8080/data/conf77.conf \
                                -o conf78.conf 172.26.187.140:8080/data/conf78.conf \
                                -o conf79.conf 172.26.187.140:8080/data/conf79.conf \
                                -o conf80.conf 172.26.187.140:8080/data/conf80.conf \
                                -o conf81.conf 172.26.187.140:8080/data/conf81.conf \
                                -o conf82.conf 172.26.187.140:8080/data/conf82.conf \
                                -o conf83.conf 172.26.187.140:8080/data/conf83.conf \
                                -o conf84.conf 172.26.187.140:8080/data/conf84.conf \
                                -o conf85.conf 172.26.187.140:8080/data/conf85.conf \
                                -o conf86.conf 172.26.187.140:8080/data/conf86.conf \
                                -o conf87.conf 172.26.187.140:8080/data/conf87.conf \
                                -o conf88.conf 172.26.187.140:8080/data/conf88.conf \
                                -o conf89.conf 172.26.187.140:8080/data/conf89.conf \
                                -o conf90.conf 172.26.187.140:8080/data/conf90.conf \
                                -o conf91.conf 172.26.187.140:8080/data/conf91.conf \
                                -o conf92.conf 172.26.187.140:8080/data/conf92.conf \
                                -o conf93.conf 172.26.187.140:8080/data/conf93.conf \
                                -o conf94.conf 172.26.187.140:8080/data/conf94.conf \
                                -o conf95.conf 172.26.187.140:8080/data/conf95.conf \
                                -o conf96.conf 172.26.187.140:8080/data/conf96.conf \
                                -o conf97.conf 172.26.187.140:8080/data/conf97.conf \
                                -o conf98.conf 172.26.187.140:8080/data/conf98.conf \
                                -o conf99.conf 172.26.187.140:8080/data/conf99.conf \
                                -o conf100.conf 172.26.187.140:8080/data/conf100.conf \
                                -o mal-pureftpd.conf 172.26.187.140:8080/data/mal-pureftpd.conf
```

2. Deploy FTP server with the defective configuration file

```
sudo /home/chuqi/local/proftpd/sbin/proftpd -c mal-proftpd.conf
```

### Exploit (Attacker IP2)

Access victim's FTP server and transfer files:
```
IP1:9021/ftp-sensitive.txt
IP1:9021/ftp-source/ftp_file1.txt
...
```

