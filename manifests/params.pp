class hp_proliant::params {
  $force           = false
  $repo            = true
  $hasstatus       = true
  $use_acucli      = true
  $use_oncfg       = true
  $use_health      = true
  $use_snmp_agents = true

  # HP SNMP agents - cma.conf
  $cma_exclude              = ''
  $cma_cmaXSocketIf         = ''
  $cma_cmaXSocketBase       = ''
  $cma_cmaCloseCcissHandle  = ''
  $cma_trapIf               = ''
  $cma_trapemail            =
    '/usr/bin/mail -s \'HP Insight Management Agents Trap Alarm\' root'
}
