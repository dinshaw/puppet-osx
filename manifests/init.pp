class jenkins_box {
  rbenv::install { 'someuser': }
  rbenv::compile { '2.0.0-p247': }
  dotfiles { "dinshaw":
    gituser: "dinshaw";
  }
  include redis
}
