# NTP configuration for UK timezone

class fake_sysops::profile::time (
  $ntp_servers  = ['0.uk.pool.ntp.org', '1.uk.pool.ntp.org'],
  $local_only   = true,
){

  if $local_only == true {
    $restrict = ['default ignore', 
                 '-6 default ignore', 
                 '127.0.0.1', 
                 '-6 ::1']
  } else {
    $restrict = []
  }

  package {'ntp':
    ensure => present,
  }

  file {'/etc/ntp.conf':
    ensure  => present,
    content => template('fake_sysops/ntp.conf.erb'),
    require => Package['ntp'],
    notify  => Service['ntpd'],
  }

  # If we weren't using a Puppet ERB template, we could manually
  # add each line as follows:
  #
  # # Add first UK NTP server
  # file_line {'server 0.uk.pool.ntp.org':
  #   path    => '/etc/ntp.conf',
  #   line    => 'server 0.uk.pool.ntp.org',
  #   require => File['/etc/ntp.conf'],
  # }

  # # Add second UK NTP server
  # file_line {'server 1.uk.pool.ntp.org':
  #   path    => '/etc/ntp.conf',
  #   line    => 'server 1.uk.pool.ntp.org',
  #   require => File['/etc/ntp.conf'],
  # }

  service {'ntpd':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }

  class {'timezone':
    timezone => "Europe/London",
  }

  # Alternatively, we could forget about using our own "Package-File-Service design
  # and configure NTP using the NTP module from the forge like so:
  #
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