class hp_proliant::snmp_agents (
	$hasstatus,
	$exclude,
	$trapemail,
	$cmaXSocketIf,
	$cmaXSocketBase,
	$cmaCloseCcissHandle,
	$trapIf
) {
	package {
		'hp-snmp-agents':
			ensure	=> present,
			require	=> Class['hp_proliant::health'],
	}

	file {
		'/opt/hp/hp-snmp-agents/cma.conf':
			require	=> Package['hp-snmp-agents'],
			ensure	=> file,
			content	=> template('hp_proliant/cma.conf.erb'),
			notify	=> Service['hp-snmp-agents'],
	}

	snmp::server::config::snmpd {
		'hp_proliant-snmp-agents':
			content	=> "
# HP Insight Management Agents cfg.
dlmod cmaX /usr/lib64/libcmaX64.so";
	}

	service {
		'hp-snmp-agents':
			ensure		=> running,
			enable		=> true,
			hasstatus	=> $hasstatus,
			pattern		=> 'cmahealthd', #HACK: we only check for one of many daemons
			require		=> [
				File['/opt/hp/hp-snmp-agents/cma.conf'],
				Class['snmp::server']
			],
	}
}
