For this course [@saulius-krasuckas](saulius-krasuckas) needs to run NS-2 on the CentOS 7.9.

Let's try building it in the form of `.rpm` from some `.spec` files found on the net:

- [x] 1. https://gitlab.com/ThanosApostolou/fedora-specs/-/raw/master/SPECS/ns2.spec
- [x] 2. https://gitlab.com/ThanosApostolou/fedora-specs/-/raw/master/SPECS/tclcl.spec
- [x] 3. https://gitlab.com/ThanosApostolou/fedora-specs/-/raw/master/SPECS/otcl.spec
  - [x] 1. Needs to drop the patch: 
  ```
  $ diff -u otcl.spec otcl-el7.9.spec | colordiff 
  --- otcl.spec	2021-06-07 10:27:15.939310740 +0300
  +++ otcl-el7.9.spec	2021-06-07 10:27:30.244311799 +0300
  @@ -6,7 +6,6 @@
   License:        BSD
   URL:            https://sourceforge.net/projects/otcl-tclcl/
   Source0:        https://sourceforge.net/projects/otcl-tclcl/files/OTcl/%{version}/%{name}-src-%{version}.tar.gz
  -Patch0:		https://gitlab.com/ThanosApostolou/fedora-specs/raw/master/SOURCES/otcl-1.14-tcl86-compat.patch

   BuildRequires:	gcc
   BuildRequires:	libX11-devel
  @@ -19,7 +18,6 @@

   %prep
   %setup
  -patch0 -p1

   %build
   ./configure --enable-static
  ```
- [ ] 4. `TODO`
- [x] X. End of SPECs
