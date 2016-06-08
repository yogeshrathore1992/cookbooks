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



execute "Starting downloading WARfile" do
  cwd "/home/ubuntu" 
  command "s3cmd --force  get s3://opswork-artifacts/wars/Spring3HibernateApp.war"
  action :run
end


execute "Starting downloading WARfile" do
  cwd "/home/ubuntu"
  command "sudo scp Spring3HibernateApp.war  /var/lib/tomcat7/webapps/Spring3HibernateApp.war"
  action :run
end


execute "Starting downloading WARfile" do
  command "sudo service tomcat7 restart"
  action :run
end
