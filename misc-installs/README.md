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
wget https://www.haproxy.org/download/2.5/src/haproxy-2.5.4.tar.gz
tar xzvf haproxy-2.5.4.tar.gz
cd haproxy-2.5.4
```

- install

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