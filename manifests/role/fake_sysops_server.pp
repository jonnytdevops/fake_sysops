class fake_sysops::role::fake_sysops_server {
  class {'fake_sysops::profile::user_setup':}
  class {'fake_sysops::profile::motd_cowsay':}
  class {'fake_sysops::profile::lamp_stack':}
}