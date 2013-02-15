class hp_proliant::health (
  $hasstatus
) {
  package { 'hp-health':
    ensure => present,
  }

  Service {
    ensure    => running,
    enable    => true,
    hasstatus => $hasstatus,
    require   => Package['hp-health']
  }

  service {
    'hp-health':
      pattern => 'hpasm(|xl|lite|pl)d';
    'hp-asrd':
      pattern => 'hp-asrd',
      require => Service['hp-health'],
  }
}
