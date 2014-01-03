class { 'homebrew':
  user => 'dgobhai',
}
package { 'tree':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew']
}

# rbenv::install { 'dgobhai': }
# rbenv::compile { '2.0.0-p247': }

exec { 'dotfiles':
  creates => '/home/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dinshaw/dotfiles.git /home/vagrant/.dotfiles && cd /home/vagrant/.dotfiles && ./rake',
}
