class { 'homebrew':
  user => 'dgobhai',
}
package { 'gtypist':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew']
}

# rbenv::install { 'dgobhai': }
# rbenv::compile { '2.0.0-p247': }

package { "googlechrome":
    source => "https://dl-ssl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg",
    provider => pkgdmg
  }

define pkg_deploy($sourcedir)
  {
  package { $name:
    ensure => installed,
    provider => pkgdmg,
    source => "$sourcedir/$name"
  }
}


pkg_deploy { "Sublime%20Text%20Build%203059":
  alias => sublimetext3,
  sourcedir => "http://c758482.r82.cf2.rackcdn.com"
}

exec { 'dotfiles':
  creates => '/Users/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dinshaw/dotfiles.git /Users/dgobhai/.dotfiles && cd /Users/dgobhai/.dotfiles && ./rake install',
}
