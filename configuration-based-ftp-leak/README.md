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
/home/chuqi/local/curl/bin/curl -o mal-proftpd.conf -L https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/configuration-based-ftp-leak/mal-proftpd.conf -o conf1.conf -L https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/configuration-based-ftp-leak/conf1.conf -o conf2.conf -L https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/configuration-based-ftp-leak/conf2.conf
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

