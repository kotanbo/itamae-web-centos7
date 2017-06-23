package "epel-release"

package "http://rpms.famillecollet.com/enterprise/remi-release-#{node[:platform_version][0]}.rpm" do
  not_if "rpm -q remi-release"
end

package "http://dev.mysql.com/get/mysql57-community-release-el#{node[:platform_version][0]}-9.noarch.rpm" do
  not_if "rpm -q mysql57-community-release-el#{node[:platform_version][0]}-9"
end

execute "wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo" do
  not_if "test -f /etc/yum.repos.d/yarn.repo"
end
execute "curl --silent --location https://rpm.nodesource.com/setup_6.x | bash -" do
  not_if "test -f /etc/yum.repos.d/nodesource-el.repo"
end
package "yarn"
