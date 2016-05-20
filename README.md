# fake_sysops
An example set of manifests for a fake server deployment using puppet.

This is still very much a WIP. It is notable that some data should be extracted out in to hiera.

Once complete, these manifests should be able to configure a CentOS7 server with the following:
* A user named bob with sudo access
* motd upon login to show cowsay and a fortune
* A Web server using apache and mysql, with a simple PHP file that calls the database
* A Forwarding DNS server with 2 A hosts and 2 CNAMEs for a fake domain.
* NTP configuration for UK timezone
* SSH public key auth
* Password logins disabled for root
* Firewall rule for port 8080 and 22 only
* Make sure rsync backs up apache to another location on same disk
* A dummy config file /etc/dummyd.conf with configurable settings
