class fake_sysops::role::fake_sysops_server {
  class {'fake_sysops::profile::user_setup':}
  class {'fake_sysops::profile::motd_cowsay':}
  class {'fake_sysops::profile::lamp_stack':}
  class {'fake_sysops::profile::dns':}
  class {'fake_sysops::profile::useful_packages':}
  class {'fake_sysops::profile::time':}
  class {'fake_sysops::profile::port_filter':}
  class {'fake_sysops::profile::checks':}

  class {'fake_sysops::profile::dummyd':
    hostname    => 'dummyhost.local',
    city        => 'Glasgow',
    colour      => 'Purple',
    manage_car  => true,
    #gps_country => 'UK',
  }
}