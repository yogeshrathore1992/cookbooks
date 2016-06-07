#starting of cookbook

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
