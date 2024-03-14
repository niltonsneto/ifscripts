#!/bin/bash

#apt-get update && apt-get -y upgrade


if [ ! -d "/etc/nsswitch.conf.old" ]; then
	mv /etc/nsswitch.conf /etc/nsswitch.conf.old
fi



cat <<EOF >/etc/nsswitch.conf
# Example configuration of GNU Name Service Switch functionality.
# If you have the glibc-doc-reference' and info' packages installed, try:
# info libc "Name Service Switch"' for information about this file.

passwd:         compat ldap
group:          compat ldap
shadow:         compat ldap
gshadow:        files

hosts:          files mdns4_minimal [NOTFOUND=return] dns myhostname ldap
networks:       files ldap

protocols:      db files
services:       db files
ethers:         db files
rpc:            db files

netgroup:       nis
EOF

if [ ! -d "/etc/ldap.conf.old" ]; then
	mv /etc/ldap.conf /etc/ldap.conf.old
fi

cat <<EOF >/etc/ldap.conf
# Your LDAP server. Must be resolvable without using LDAP.
# Multiple hosts may be specified, each separated by a 
# space. How long nss_ldap takes to failover depends on
# whether your LDAP client library supports configurable
# network or connect timeouts (see bind_timelimit).
#host 127.0.0.1

# The distinguished name of the search base.
base dc=araquari,dc=ifc,dc=edu,dc=br

# Another way to specify your LDAP server is to provide an
uri ldap://ldap.araquari.ifc.edu.br

# The LDAP version to use (defaults to 3
# if supported by client library)
ldap_version 3

# The distinguished name to bind to the server with
# if the effective user ID is root. Password is
# stored in /etc/ldap.secret (mode 600)
rootbinddn cn=reader,dc=araquari,dc=ifc,dc=edu,dc=br

#binddn cn=proxyuser,dc=padl,dc=com

#bindpw secret

# Filter to AND with uid=%s
pam_filter objectclass=SAUUsers

# HEADS UP: the pam_crypt, pam_nds_passwd,
# and pam_ad_passwd options are no
# longer supported.
#
# Do not hash the password at all; presume
# the directory server will do it, if
# necessary. This is the default.
pam_password md5

# SASL mechanism for PAM authentication - use is experimental
# at present and does not support password policy control
#pam_sasl_mech DIGEST-MD5
nss_initgroups_ignoreusers _apt,avahi,avahi-autoipd,backup,bin,colord,daemon,dnsmasq,games,gdm,geoclue,gnats,hplip,irc,kernoops,list,lp,mail,man,messagebus,news,nslcd,proxy,pulse,root,rtkit,saned,speech-dispatcher,sshd,sync,sys,syslog,systemd-bus-proxy,systemd-network,systemd-resolve,systemd-timesync,usbmux,uucp,uuidd,whoopsie,www-data
EOF

if [ ! -d "/etc/nslcd.conf.old" ]; then
	mv /etc/nslcd.conf /etc/nslcd.conf.old
fi

cat <<EOF >/etc/nslcd.conf
# /etc/nslcd.conf
# nslcd configuration file. See nslcd.conf(5)
# for details.

# The user and group nslcd should run as.
uid nslcd
gid nslcd

# The location at which the LDAP server(s) should be reachable.
uri ldap://ldap.araquari.ifc.edu.br

# The search base that will be used for all queries.
base dc=araquari,dc=ifc,dc=edu,dc=br

# The LDAP protocol version to use.
ldap_version 3

# The DN to bind with for normal lookups.
binddn cn=reader,dc=araquari,dc=ifc,dc=edu,dc=br
bindpw reader

# SSL options  VERIFICAR no Wireshark se algum pacote contém informações sigilosas
ssl off
#tls_reqcert never
tls_cacertfile /etc/ssl/certs/ca-certificates.crt

# The search scope.
#scope sub

base group  ou=services,dc=araquari,dc=ifc,dc=edu,dc=br
base passwd ou=users,dc=araquari,dc=ifc,dc=edu,dc=br
base shadow ou=users,dc=araquari,dc=ifc,dc=edu,dc=br
 
filter group (cn=labs)
 
filter passwd (memberOf=cn=labs,ou=services,dc=araquari,dc=ifc,dc=edu,dc=br)
map passwd gidNumber "2019"
####Observar se no arquivo /etc/nslcd está com variaveis home/$uid, gecos "$cn"
map passwd homeDirectory "/home/\$uid"
map passwd gecos "\$cn"
map passwd loginShell "/bin/bash"
 
filter shadow (objectClass=SAUUsers)
map shadow shadowLastChange "${shadowLastChange:--1}"
map shadow shadowMin "${shadowMin:--1}"
map shadow shadowMax "${shadowMax:--1}"
map shadow shadowWarning "${shadowWarning:--1}"
map shadow shadowInactive "${shadowInactive:--1}"
map shadow shadowExpire "${shadowExpire:--1}"
map shadow shadowFlag "${shadowFlag:-0}"
EOF

chown root:nslcd /etc/nslcd.conf
chmod 640 /etc/nslcd.conf

cat <<EOF >/etc/ldap.secret
reader
EOF

chmod 600 /etc/ldap.secret


apt-get install -y libnss-ldapd libpam-ldapd


#reinicia o servico
/etc/init.d/nslcd restart

#busca usuarios
getent passwd

/etc/init.d/nslcd status

# para criar o diretorio HOME no login do usuario
#sudo pam-auth-update
