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

chef_gem "facter"
                          
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
  require 'facter'

  # Check if the system has enough memory per core for the build process 
  number_of_available_cores = Facter.fact(:processorcount).value.to_i - 1
  number_of_available_cores = 1 if number_of_available_cores == 0
  Chef::Log.info "Available Cores: #{number_of_available_cores}."
  
  if platform_family?("debian") || platform_family?("rhel")
    ark "radiance" do
      url "#{node['radiance']['source_url']}/#{node['radiance']['version']}"
      extension "zip"
      version node['radiance']['version']
      prefix_root '/usr/local'
      cmake_opts ["-DCMAKE_INSTALL_PREFIX:PATH=#{node['radiance']['install_prefix']}", "-DCMAKE_BUILD_TESTING=OFF", "DCMAKE_BUILD_HEADLESS=ON"]
      make_opts ["-j#{number_of_available_cores}", "> build.log 2>&1"]
      action :install_with_cmake
    end
  else
    Chef::Log.warn("Building on a #{node['platform_family']} system is not yet not supported by this cookbook")
  end
end

template "/etc/profile.d/radiance.sh" do
  source "radiance.sh.erb"
  owner "root"
  group "root"
  mode "0644"
end
