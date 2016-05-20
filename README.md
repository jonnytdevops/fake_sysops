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

To get started, you could start out by creating and running the following script:
```
# Startup Fake Sysops Server
rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
yum -y install puppet-agent
yum -y install git

cat <<EOF > /etc/puppetlabs/code/Puppetfile
forge 'forge.puppet.com'
mod 'puppetlabs/apache'
mod 'puppetlabs/mysql'
mod 'puppetlabs/motd'
mod 'puppetlabs/stdlib'
mod 'puppetlabs/concat'
mod 'saz/sudo'
mod 'jonnytpuppet/fake_sysops', :git => 'https://github.com/jonnytpuppet/fake_sysops'
mod 'inkblot/bind'
mod 'puppetlabs/ntp'
mod 'saz/timezone'
mod 'saz/ssh'
mod 'puppetlabs/firewall'
EOF

cat <<EOF > /etc/puppetlabs/code/localhost.pp
include fake_sysops::role::fake_sysops_server
EOF

gem install r10k
cd /etc/puppetlabs/code/
r10k puppetfile install

/opt/puppetlabs/bin/puppet apply /etc/puppetlabs/code/localhost.pp
```

There are probably much better ways to manage your Puppetfile, however this is a quick way to get you started.
