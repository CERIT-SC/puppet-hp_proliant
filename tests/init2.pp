class { 'hp_proliant':
  force           => true,
  hasstatus       => true,
  repo            => true,
  use_acucli      => true,
  use_oncfg       => true,
  use_health      => true,
  use_snmp_agents => true,
}
