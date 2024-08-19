# Setup New Ubuntu server with nginx
# and add a custom HTTP header

exec { 'update':
  command => 'sudo apt-get update',
  path    => '/usr/bin/'
}
package { 'nginx':
  ensure   => 'installed',
  name     => 'nginx',
  provider => 'apt',
  require  => Exec['update']
}

file {'/var/www/html/index.html':
	content => 'Hello World!'
}

exec {'redirect_me':
	command => 'sed -i "24i\	rewrite ^/redirect_me https://youtube.com/ permanent;" /etc/nginx/sites-available/default',
	provider => 'shell'
}

file_line { 'add_custom_header':
  path    => '/etc/nginx/sites-available/default',
  line    => "\tadd_header X-Served-By ${hostname};",
  after   => 'listen 80 default_server;',
  require => Package['nginx']
}
exec { 'restart':
  command => 'sudo service nginx restart',
  path    => '/usr/bin/',
  require => File_line['add_custom_header']
}
