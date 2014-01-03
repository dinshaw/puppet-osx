class { 'homebrew':
  user => 'dgobhai',
}
exec { 'tree':
  command   => '/usr/local/bin/brew install tree',
  require  => Class['homebrew']
}

# rbenv::install { 'dgobhai': }
# rbenv::compile { '2.0.0-p247': }

exec { 'dotfiles':
  creates => '/home/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dinshaw/dotfiles.git /home/dgobhai/.dotfiles && cd /home/dgobhai/.dotfiles && ./rake',
}
