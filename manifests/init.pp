class { 'homebrew':
  user => 'dgobhai',
}

package { 'gtypist':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew'],
}

package { 'rbenv':
  ensure   => installed,
  provider => brew,
  require  => Class['homebrew'],
} ->
package { 'ruby-build':
  ensure   => installed,
  provider => brew,
  require  => Class['homebrew'],
}
# exec { '2.0.0-p247':
#   command => '/usr/local/bin/rbenv install 2.0.0-p247',
# }

package { 'SublimeText3':
  provider => 'appdmg',
  source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg';
}


exec { 'dotfiles':
  creates => '/Users/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dinshaw/dotfiles.git /Users/dgobhai/.dotfiles && cd /Users/dgobhai/.dotfiles && ./rake install',
}
