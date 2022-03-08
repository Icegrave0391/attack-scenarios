## Scenario

The victim user checks emails daily with a lightweight terminal email client `mutt`. Meanwhile, the users mail server uses `sendmail` as MTA by default. One day, he receives a phishing email from the attacker, in which includes an attachment named `mal-slides`. After downloading and opening the attachment, which is actually a malware, the malicious file opens a backdoor port on the victim's machine and sends the shell to the attacker.

### Similar scenario

[OmegaLog: High-Fidelity Attack Investigation via Transparent Multi-layer Log Analysis](https://www.ndss-symposium.org/wp-content/uploads/2020/02/24270-paper.pdf)

The phishing email contains a malicious `.torrent` attachment file, and the file is downloaded by transmission later on.

[ALchemist: Fusing Application and Audit Logs for Precise Attack Provenance without Instrumentation](https://www.ndss-symposium.org/wp-content/uploads/2021-445-paper.pdf)

The phishing email contains a link to the malicious file `fcopy`, and the malware is downloaded in firefox.

[ProTracer: Towards Practical Provenance Tracing by Alternating Between Logging and Tainting](https://friends.cs.purdue.edu/pubs/NDSS16.pdf)

Same as ALchemist.

[MCI: Modeling-based Causality Inference in Audit Logging for Attack Investigation](https://weihang-wang.github.io/papers/mci_ndss18.pdf)

The phishing email contains a link to the camouflaged FTP server.

## Implementation

### sources

Ubuntu 16.04: http://mirror.nus.edu.sg/ubuntu-ISO/16.04/    
sendmail 8.15.2: ftp://ftp.sendmail.org/pub/sendmail/sendmail.8.15.2.tar.gz
procmail 3.22: https://github.com/Icegrave0391/attack-scenarios/releases/download/procmail-3.22/procmail-3.22.tar.gz    
mutt 2.1.5: http://ftp.mutt.org/pub/mutt/mutt-2.1.5.tar.gz    

### Deploy

**hostname** (Victim IP1)

First edit the `/etc/hosts` file to edit the hostname of the victim.

```
127.0.0.1 localhost
127.0.1.1 junzeng-OptiPlex-5060.test.local junzeng-OptiPlex-5060
...
```

**sendmail & procmail (Victim IP1)**

* build and install
```
# sendmail
sudo apt install sendmail

# procmail
# note that the 
cd procmail-3.22
sudo make && make install
```

* configuration file

Download `sendmail.conf, sendmail.mc, sendmail.cf` files under github directory `configs/`.

Download `.forward, .procmailrc` files under github directory `configs/`.

```
# sendmail

mv sendmail.conf /etc/mail/sendmail.conf
mv sendmail.mc /etc/mail/sendmail.mc
mv sendmail.cf /etc/mail/sendmail.cf

sendmailconfig

# forwarding 
mv .forward /home/chuqi/.forward

# procmail
mv .procmailrc /home/chuqi/.procmailrc
```

**mutt (Victim IP1)**

```
cd mutt-2.1.5
sudo make && make install
```

### Operations 

The victim just needs to activate sendmail daemon.
```
sudo sendmail -bd
```

### Exploit (Attacker IP2)

Before conducting the attack, make sure that the attacker's PC also satisfies the above environments (sendmail + mutt). Also, the attacker's PC should start the sendmail daemon.

1. download attack scripts    

Download the files under github directory `/scripts`

  * `send_email.sh`: the shell script to send email. (usage: `send_email.sh <email_subject> <email_content> <attachment_path> remote`) Note that the email address of victim has been hard-coded in this script.
  * `attack_server.py`: the server of attacker listening to the connection from victim.
  * `backdoor.py`: original malicious file. Note that the attacker's address IP2 has been hard-coded in the original malicious file.
  * `mal-slides`: packaged executable malicious file. 


2. send email to the victim.

```
./send_email.sh Mal-Mail1 trivial-content ./mal-slides remote
```





