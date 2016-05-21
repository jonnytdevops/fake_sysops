# Firewall rule for port 8080 and 22 only
## Modules used: puppetlabs-firewall
class fake_sysops::profile::port_filter {
  class {'firewall':}
  firewall {'000 allow lo':
    ensure  => present,
    proto   => 'all',
    chain   => 'INPUT',
    iniface   => 'lo',
    action  => 'accept',
  }

  firewall {'001 allow ping':
    ensure  => present,
    proto   => 'icmp',
    chain   => 'INPUT',
    action  => 'accept',
  }

  firewall {'002 allow ssh':
    ensure  => present,
    proto   => 'tcp',
    dport   => '22',
    chain   => 'INPUT',
    action  => 'accept',
  }

  firewall {'003 allow lamp-server':
    ensure  => present,
    proto   => 'tcp',
    dport   => '8080',
    chain   => 'INPUT',
    action  => 'accept',
  }

  firewall {'004 allow related/established connections':
    ensure  => present,
    proto   => 'all',
    state   => ['RELATED', 'ESTABLISHED'],
    chain   => 'INPUT',
    action  => 'accept',
  }

  firewallchain {'INPUT:filter:IPv4':
    ensure  => present,
    policy  => 'drop',
    purge   => true,
  }
}