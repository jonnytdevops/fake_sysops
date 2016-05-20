# A user named bob with sudo access
## Modules used: puppetlabs-stdlib, saz-sudo, saz-ssh
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

  ssh_authorized_key {'jonnyt@test.local':
    user => 'bob',
    type => 'ssh-rsa',
    key  => 'AAAAB3NzaC1yc2EAAAADAQABAAABAQDim7Tga/JyYky8/E+EwOqf8Uzk2n/5nJN3E9ymKTgcBFlEmZo4aMew/e0JSZrTpCTj/gAFy2Nl+lLTAw19BSMCqPORtQ9dUqoPe2FJp882Jw/QRfqGdu+Ab37j/6kCQizvRDnqXYgrFLkMRvZkMJggB6PLIr4dePr8euCVhfee7MlT+tReZo/HvOFCPdlZWtQUISSKIGpqg7ywAEy2/ZheQ2e7KGjrgeg9RIlDBExWi/GbdcOWb9xOnta8QL6MSVxs5ptYLV3SWEGoy7gIeV0qpo2KEi91MA3m9+3CsbXtAmMVn3Z3FUpo8EBu1v/Woef9sDRSYimikGy+2VXpc+0h',
  }

  class {'ssh::server':
    options => {
      'PermitRootLogin' => 'without-password',
    }
  }
}