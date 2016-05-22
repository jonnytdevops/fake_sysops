# A Web server using apache and mysql, with a simple PHP file that calls the database
## Modules used: puppetlabs-apache, puppetlabs-mysql
class fake_sysops::profile::lamp_stack (
  $site_name            = 'site1',
  $site_port            = 8080,
  $mysql_root_password  = 'super_secret',
  $database_name        = 'test_database',
  $database_user        = 'php_user',
  $database_password    = 'less_super_secret',
){

  class {'apache':
    mpm_module => prefork,
  }

  include 'apache::mod::php'

  apache::vhost {"${site_name}":
    port          => $site_port,
    docroot       => "/var/www/${site_name}",
    docroot_owner => 'apache',
    docroot_group => 'apache',
    default_vhost => true,
  }

  file {"/var/www/${site_name}/index.php":
    content => template('fake_sysops/index.php.erb'),
    require => Apache::Vhost["${site_name}"],
  }

  class {'::mysql::server':
    root_password           => $mysql_root_password,
    remove_default_accounts => true,
  }

  class {'::mysql::bindings':
    php_enable => true,
  }

  mysql::db {"${database_name}":
    user      => $database_user,
    password  => $database_password,
    host      => 'localhost',
    grant     => ['ALL'],
    require   => Class['::mysql::server'],
  }

  file {['/root/backups_apache/','/root/backups_mysql/']:
    ensure => directory,
  }

  cron {'backup apache':
    command  => 'rsync -a /var/www /root/backups_apache/',
    user     => 'root',
    hour     => 2,
    require  => File['/root/backups_apache/']
  }

  cron {'backup mysql':
    command  => "mysqldump -u ${database_user} -p='${database_password}' -h localhost ${database_name} > /root/backups_mysql/${database_name}.sql",
    user     => 'root',
    hour     => 2,
    require  => File['/root/backups_mysql/']
  }
}
