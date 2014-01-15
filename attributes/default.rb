#
# Author:: Nicholas Long(<nicholas.long@nrel.gov>)
# Cookbook Name:: radiance
# Attribute:: default
#

default['radiance']['install_method'] = "source"
default['radiance']['source_url'] = "http://www.radiance-online.org/software/snapshots" 
default['radiance']['source_filename'] = "radiance-HEAD.tgz"
default['radiance']['version'] = "4.2.a"

default['radiance']['install_prefix'] = "/usr/local/radiance"
default['radiance']['support_file_url'] = "http://www.radiance-online.org/software/non-cvs"
default['radiance']['support_filename'] = "rad4R0supp.tar.gz" 


# todo: eventually use git to download head and build
#default['radiance']['git_url'] = "https://github.com/nrel/radiance"
