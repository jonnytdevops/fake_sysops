# Taken from https://forge.puppet.com/puppetlabs/ntp
## Modules used: puppetlabs/ntp and saz/timezone

class fake_sysops::profile::time {
  class { '::ntp':
    servers   => ['0.pool.uk.ntp.org', '1.pool.uk.ntp.org'],
    restrict  => [
      'default ignore',
      '-6 default ignore',
      '127.0.0.1',
      '-6 ::1',
    ],
  }

  class {'timezone':
    timezone => "Europe/London",
  }
}