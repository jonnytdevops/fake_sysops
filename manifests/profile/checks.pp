class fake_sysops::profile::checks {
  file {'/etc/checks':
    ensure  => directory,
    source  => 'puppet:///modules/fake_sysops/checks/',
    mode    => '755',
    recurse => true,
  }

  package {'net-ntp':
    ensure    => present,
    provider  => gem,
  }
}