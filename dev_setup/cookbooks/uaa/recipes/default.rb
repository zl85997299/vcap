#
# Cookbook Name:: uaa
# Recipe:: default
#
# Copyright 2011, VMWARE
#
#

template "uaa.yml" do
  path File.join(node[:deployment][:config_path], "uaa.yml")
  source "uaa.yml.erb"
  owner node[:deployment][:user]
  mode 0644
end

bash "Grab dependencies for UAA" do
  user node[:deployment][:user]
  cwd "#{node[:cloudfoundry][:path]}/uaa"
  code "#{node[:maven][:path]}/bin/mvn install -U -DskipTests=true"
end

cf_bundle_install(File.expand_path(File.join(node["cloudfoundry"]["path"], "uaa")))
