#
# Cookbook Name:: load
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Iterate over the apache sites
node["load"]["sites"].each do |site_name, site_data|
# Set the document root

document_root = "var/www/html/#{site_name}"

execute "update" do
  command "ls"
  action :run
end

package "apache2" do
 action :install
end

service "apache2" do
 action [ :enable, :start]
end

apt_package ['tomcat7','tomcat7-docs','tomcat7-admin','tomcat7-examples','tomcat7-user','default-jdk']  do
  action :install
end

template "/etc/apache2/sites-available/#{site_name}.conf" do
 source "custom.erb"
 mode "0644"
 variables(
 :document_root => document_root,
 :port => site_data["port"]
 )
notifies :restart, "service[apache2]"
end

directory "#{document_root}" do
 mode "0755"
 recursive true
end

template "#{document_root}/index.html" do
 source "index.html.erb"
 mode "0644"
 variables(
 :site_name => site_name,
 :port => site_data["port"]
 )
end
end


package "apache2" do
 action :install
end

service "apache2" do
 action [ :enable, :start]
end

apt_package ['tomcat7','tomcat7-docs','tomcat7-admin','tomcat7-examples','tomcat7-user','default-jdk']  do
  action :install
end


service "tomcat7" do
 action [ :enable, :start]
end

execute "Stop Tomcat" do
  command "sudo service tomcat7 stop"
  action :run
end


execute "remove tomcate 7" do
  command "sudo update-rc.d -f tomcat7 remove"
  action :run
end


#execute "Create Direcory for tomcat" do
 # cwd "/home/ubuntu"
  #command "sudo mkdir tomcat7"
  #action :run
#end

=begin
execute "change ownership for root" do
  cwd "/home/ubuntu"
  command "sudo chown root:root tomcat7"
  returns [0,1]
  action :run
end



execute "change mode for tomcat" do
  cwd "/home/ubuntu"
  command "sudo chmod 777 tomcat7"
  returns [0,1]
   action :run
end



execute "Create tomcat instance for tomcat1" do
  cwd "/home/ubuntu/tomcat7"
  command "sudo tomcat7-instance-create -p 8082 -c 8007 tomcat1"
  not_if { File.exists?("/etc/init.d/tomcat1") }
  returns [0,1]
  action :run
end


execute "Copy tomcate to tomcat1" do
  cwd "/etc/init.d"
  command "sudo cp tomcat7 tomcat1"
  action :run
end

execute "Create tomcat instance for tomcat2" do
  cwd "/home/ubuntu/tomcat7"
  command "sudo tomcat7-instance-create -p 8081 -c 8006 tomcat2"
  not_if { File.exists?("/etc/init.d/tomcat2") }
  action :run
end


execute "Copy tomcate to tomcat2" do
  cwd "/etc/init.d"
  command "sudo cp tomcat7 tomcat2"
  action :run
end


execute "add tomcate1 to startup" do
  command "sudo update-rc.d  tomcat1 defaults"
  action :run
end

execute "add tomcate2" do
  command "sudo update-rc.d  tomcat2 defaults"
  action :run
end

#yogeshrathorewebsym
=end
cookbook_file "home/ubuntu/hello.sql" do
  source "hello.sql"
  mode '0755'
end

script 'Set the password' do
  interpreter "bash"
  code <<-EOH
   debconf-set-selections <<< 'mysql-server mysql-server/root_password password yogesh'    
    EOH
end


script 'password again' do
  interpreter "bash"
  code <<-EOH
   debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password yogesh'    
    EOH
end


execute "Install mysql server" do
  command "sudo apt-get -y install mysql-server"
  action :run
end

execute "restart mysql server" do
  command "sudo service mysql restart"
  action :run
end

execute "Add mysql as a startup" do
  command "sudo update-rc.d mysql defaults"
  action :run
end



service "apache2" do
 action [ :enable, :start]
end


script 'connection check' do
  interpreter "bash"
  cwd "/home/ubuntu"
  code <<-EOH
   mysql --user=root --password=yogesh < hello.sql    
    EOH
end


execute "Starting downloading WARfile" do
  cwd "/home/ubuntu" 
  command "s3cmd --force  get s3://opswork-artifacts/wars/Spring3HibernateApp.war"
  returns [0,1]
  action :run
end


execute "Starting downloading WARfile" do
  cwd "/home/ubuntu"
  command "sudo scp Spring3HibernateApp.war  /var/lib/tomcat7/webapps/Spring3HibernateApp.war"
  returns [0,1]
  action :run
end


execute "Starting downloading WARfile" do
  command "sudo service tomcat7 restart"
  returns [0,1]
  action :run
end
