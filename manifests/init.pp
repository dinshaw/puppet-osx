class { 'homebrew':
  user => 'dgobhai',
}
package { 'gtypist':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew']
}

rbenv::install { 'dgobhai': }
rbenv::compile { '2.0.0-p247': }

exec { 'dotfiles':
  creates => '/Users/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dinshaw/dotfiles.git /Users/dgobhai/.dotfiles && cd /Users/dgobhai/.dotfiles && ./rake install',
}
