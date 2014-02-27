#
# Author:: Nicholas Long(<nicholas.long@nrel.gov>)
# Cookbook Name:: radiance
# Attribute:: default
#

# This uses the NREL mirror Github repo
default['radiance']['install_method'] = "source"
default['radiance']['source_url'] = "https://github.com/NREL/Radiance/archive" 
default['radiance']['version'] = "4.2.a.2"
default['radiance']['install_prefix'] = "/usr/local/radiance"
