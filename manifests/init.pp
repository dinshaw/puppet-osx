class { 'homebrew':
  user => 'dgobhai',
}
package { 'postgresql':
  ensure   => installed,
  provider => brew,
}
rbenv::install { 'someuser': }
rbenv::compile { '2.0.0-p247': }
dotfiles { 'dinshaw':
  gituser => 'dinshaw',
}
