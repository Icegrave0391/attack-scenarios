# malicious-ftp-config

A DEMO for misconfiguration-based ftp data leak attack.

The malicious ftp configuration file allows users to access certain directory `/home/chuqi/web-sources`, which contains sensitive data.

## Download

Such malicious config file could be downloaded via the command `curl -o my-proftpd.conf -L https://raw.githubusercontent.com/Icegrave0391/malicious-ftp-config/main/proftpd.conf`
