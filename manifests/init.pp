
class jenkins_box {
  file {'/etc/puppet/hiera.yaml':
    ensure  => present,
    mode    => 0640,
  }

  package {'words.noarch': ;}
  class jenkins_box_prereqs {
    package{ 'gcc-c++':
      ensure => installed,
    }
    package{ 'tar':
      ensure => installed,
    }
    package{ 'bzip2.x86_64':
      ensure => installed,
    }
    package { "patch":
      ensure => installed,
    }
  }
  include jenkins_box_prereqs

  package { 'tigervnc-server':
    ensure => installed,
  }
  package { 'firefox':
    ensure => installed,
  }

  class { 'jenkins':
    require => Class['jenkins_box_prereqs'],
  } ->
  file {'/var/lib/jenkins/.vnc':
    ensure  => directory,
    mode    => 0755,
    owner => 'jenkins',
    group => 'jenkins',
    require => Class['jenkins'],
  }
  file {'/var/lib/jenkins/.vnc/passwd':
    source => 'puppet:///modules/jenkins_box/passwd',
    ensure  => present,
    mode    => 0600,
    owner => 'jenkins',
    group => 'jenkins',
    require => Class['jenkins'],
  }
  file {'/var/lib/jenkins/jobs':
    ensure  => directory,
    mode    => 0755,
    owner => 'jenkins',
    group => 'jenkins',
    require => Class['jenkins'],
  } ->
  file {'/var/lib/jenkins/jobs/Contacts':
    ensure  => directory,
    mode    => 0755,
    owner => 'jenkins',
    group => 'jenkins',
  } ->
  file {'/var/lib/jenkins/jobs/Contacts/config.xml':
    source => 'puppet:///modules/jenkins_box/config.xml',
    ensure  => present,
    mode    => 0655,
    owner => 'jenkins',
    group => 'jenkins',
  }
  exec {'restart jenkins':
    command => '/usr/sbin/service jenkins restart',
    subscribe   => File['/var/lib/jenkins/jobs/Contacts/config.xml'],
    refreshonly => true,
  }

  class { 'ant':
    require => Class['jenkins_box_prereqs'],
  }

  include nodejs
  include git
  include '::mysql::server'

  class { 'redis':
    version => '2.6.5',
  }
  exec { 'phantomjs':
    creates => '/usr/bin/phantomjs',
    command => '/usr/bin/npm install phantomjs -g',
  }

  jenkins::plugin {
    'token-macro' : ;
    "discard-old-build" : ;
    "multiple-scms" : ;
    "ssh-credentials" : ;
    "credentials" : ;
    "parameterized-trigger" : ;
    "scm-api" : ;
    "promoted-builds" : ;
    "git-client" : ;
    "git" : ;
    "ruby-runtime" : ;
    "rbenv" : ;
    "jenkinswalldisplay" : ;
    "xvnc" : ;
  }


  exec { 'Stop firewall':
    command => 'systemctl stop firewalld.service',
    path => '/usr/bin',
  }
}
