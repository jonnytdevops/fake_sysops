# Taken from https://forge.puppet.com/puppetlabs/ntp

class fake_sysops::profile::ntp_client {
  class { '::ntp':
    servers   => ['0.pool.uk.ntp.org', '1.pool.uk.ntp.org'],
    restrict  => [
      'default ignore',
      '-6 default ignore',
      '127.0.0.1',
      '-6 ::1',
    ],
  }
}