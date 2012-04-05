class hp_proliant::params {
	case $::operatingsystem {
		debian,ubuntu: {
			$repo_class	= 'hp_proliant::repo::debian'
		}

		fedora,redhat,oel,centos: {
			fail("Unsupported OS (${::operatingsystem}), please check module https://github.com/runningman/puppet-psp")
		}

		default: {
			fail("Unsupported OS (${::operatingsystem})")
		}
	}

	if $force == ''						{ $force					= false }
	if $repo == ''						{ $repo						= true }
	if $hasstatus == ''					{ $hasstatus				= true }
	if $use_acucli == ''				{ $use_acucli				= true }
	if $use_oncfg == ''					{ $use_oncfg				= true }
	if $use_health == ''				{ $use_health				= true }
	if $use_snmp_agents == ''			{ $use_snmp_agents			= true }

	# HP SNMP agents - cma.conf
	if $cma_exclude == ''				{ $cma_exclude				= '' }
	if $cma_trapemail == ''				{ $cma_trapemail			= "/usr/bin/mail -s 'HP Insight Management Agents Trap Alarm' root" }
	if $cma_cmaXSocketIf == ''			{ $cma_cmaXSocketIf			= '' }
	if $cma_cmaXSocketBase == ''		{ $cma_cmaXSocketBase		= '' }
	if $cma_cmaCloseCcissHandle == ''	{ $cma_cmaCloseCcissHandle	= '' }
	if $cma_trapIf == ''				{ $cma_trapIf				= '' }
}
