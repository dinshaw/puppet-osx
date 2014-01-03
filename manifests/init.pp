class { 'homebrew':
  user => 'dgobhai',
} ->
exec { 'brew update':
  command => '/usr/local/bin/brew update',
}

package { 'gtypist':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew']
}

package { 'rbenv':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew']
} ->
package { 'rubybuild':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew']
} ->
exec { '2.0.0-p247':
  command => 'rbenv install 2.0.0-p247',
}

package { "googlechrome":
    source => "https://dl-ssl.google.com/chrome/mac/stable/GGRO/googlechrome.dmg",
    provider => pkgdmg
  }


  package { 'Sublime Text':
    ensure => installed,
    provider => pkgdmg,
    source => "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg",
  }


exec { 'dotfiles':
  creates => '/Users/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dinshaw/dotfiles.git /Users/dgobhai/.dotfiles && cd /Users/dgobhai/.dotfiles && ./rake install',
}
