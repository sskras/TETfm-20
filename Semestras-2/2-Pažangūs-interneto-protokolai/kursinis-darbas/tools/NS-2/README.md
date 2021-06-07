For this course [@saulius-krasuckas](saulius-krasuckas) needs to run NS-2 on the CentOS 7.9.

Let's try building it in the form of `.rpm` from some `.spec` files found on the net:

- [x] 1. https://gitlab.com/ThanosApostolou/fedora-specs/-/raw/master/SPECS/ns2.spec
  - [x] 1. Needs to downgrade the error checking:
  ```
  --- ns2.spec	2021-06-07 10:49:33.846409764 +0300
  +++ ns2-el7.9.spec	2021-06-07 10:49:36.114409932 +0300
  @@ -12,6 +12,7 @@
   Patch1:		https://gitlab.com/ThanosApostolou/fedora-specs/raw/master/SOURCES/ns-2.35-tcl86.patch
   Patch2:		https://gitlab.com/ThanosApostolou/fedora-specs/raw/master/SOURCES/ns-2.35-getopts.patch
   Patch3:		https://gitlab.com/ThanosApostolou/fedora-specs/raw/master/SOURCES/ns-2.35-gcc-compile-errors.patch
  +Patch4:		ns-2.35-gcc-use-fpermissive.patch

   Requires:	libX11
   Requires:	libXt
  @@ -35,6 +36,7 @@
   %patch1 -p1
   %patch2 -p1
   %patch3 -p1
  +%patch4 -p1

   %build
   ./configure --prefix=/usr --enable-static
  ```
  The downgrading patch:
  ```
  --- a/configure	2021-06-07 10:44:59.039389424 +0300
  +++ b/configure	2021-06-07 10:45:42.963392675 +0300
  @@ -5118,14 +5118,14 @@
   if test "$enable_debug" = "yes" ; then
    V_CCOPT="-g"
    if test "$CC" = gcc ; then
  -		V_CCOPT="$V_CCOPT -Wall -Wno-write-strings -Wno-parentheses -Werror"
  +		V_CCOPT="$V_CCOPT -Wall -Wno-write-strings -fpermissive -Wno-parentheses -Werror"
      V_DEFINE="$V_DEFINE -fsigned-char -fno-inline"
    fi
   else
    V_CCOPT="$OonS"
    V_DEFINE="$V_DEFINE -DNDEBUG"
    if test "$CC" = gcc ; then
  -		V_CCOPT="$V_CCOPT -Wall -Wno-write-strings"
  +		V_CCOPT="$V_CCOPT -Wall -Wno-write-strings -fpermissive"
    fi
   fi

  ```
  - [x] X. End of `ns2.spec` build
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
  - [x] X. End of `otcl` build
- [ ] 4. https://gitlab.com/ThanosApostolou/fedora-specs/-/raw/master/SPECS/nam.spec
- [x] X. End of SPECs

The needed dev-dependencies:
- `gcc-c++`
- `libXt-devel`
- `tcl-devel`
- `tk-devel`
- `libstdc++-static`
- `glibc-static`

The CLI:
```
[p@localhost SPECS]$ sudo yum install gcc-c++ libXt-devel tcl-devel tk-devel libstdc++-static glibc-static
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
```

The yum history info:
```
Packages Altered:
    Dep-Install expat-devel-2.1.0-12.el7.x86_64        @base
    Dep-Install fontconfig-devel-2.13.0-4.3.el7.x86_64 @base
    Dep-Install freetype-devel-2.8-14.el7_9.1.x86_64   @updates
    Install     gcc-c++-4.8.5-44.el7.x86_64            @base
    Install     glibc-static-2.17-324.el7_9.x86_64     @updates
    Dep-Install libICE-devel-1.0.9-9.el7.x86_64        @base
    Dep-Install libSM-devel-1.2.2-2.el7.x86_64         @base
    Dep-Install libXft-devel-2.3.2-2.el7.x86_64        @base
    Dep-Install libXrender-devel-0.9.10-1.el7.x86_64   @base
    Install     libXt-devel-1.1.5-3.el7.x86_64         @base
    Dep-Install libpng-devel-2:1.5.13-8.el7.x86_64     @base
    Dep-Install libstdc++-devel-4.8.5-44.el7.x86_64    @base
    Install     libstdc++-static-4.8.5-44.el7.x86_64   @base
    Dep-Install libuuid-devel-2.23.2-65.el7_9.1.x86_64 @updates
    Dep-Install tcl-1:8.5.13-8.el7.x86_64              @base
    Install     tcl-devel-1:8.5.13-8.el7.x86_64        @base
    Dep-Install tk-1:8.5.13-6.el7.x86_64               @base
    Install     tk-devel-1:8.5.13-6.el7.x86_64         @base
```

More deps:
```
[p@localhost SPECS]$ rpmbuild -v -bl nam.spec 
error: Failed build dependencies:
	libXmu-devel is needed by nam-1.15-5.el7.x86_64

[p@localhost SPECS]$ sudo yum install libXmu-devel
Loaded plugins: fastestmirror, langpacks
Loading mirror speeds from cached hostfile
  ...
```
