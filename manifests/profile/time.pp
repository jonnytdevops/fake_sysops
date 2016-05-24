# NTP configuration for UK timezone

class fake_sysops::profile::time {

  package {'ntp':
    ensure => present,
  }

  file {'/etc/ntp.conf':
    ensure  => present,
    content => "# NTP Configuration using Puppet",
    require => Package['ntp'],
    notify  => Service['ntpd'],
  }

  # Add first UK NTP server
  file_line {'server 0.uk.pool.ntp.org':
    path    => '/etc/ntp.conf',
    line    => 'server 0.uk.pool.ntp.org',
    require => File['/etc/ntp.conf'],
  }

  # Add second UK NTP server
  file_line {'server 1.uk.pool.ntp.org':
    path    => '/etc/ntp.conf',
    line    => 'server 1.uk.pool.ntp.org',
    require => File['/etc/ntp.conf'],
  }

  service {'ntpd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  class {'timezone':
    timezone => "Europe/London",
  }

  # Alternatively, we could configure NTP using the NTP module like so:
  # class { '::ntp':
  #   servers   => ['0.pool.uk.ntp.org', '1.pool.uk.ntp.org'],
  #   restrict  => [
  #     'default ignore',
  #     '-6 default ignore',
  #     '127.0.0.1',
  #     '-6 ::1',
  #   ],
  # }


}