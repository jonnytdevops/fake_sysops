# A Forwarding DNS server with 2 A hosts and 2 CNAMEs for a fake domain.

class fake_sysops::profile::dns {
	class {'bind':
		forwarders => ['208.67.222.222', '208.67.220.220'],
		version    => '1.0.0',
	}

	bind::zone {'fakesysops.me':
		zone_type => 'master',
		source		=> 'puppet://modules/fake_sysops/dns/fakesysops.me-zone'
	}

	bind::view {'internal':
		recursion	=> true,
		match_destinations => ['127.0.0.1',],
		zones 						 => ['fakesysops.me',],
	}
}