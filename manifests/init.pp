class { 'homebrew':
  user => 'dgobhai',
}
package { 'tree':
  ensure   => present,
  provider => brew,
  require  => Class['homebrew']
}

rbenv::install { 'someuser': }
rbenv::compile { '2.0.0-p247': }

dotfiles { 'dinshaw':
  gituser => 'dinshaw',
}
