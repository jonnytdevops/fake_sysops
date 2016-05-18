# A Web server using apache and mysql, with a simple PHP file that calls the database
## Modules used: puppetlabs-apache, puppetlabs-mysql
class fake_sysops::profile::lamp_stack {

  class {'apache':
    mpm_module => prefork,
  }

  include 'apache::mod::php'

  apache::vhost {'site1':
    port          => 8080,
    docroot       => '/var/www/site1',
    docroot_owner => 'apache',
    docroot_group => 'apache',
    default_vhost => true,
  }

  file {'/var/www/site1/index.php':
    content => "<?php\n  mysql_connect('localhost', 'php_user', 'less_super_secret') or die('FAILED TO CONNECT TO MYSQL');\n  echo 'Connected to Database';\n?>",
    require => Apache::Vhost['site1'],
  }

  class {'::mysql::server':
    root_password           => 'super_secret',
    remove_default_accounts => true,
  }

  class {'::mysql::bindings':
    php_enable => true,
  }

  mysql::db {'test_database':
    user      => 'php_user',
    password  => 'less_super_secret',
    host      => 'localhost',
    grant     => ['ALL'],
    require   => Class['::mysql::server'],
  }
}
