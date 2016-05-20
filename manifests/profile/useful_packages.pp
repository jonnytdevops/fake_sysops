class fake_sysops::profile::useful_packages {
  package {['nano', 'vim']:
    ensure => present,
  }
}