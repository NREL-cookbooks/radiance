#
# Author:: Nicholas Long(<nicholas.long@nrel.gov>)
# Cookbook Name:: radiance
# Attribute:: default
#

# This uses the NREL mirror Github repo
default['radiance']['install_method'] = "source"
default['radiance']['source_url'] = "https://codeload.github.com/NREL/Radiance/zip" 
default['radiance']['version'] = "4.2.1"
default['radiance']['install_prefix'] = "/usr/local/radiance"
