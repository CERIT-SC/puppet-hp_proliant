class hp_proliant::oncfg {
	package {
		'hponcfg':
			ensure	=> present,
			require	=> Class['hp_proliant::health'],
	}
}
