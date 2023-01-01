# NeoMutt

NeoMutt is the terminal based email client I have setup for Linux Kernel development. I'm using it to conenct to my ProtonMail email address which requires the proton mail bridge to be installed.

## Passwords file

My passwords file is encrypted using the gpg key from my ProtonMail account. It can be downloaded from the web portal and then imported like such:

```shell
$ gpg --import ./file.asc
```

The file was then encrypted like so:

```shell
# Encrypt plain text file
$ gpg -r MichaelRT@pallid.dev -e ~/.mutt/passwords

# Securely remove the file from disk
$ shred ~/.mutt/passwords
$ rm ~/.mutt/passwords
```

The contents of the file before encryption look like such:

```
set imap_pass="password"
set smtp_pass="password"
```
