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

dotfiles {'dgobhai':
    gituser      => 'boinger',
    giturl       => 'git://github.com',
    project      => 'dotfiles',
    dotfiles_dir => 'home',
    branch       => 'master',
    homedir      => "/home/${name}",
    clobber      => true,
    bak_ext      => '.bak',
    single_pull  => false,
    rebase       => true,
    frequency    => 30,
}
