node[:deploy].each do |application, deploy|
  # Set ACL rules to give proper permission to files directory.
  script "update_acl" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    mkdir -p files/ application/cache/twig
    mount -o remount,acl /srv/www
    setfacl -R -m u:deploy:rwX -m u:apache:rwX -m u:ec2-user:rwX files application/cache/twig
    setfacl -dR -m u:deploy:rwx -m u:apache:rwX -m u:ec2-user:rwx files application/cache/twig
    chmod -R 777 files
    EOH
  end
  
  app_root = "#{deploy[:deploy_to]}/current"
  execute "chmod -R g+rw #{app_root}" do
  end
  
end