# A Forwarding DNS server with 2 A hosts and 2 CNAMEs for a fake domain.

class fake_sysops::profile::dns {
	class {'bind':
		forwarders => ['208.67.222.222', '208.67.220.220'],
		version    => '1.0.0',
	}

	bind::zone {'fakesysops.me':
		zone_type => 'master',
		dynamic 	=> false,
	}

	bind::view {'internal':
		recursion	=> true,
		match_destinations => ['127.0.0.1',],
		zones 						 => ['fakesysops.me',],
	}

	resource_record { 'first a record':
		ensure	=> present,
		record  => 'first.fakesysops.me',
		type 		=> 'A',
		data		=> '1.1.1.1',
		ttl			=> 86400,
		zone 		=> 'fakesysops.me',
	}

	resource_record { 'second a record':
		ensure	=> present,
		record  => 'second.fakesysops.me',
		type 		=> 'A',
		data		=> '2.2.2.2',
		ttl			=> 86400,
		zone 		=> 'fakesysops.me',
	}

	resource_record { 'first cname record':
		ensure	=> present,
		record  => 'foo.fakesysops.me',
		type 		=> 'A',
		data		=> 'first',
		ttl			=> 86400,
		zone 		=> 'fakesysops.me',
	}

	resource_record { 'second cname record':
		ensure	=> present,
		record  => 'bar.fakesysops.me',
		type 		=> 'A',
		data		=> 'second',
		ttl			=> 86400,
		zone 		=> 'fakesysops.me',
	}
}