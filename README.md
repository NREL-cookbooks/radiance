# radiance cookbook

# Requirements

# Usage

Simple recipe for installing Radiance

# Recipes

`radiance::default`

# Todos

* need to convert this over to using Git and pull from github releaes
* update ark to support cmake workflow (symlink binaries)
* update cmake to remove need for x11, qt, and outdated binaries
* fix pabopto2rad (remove line `sed -i 's/INSTALL(TARGETS pabopto2rad pabopto2bsdf)//' /tmp/radiance_build/ray/src/cv/CMakeLists.txt`)
* need to better handle versioning (stuck at 4.2.a in a non-unique directory)
* LWRP for installtion
* general application testing
* testing on centos
* host support files somewhere else (github?) [these are take too long to download] 
```
src='http://www.radiance-online.org/software/non-cvs/rad4R1supp.tar.gz'
dst='/tmp/radiance_build/ray/build/Downloads/Download/radiance_support/rad4R1supp.tar.gz'
```

# Author

Author:: Nicholas Long (<nicholas.long@nrel.gov>)
