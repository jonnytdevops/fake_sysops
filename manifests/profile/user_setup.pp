# A user named bob with sudo access
## Modules used: puppetlabs-stdlib, saz-sudo
class fake_sysops::profile::user_setup {
 
  user {'bob':
    ensure     => present,
    password   => pw_hash('test_password', 'SHA-512', 'mysupersalt'),
    managehome => true,
    shell      => '/bin/bash',
  }

  include 'sudo'
  sudo::conf {'bob':
    ensure  => present,
    content => '%bob ALL=(ALL) ALL',
    require => Class['sudo'],
  }
}