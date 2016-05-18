# motd upon login to show cowsay and a fortune
## Modules used: puppetlabs-motd
class fake_sysops::profile::motd_cowsay {

  package {'cowsay':
    ensure   => present,
    provider => rpm,
    source => "http://www.melvilletheatre.com/articles/el7/cowsay-3.03-14.el7.centos.noarch.rpm"
  }

  package {'recode':
    ensure => present,
  }

  package {'fortune':
    ensure   => present,
    name     => 'fortune-mod-1.99.1-17.el7.x86_64',
    provider => rpm,
    source   => "ftp://mirror.switch.ch/pool/4/mirror/epel/7/x86_64/f/fortune-mod-1.99.1-17.el7.x86_64.rpm",
    require  => Package['recode'],
  }

  file {'/etc/profile.d/cowsay.sh':
    ensure  => present,
    content => "/usr/bin/fortune | /usr/bin/cowsay",
    mode    => '0777',
  }

  class {'motd':
    content => "Welcome to the World of Fake SysOps\n",
  }
}