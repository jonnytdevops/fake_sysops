# A dummy config file /etc/dummyd.conf with configurable settings
class fake_sysops::profile::dummyd(
  $hostname,
  $city,
  $colour,
  $manage_car       = false,
  $max_speed        = 70,
  $max_rpm          = 8000,
  $max_radio_volume = 10,
  $gps_country      = undef, 
) {

  file {'/etc/dummyd.conf':
    ensure  => file,
    content => template('fake_sysops/dummyd.conf.erb'),
  }
}