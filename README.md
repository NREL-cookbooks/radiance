# radiance cookbook

# Requirements

# Usage

Simple recipe for installing Radiance

# Recipes

`radiance::default`

# Todos

* need to convert this over to using Git and pull from github releaes
* update ark to support cmake workflow (symlink binaries)
* fix pabopto2rad (remove line `sed -i 's/INSTALL(TARGETS pabopto2rad pabopto2bsdf)//' /tmp/radiance_build/ray/src/cv/CMakeLists.txt`)
* need to better handle versioning (stuck at 4.2.a in a non-unique directory)
* LWRP for installtion
* general application testing
* testing on centos

# Author

Author:: Nicholas Long (<nicholas.long@nrel.gov>)
