## Scenario

A wicked user tries to steal secret files from the company's internal network. He first copies the secret files with `cp`, as well as some other files, to his shared folder. Finally, those files are exfiltrated to the internet by `Lighttpd`.

### Similar scenario

[ProTracer: Towards Practical Provenance Tracing by Alternating Between Logging and Tainting](https://friends.cs.purdue.edu/pubs/NDSS16.pdf)

An employee copies some files to a public page by vim, and causes the information leakage.

## Implementation

### sources
Ubuntu 16.04: http://mirror.nus.edu.sg/ubuntu-ISO/16.04/
wget https://www.nano-editor.org/dist/v2.5/nano-2.5.0.tar.gz
./configure --prefix=/home/chuqi/local/nano --disable-mouse
export MYNANO=/home/chuqi/local/nano/bin/nano


wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-2.25.1.tar.gz

git clone git://git.sv.gnu.org/coreutils
cd coreutils
./bootstrap
CC="gcc -g" CFLAGS="-Wno-error" ./configure --prefix=/home/chuqi/local/coreutils


wget https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.53.tar.gz --no-check-certificate
./configure --prefix=/home/chuqi/local/lighttpd  --without-bzip2