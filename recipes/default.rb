#
# Cookbook Name:: radiance
# Recipe:: default
#
# Copyright (C) 2014 YOUR_NAME
# 
# All rights reserved - Do Not Redistribute
#

#radiance_version = node['radiance']['version']
#major_version = r_version.split(".").first
#
## Command to check if we should be installing R or not.
is_installed_command = nil #"radiance --version | grep -q #{version}"
                           #
                           #package "gcc-gfortran"
                           #
include_recipe "ark"
include_recipe "cmake"
                           #
                           ## install some extra packages to make this work right.
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
      wget #{node['radiance']['source_url']}/#{node['radiance']['source_filename']}
      wget #{node['radiance']['support_file_url']}/#{node['radiance']['support_filename']}
      mkdir radiance_build
      tar xzf #{node['radiance']['source_filename']} -C radiance_build   
      tar xzf #{node['radiance']['support_filename']} -C radiance_build
      
      # remove the pabopto2rad target
      sed -i 's/INSTALL(TARGETS pabopto2rad pabopto2bsdf)//' /tmp/radiance_build/ray/src/cv/CMakeLists.txt

      cd radiance_build/ray 
      mkdir build
      cd build                      
      cmake -DCMAKE_INSTALL_PREFIX:PATH=#{node['radiance']['install_prefix']} ..
      make
      make install
    EOH

    not_if { ::File.exists?("/tmp/#{package_name}") }
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
