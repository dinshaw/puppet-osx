class osx_dev_station {
  class hightower::packages {
  pkglist = ['postgresql', 'nginx']

  package { $pkglist:
    ensure   => installed,
    provider => brew,
  }

  rbenv::install { 'someuser': }
  rbenv::compile { '2.0.0-p247': }
  dotfiles { "dinshaw":
    gituser: "dinshaw";
  }
}
