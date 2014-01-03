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

package { 'Sublime Text Build 3059.dmg':
    ensure => installed,
    provider => pkgdmg,
    source => "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg"
}

exec { 'dotfiles':
  creates => '/Users/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dinshaw/dotfiles.git /Users/dgobhai/.dotfiles && cd /Users/dgobhai/.dotfiles && ./rake install',
}
