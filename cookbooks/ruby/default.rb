%w{
  gcc
  git
  wget
  libcurl
  gdbm-devel
  openssl-devel
  libyaml-devel
  readline-devel
  zlib-devel
  ncurses-devel
  libffi-devel
  pcre-devel
}.each do |pkg|
  package pkg
end

rbenv_user = node[:rbenv] && node[:rbenv][:user] || "root"
rbenv_root = node[:rbenv] && node[:rbenv][:path] || "/usr/local/rbenv"

git rbenv_root do
  repository "git://github.com/sstephenson/rbenv.git"
  user rbenv_user
end

git "#{rbenv_root}/plugins/ruby-build" do
  repository "git://github.com/sstephenson/ruby-build.git"
  user rbenv_user
end

template "/etc/profile.d/rbenv.sh" do
  owner "root"
  group "root"
  mode "644"
  variables rbenv_root: rbenv_root
end

node[:ruby][:versions].each do |version|
  execute ". /etc/profile.d/rbenv.sh && CONFIGURE_OPTS='--disable-install-doc' rbenv install #{version}" do
    not_if ". /etc/profile.d/rbenv.sh && rbenv versions | grep '#{version}'"
  end
end

execute ". /etc/profile.d/rbenv.sh && rbenv global #{node[:ruby][:global]} && rbenv rehash" do
  not_if node[:ruby][:global]
end

node[:ruby][:gems].each do |gem|
  execute ". /etc/profile.d/rbenv.sh && gem install #{gem}; rbenv rehash" do
    not_if ". /etc/profile.d/rbenv.sh && gem list | grep #{gem}"
  end
end
