class hp_proliant (
  $force                   = $hp_proliant::params::force,
  $repo                    = $hp_proliant::params::repo,
  $hasstatus               = $hp_proliant::params::hasstatus,
  $use_acucli              = $hp_proliant::params::use_acucli,
  $use_oncfg               = $hp_proliant::params::use_oncfg,
  $use_health              = $hp_proliant::params::use_health,
  $use_snmp_agents         = $hp_proliant::params::use_snmp_agents,
  $cma_exclude             = $hp_proliant::params::cma_exclude,
  $cma_cmaXSocketIf        = $hp_proliant::params::cma_cmaXSocketIf,
  $cma_cmaXSocketBase      = $hp_proliant::params::cma_cmaXSocketBase,
  $cma_cmaCloseCcissHandle = $hp_proliant::params::cma_cmaCloseCcissHandle,
  $cma_trapIf              = $hp_proliant::params::cma_trapIf,
  $cma_trapemail           = $hp_proliant::params::cma_trapemail
) inherits hp_proliant::params {

  require stdlib

  # works only on bare metal HP server or forced
  if $force == true or (
    ($::is_virtual == 'false') and
    ($::manufacturer == 'HP') and
    ($::productname =~ /^(?i-mx:ProLiant)/))
  {
    anchor { 'hp_proliant::begin': ; }
      -> anchor { 'hp_proliant::end': ; }

    # before we start, setup pkg. repository
    if $repo {
      class { 'hp_proliant::repo': ; }
        -> Anchor['hp_proliant::begin']
    }

    if $use_acucli {
      Anchor['hp_proliant::begin']
        -> class { 'hp_proliant::acucli': ; }
        -> Anchor['hp_proliant::end']
    }

    if $use_oncfg {
      Anchor['hp_proliant::begin']
        -> class { 'hp_proliant::oncfg': ; }
        -> Anchor['hp_proliant::end']
    }

    if $use_health {
      class { 'hp_proliant::health':
        hasstatus => $hasstatus,
      }

      Anchor['hp_proliant::begin']
        -> Class['hp_proliant::health']
        -> Anchor['hp_proliant::end']
    }

    if $use_snmp_agents {
      class { 'hp_proliant::snmp_agents':
        hasstatus           => $hasstatus,
        exclude             => $cma_exclude,
        trapemail           => $cma_trapemail,
        trapIf              => $cma_trapIf,
        cmaXSocketIf        => $cma_cmaXSocketIf,
        cmaXSocketBase      => $cma_cmaXSocketBase,
        cmaCloseCcissHandle => $cma_cmaCloseCcissHandle,
      }

      Anchor['hp_proliant::begin']
        -> Class['hp_proliant::snmp_agents']
        -> Anchor['hp_proliant::end']
    }
  }
}
