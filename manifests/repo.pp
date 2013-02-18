# Class: hp_proliant::repo.pp
#
# HP Software Delivery Repository for ProLiantSupportPack
#
class hp_proliant::repo {
  warning("By including and using this configuration, you agree to the \
terms and conditions of the HP Software License Agreement at \
http://h20000.www2.hp.com/bizsupport/TechSupport/softwareLicense.jsp?lang=en&\
cc=us&prodTypeId=15351&prodSeriesId=1121516&prodNameId=3288134&taskId=135")

  $site_url='http://downloads.linux.hp.com/SDR/downloads/ProLiantSupportPack'

  case $::operatingsystem {
    debian,ubuntu: {
      if $::lsbdistcodename == '' {
        fail('lsbdistcodename fact not available')
      }

      apt::source { 'hp_proliant':
        location => $site_url,
        release  => "${::lsbdistcodename}/current",
        repos    => 'non-free',
        key      => '2689B887',
      }
    }

    fedora,redhat,centos: {
      yumrepo { 'hp_proliant':
        name     => 'HP Software Delivery Repository for ProLiantSupportPack',
        baseurl  => "${site_url}/${::operatingsystem}/\$releasever/packages/\$basearch/",
        gpgkey   => "${site_url}/GPG-KEY-ProLiantSupportPack",
        gpgcheck => 1,
        enabled  => 1,
      }
    }

    default: {
      fail("Unsupported OS '${::operatingsystem}'")
    }
  }
}
