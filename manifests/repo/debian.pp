# Class: hp_proliant::repo::debian.pp
#
# HP Software Delivery Repository for ProLiantSupportPack
#
class hp_proliant::repo::debian {
	warning("By including and using this configuration, you agree to the \
terms and conditions of the HP Software License Agreement at \
http://h20000.www2.hp.com/bizsupport/TechSupport/softwareLicense.jsp?lang=en&cc=us&prodTypeId=15351&prodSeriesId=1121516&prodNameId=3288134&taskId=135")

	if $::lsbdistcodename == '' {
		fail('lsbdistcodename fact not available')
	}

	apt::source {
		'hp_proliant':
			location	=> 'http://downloads.linux.hp.com/SDR/downloads/ProLiantSupportPack',
			release		=> "${::lsbdistcodename}/current",
			repos		=> 'non-free',
			key			=> '2689B887',
	}
}
