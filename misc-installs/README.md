### OpenSSH

- download from the [stable releases](https://www.openssh.com/portable.html#downloads)
```
wget https://cdn.openbsd.org/pub/OpenBSD/OpenSSH/portable/openssh-8.9p1.tar.gz
tar xzvf openssh-8.9p1.tar.gz
cd openssh-8.9p1
```

- install
```
./configure --prefix=/home/chuqi/local/openssh --without-pie
sudo make && make install
```

### HAProxy

- download from the [stable release](https://www.haproxy.org/)

```
wget https://www.haproxy.org/download/1.8/src/haproxy-1.8.30.tar.gz
tar xzvf haproxy-1.8.30.tar.gz
cd haproxy-1.8.30
```

- install
```
1. edit the PREFIX in makefile (PREFIX=/home/chuqi/local/haproxy)
make TARGET=linux2628 USE_ZLIB=1 USE_PCRE=1 && make install
```

- usage
```
# download config file on server side
cd /home/chuqi/local/haproxy
mkdir etc && cd etc
curl -o haproxy.cfg https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/misc-installs/haproxy.cfg

# deploy load-balance server
/home/chuqi/local/haproxy/sbin/haproxy -D -f /home/chuqi/local/haproxy/etc/haproxy.cfg

# now could access haproxy with localhost:10080
# i.e. :
curl 127.0.0.1:10080/data/file2.txt (the url path should follow the deployed web server)
```

### yafc 

- download from the source code
```
wget https://ramacher.at/_downloads/97222375f77c1553929c9b01669025d1/yafc-1.3.7.tar.xz
tar xvf yafc-1.3.7.tar.xz 
cd yafc-1.3.7
```

- install
```
./configure --prefix=/home/chuqi/local/yafc
make && make install
```

- usage 
```
export myyafc = /home/chuqi/local/yafc/bin/yafc
$myyafc chuqi:chuqi@172.26.187.140:9121           # use pure-ftpd to start the server 
```

### memcached

- download from the [stable release](https://memcached.org/)
```
wget http://www.memcached.org/files/memcached-1.6.14.tar.gz
tar xzvf memcached-1.6.14.tar.gz
cd memcached-1.6.14
```

- install
```
./configure --prefix=/home/chuqi/local/memcached
make && make install
```

- usage
```
export mymemcached=/home/chuqi/local/memcached/bin/memcached
$mymemcached -p <port num> -d
```

### Squid

- download from the [stable release](http://www.squid-cache.org/Versions/)
```
wget http://www.squid-cache.org/Versions/v5/squid-5.4.1.tar.gz
tar xzvf squid-5.4.1.tar.gz
cd squid-5.4.1
```

- install
```
./configure --prefix=/home/chuqi/local/squid
make && make install
```

### Varnish

- download from the [stable release]()
```
wget https://varnish-cache.org/downloads/varnish-7.0.0.tgz
tar xzvf varnish-7.0.0.tgz
cd varnish-7.0.0
```

- install

There is an official document for [compiling varnish from source](https://varnish-cache.org/docs/trunk/installation/install_source.html).

```
sudo apt-get install python-docutils
```

- usage
```
# 1. create a cache file directory 
mkdir /home/chuqi/local/varnish/cachefiles

# 2. create a VCL configuration file 
mkdir /home/chuqi/local/varnish/etc 
cd /home/chuqi/local/varnish/etc
curl -o default.vcl https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/misc-installs/default.vcl

# 3. turn on http server, which listens on port 8580 (configured as backend section in default.vcl)

# 4. start varnish
cd /home/chuqi/local/varnish/sbin
sudo ./varnishd -a 172.26.187.140:11080 -f /home/chuqi/local/varnish/etc/default.vcl -s file,/home/chuqi/local/varnish/cachefiles/cache.file,100m  -n /home/chuqi/local/varnish/sbin/
```

### Postgresql

- download from the [stable release](https://www.postgresql.org/ftp/source/)
```
wget https://ftp.postgresql.org/pub/source/v14.0/postgresql-14.0.tar.gz
tar xzvf ...
```

- install

There is an official document of the [installation procedure](https://www.postgresql.org/docs/14/install-procedure.html).

```
./configure --prefix=/home/chuqi/local/postgresql
make && make install
```

- usage

Follow the [official documentation](https://www.postgresql.org/docs/14/index.html) when operating the database.

Note that `postgresql` has been installed at the root directory `/home/chuqi/local/postgresql`.

```
# set the locale settings 
export LC_ALL="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"

cd /home/chuqi/local/postgresql/bin

# initialize the data base file system
./initdb -D /home/chuqi/local/postgresql/data

# modify the configuration
cd /home/chuqi/local/postgresql/data && vim postgresql.conf # modify the listen port and address

# start service 
./postgres -D /home/chuqi/local/postgresql/data                   # foreground mode
./postgres -D /home/chuqi/local/postgresql/data > logfile 2>&1 &  # background mode

# create database named evaldb
./createdb evaldb
```

```
# client interaction
./psql -U <userName> <dbName>

# create user 
> CREATE ROLE username superuser; # create ROLE
> CREATE USER username;           # create USER
> GRANT ROOT TO username;         # assign privilege
> ALTER ROLE username WITH LOGIN; # enable login

# create table
CREATE TABLE userinfo (
    name    char(20),
    uid     int
);

# insert data
INSERT INTO userinfo VALUES ('user3', 003);

# query for data
SELECT * FROM userinfo WHERE uid=1;
```

### SQLite

- download from the [stable release](https://sqlite.org/download.html)
```
wget https://sqlite.org/2022/sqlite-autoconf-3380100.tar.gz
tar xzvf sqlite-autoconf-3380100.tar.gz
cd sqlite-autoconf-3380100
```

- install
```
./configure --prefix=/home/chuqi/local/sqlite
make && make install
```

- usage
```
SQLite is a lightweight serverless database front-end, which interacts and queries with local file data base.
SQLite3 is a terminal-based front-end to the SQLite library that can evaluate queries interactively and display the results in multiple formats. SQLite3 can also be used within shell scripts and other applications to provide batch processing  features.

# 1. initialize database 
cd /home/chuqi/local/sqlite/bin
$ ./sqlite3 eval.db
    SQLite version SQLite version 3.38.1 2022-03-12 13:37:29
    Enter ".help" for instructions
    sqlite> create table users(uname, uid INTEGER);
    sqlite> insert into users values('chuqi', 11);
    sqlite> insert into users values('jun', 111);
    sqlite> select * from users;
        chuqi|11
        jun|111
    sqlite> ctrl ^ C 

# 2. interact with db at line mode
$ ./sqlite3 -line eval.db "select * from users;"
```

### ntpd

- download from the [stable release](http://www.ntp.org/downloads.html)
```
wget http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/ntp-4.2/ntp-4.2.8p15.tar.gz
tar xzvf ntp-4.2.8p15.tar.gz
cd ntp-4.2.8p15
```

- install

There is an official document for [building and installing the distribution](https://www.eecis.udel.edu/~mills/ntp/html/build.html).

```
CFLAGS='-no-pie' CPPFLAGS='-no-pie' LDFLAGS='-no-pie' ./configure --prefix=/home/chuqi/local/ntp
vim makefile and comments all -pie / -fPIE
make && make install
```

- usage

1. server side 

deploy the ntpd server
```
# create configuration file at /home/chuqi/local/ntp/etc
mkdir /home/chuqi/local/ntp/etc
# download the ntp.conf from this github repo page to the file
cd /home/chuqi/local/ntp/etc
curl -o ntp.conf https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/misc-installs/ntp_server.conf

# start ntpd server
sudo /home/chuqi/local/ntp/bin/ntpd -c /home/chuqi/local/ntp/etc/ntp.conf
```

2. client side 

download ntp and ntpdate via apt
```
sudo apt install ntp ntpdate

# download the ntp_client.conf from this github repo page to the file 
sudo curl -o /etc/ntp.conf https://raw.githubusercontent.com/Icegrave0391/attack-scenarios/main/misc-installs/ntp_client.conf
```
update ntp with the server:

```
ntpdate -d -u 172.26.187.140 (server IP)
```
