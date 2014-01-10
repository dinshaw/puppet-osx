class 1password (
  $version = '3.8.20',
) {
  package { 'ONEPassword':
    provider => 'compressed_app',
    source   => "http://aws.cachefly.net/dist/1P/mac/1Password-${version}.zip",
  }
}
