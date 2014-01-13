class { 'homebrew':
  user => 'dgobhai',
}

package { 'gtypist':
  ensure   => installed,
  provider => homebrew,
  require  => Class['homebrew'],
}

package { 'rbenv':
  ensure   => installed,
  provider => homebrew,
  require  => Class['homebrew'],
} ->
package { 'ruby-build':
  ensure   => installed,
  provider => homebrew,
  require  => Class['homebrew'],
}
# exec { '2.0.0-p247':
#   command => '/usr/local/bin/rbenv install 2.0.0-p247',
# }

package { 'SublimeText3':
  provider => 'appdmg',
  source   => 'http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203059.dmg';
}
package { 'Dropbox':
  provider => 'appdmg',
  source   => 'https://d1ilhw0800yew8.cloudfront.net/client/Dropbox%202.4.11.dmg'
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
  # mode    => '0755',
  user => root,
} ->
exec { 'sublime_text_user_dir':
  creates => '/Users/dgobhai/Library/Application Support/Sublime Text 3/Packages/User',
  command => "/usr/bin/git clone https://github.com/dinshaw/sublime-user-dir.git '/Users/dgobhai/Library/Application Support/Sublime Text 3/Packages/User'",
}
osx_defaults { 'Put my Dock where i want it':
  key    => 'orientation',
  domain => 'com.apple.dock',
  value  => 'left',
  user => 'dgobhai',
} ->
osx_defaults { 'Show no crap in the dock':
  key    => 'static-only',
  domain => 'com.apple.dock',
  value  => '-bool TRUE',
  user => 'dgobhai',
} ->
exec { 'refresh dock':
  command => '/usr/bin/killall Dock'
}

