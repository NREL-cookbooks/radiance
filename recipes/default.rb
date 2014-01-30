#
# Cookbook Name:: radiance
# Recipe:: default
#
# Copyright (C) 2014 Nicholas Long
# 
# All rights reserved - Do Not Redistribute
#

#radiance_version = node['radiance']['version']
#major_version = r_version.split(".").first

## Command to check if we should be installing
is_installed_command = nil #"radiance --version | grep -q #{version}"

include_recipe "ark"
include_recipe "cmake"
                          
# install some extra packages to make this work right.
case node['platform_family']
  when "debian"
    # this is broken for centos 6.5 because kernel-devel isn't available??
    include_recipe "apt::default"
    include_recipe "build-essential"
    package "libqt4-core"
    package "libqt4-dev"
    package "libx11-dev"
  when "rhel"
    package "qt"
end

if node['radiance']['install_method'] == "source"
  bash "install radiance" do
    cwd "/tmp"

    package_name = node['radiance']['source_filename']

    code <<-EOH
      wget --no-check-certificate #{node['radiance']['source_url']}/#{node['radiance']['version']}.tar.gz
      tar xzf #{node['radiance']['version']}.tar.gz 

      cd /tmp/Radiance-#{node['radiance']['version']}    
                
      # remove the pabopto2rad target
      sed -i 's/INSTALL(TARGETS pabopto2rad pabopto2bsdf)//' ./src/cv/CMakeLists.txt
                    
      cmake -DCMAKE_INSTALL_PREFIX:PATH=#{node['radiance']['install_prefix']} .
      make -j2
      make install
    EOH

    not_if { ::File.exists?("/#{node['radiance']['install_prefix']}/bin/rad") }
  end
end

template "/etc/profile.d/radiance.sh" do
  source "radiance.sh.erb"
  owner "root"
  group "root"
  mode "0644"
end

#ark "radiance" do
#  name "radiance"
#  version "1.1"
#  url node['radiance']['url']
#  autoconf_opts node['radiance']['config_opts'] if node['radiance']['config_opts']
#
#  action :install_with_cmake
#
## This is skipped if the url/path exists
#  not_if is_installed_command
#end
