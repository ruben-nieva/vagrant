node 'graylog-elasticsearch01' {

  class { 'linux': }
  class { 'mediawiki': }

}

class linux {
  $admintools = ['git', 'nano', 'screen']
  
  $ntpservice = $osfamily ? {
   'redhat' => 'ntpd',
   'debian' => 'ntp',
   'default' => 'ntp',
  }

  package { $admintools:
   ensure => 'installed',
  }

  file { '/info.txt':
   ensure => 'present',
   content => inline_template("Created by Pupett <%= Time.now %>\n"),
  }
  
  package { 'ntp':
   ensure => 'installed',
  }

  service { $ntpservice:
   ensure => 'running',
   enable => true,
  }

}
