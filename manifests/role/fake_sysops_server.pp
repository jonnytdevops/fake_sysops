class role::fake_sysops_server {
  class {'user_setup':}
  class {'motd_cowsay':}
  class {'lamp_stack':}
}