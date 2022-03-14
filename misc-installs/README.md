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


