class java {

  $package = 'oracle-java7-installer'

  file { '/tmp/java.preseed':
    content => 'oracle-java7-installer shared/accepted-oracle-license-v1-1 select true oracle-java7-installer shared/accepted-oracle-license-v1-1 seen true',
    mode   => '0600',
    backup => false,
  }

  include apt

  apt::ppa { 'ppa:webupd8team/java': }

  package { "$package":

    responsefile => '/tmp/java.preseed',

    require      => [
                     Apt::Ppa['ppa:webupd8team/java'],
                     File['/tmp/java.preseed']
                     ],
  }

 }
