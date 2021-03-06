#
# Cookbook Name:: radiance
# Recipe:: default
#
# Copyright (C) 2015 Nicholas Long
#

# radiance_version = node['radiance']['version']
# major_version = r_version.split(".").first

## Command to check if we should be installing
is_installed_command = nil # "radiance --version | grep -q #{version}"

include_recipe 'ark'

chef_gem 'facter'

# install some extra packages to make this work right.
case node['platform_family']
when 'debian'
  include_recipe 'apt::default'
  include_recipe 'build-essential'
  package 'libtiff5-dev'

  # install opengl
  package 'libglu1-mesa-dev'
  package 'freeglut3-dev'
  package 'mesa-common-dev'

when 'rhel'

end

if node['radiance']['install_method'] == 'source'
  require 'facter'

  # Check if the system has enough memory per core for the build process
  number_of_available_cores = Facter.fact(:processorcount).value.to_i - 1
  number_of_available_cores = 1 if number_of_available_cores == 0
  Chef::Log.info "Available Cores: #{number_of_available_cores}."

  download_url = "#{node['radiance']['source_url']}/#{node['radiance']['version']}"

  if platform_family?('debian') || platform_family?('rhel')
    ark 'radiance' do
      url download_url
      extension 'zip'
      version node['radiance']['version']
      prefix_root '/usr/local'
      cmake_opts ["-DCMAKE_INSTALL_PREFIX:PATH=#{node['radiance']['install_prefix']}", '-DBUILD_TESTING=OFF', '-DBUILD_HEADLESS=ON', '-DBUILD_PACKAGE=OFF']
      make_opts ["-j#{number_of_available_cores}", '> build.log 2>&1']
      action :install_with_cmake
    end
  else
    Chef::Log.warn("Building on a #{node['platform_family']} system is not yet not supported by this cookbook")
  end
end

template '/etc/profile.d/radiance.sh' do
  source 'radiance.sh.erb'
  owner 'root'
  group 'root'
  mode '0644'
end
