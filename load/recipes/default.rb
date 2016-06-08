#
# Cookbook Name:: load
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

# Iterate over the apache sites

# Set the document root


execute "update" do
  command "sudo apt-get update"
  action :run
end



apt_package ['tomcat7','tomcat7-docs','tomcat7-admin','tomcat7-examples','tomcat7-user','default-jdk']  do
  action :install
end


service "tomcat7" do
 action [ :enable, :start]
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
  owner 'tomcat7'
  action :run
end


execute "Starting downloading WARfile" do
  cwd "/home/ubuntu"
  command "sudo scp Spring3HibernateApp.war  /var/lib/tomcat7/webapps/Spring3HibernateApp.war"
  owner 'tomcat7'
  action :run
end


execute "Starting downloading WARfile" do
  command "sudo service tomcat7 restart"
  owner 'tomcat7'
  action :run
end
