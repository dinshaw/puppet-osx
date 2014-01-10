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
file { '/usr/local/bin/subl':
    ensure  => link,
    target  => '/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl',
    mode    => '0755',
    require => Package['SublimeText3'],
}

exec { 'dotfiles':
  creates => '/Users/dgobhai/.dotfiles',
  command => '/usr/bin/git clone https://github.com/dgobhai/dotfiles.git /Users/dgobhai/.dotfiles && cd /Users/dgobhai/.dotfiles && ./rake install',
}

exec { 'move_sublime_user_dir':
  creates => '/Users/dgobhai/Library/Application Support/Sublime Text 3/Packages/User-bak',
  command => "/bin/mv '/Users/dgobhai/Library/Application Support/Sublime Text 3/Packages/User' '/Users/dgobhai/Library/Application Support/Sublime Text 3/Packages/User-bak'",
  mode    => '0755',
  user => root,
} ->
exec { 'sublime_text_user_dir':
  creates => '/Users/dgobhai/Library/Application Support/Sublime Text 3/Packages/User',
  command => "/usr/bin/git clone https://github.com/dinshaw/sublime-user-dir.git '/Users/dgobhai/Library/Application Support/Sublime Text 3/Packages/User'",
}

Osx_defaults {
    user => 'dgobhai',
  }
osx_defaults { 'Put my Dock on the left':
    key    => 'orientation',
    domain => 'com.apple.dock',
    value  => 'left',
  }


