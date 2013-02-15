# Puppet hp_proliant module

This module setups package repository for HP ProLiant Support Pack.
It can be also used to install and configure basic tools.

### Requirements

Module has been tested on:

* Puppet 3.1.0
* Debian 6.0
* physical HP ProLiant server (requires facts manufacturer and productname)

# Quick Start

Quick basic setup

    include hp_proliant

Full configuration options:

    class { 'hp_proliant':
      force                   => false|true, # force setup on non-HP hardware
      repo                    => false|true, # configure HP pkg. repository
      hasstatus               => false|ture, # use service status or process pattern check?
      use_acucli              => false|true, # setup: HP Array CLI
      use_oncfg               => false|true, # setup: ILOE II/iLo online CLI
      use_health              => false|true, # setup: HP System Health app. and CLI
      use_snmp_agents         => false|true, # setup: Insight Mgmt. SNMP Agents

      # cma.conf parameters
      cma_exclude             => '...',
      cma_trapIf              => '...',
      cma_trapemail           => '...',
      cma_cmaXSocketIf        => '...',
      cma_cmaXSocketBase      => '...',
      cma_cmaCloseCcissHandle => '...',
    }
