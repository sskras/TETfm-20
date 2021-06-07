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
- [x] 4. https://gitlab.com/ThanosApostolou/fedora-specs/-/raw/master/SPECS/nam.spec
  - [x] 1. Needs to downgrade the error checking:
  ```
	--- nam.spec	2021-06-07 11:07:47.684490724 +0300
	+++ nam-el7.9.spec	2021-06-07 11:11:57.386509205 +0300
	@@ -10,6 +10,7 @@
	 Source0:        https://sourceforge.net/projects/nsnam/files/nam-1/%{version}/%{name}-src-%{version}.tar.gz
	 Patch0:		https://gitlab.com/ThanosApostolou/fedora-specs/raw/master/SOURCES/nam-1.15-gcc61.patch
	 Patch1:		https://gitlab.com/ThanosApostolou/fedora-specs/raw/master/SOURCES/nam-1.15-tcl86.patch
	+Patch2:		nam-1.15-gcc-use-fpermissive.patch

	 Requires:	libX11
	 Requires:	libXt
	@@ -33,6 +34,7 @@
	 %setup
	 %patch0 -p1
	 %patch1 -p1
	+%patch2 -p1

	 %build
	 ./configure --prefix=/usr
  ```
  The downgrading patch:
  ```
	--- a/configure	2021-06-07 11:13:50.991517614 +0300
	+++ b/configure	2021-06-07 11:14:37.867521083 +0300
	@@ -5037,14 +5037,14 @@
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
  - [x] X. End of `nam.spec` build
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

Installation:
```
$ sudo yum install nam-1.15-5.el7.x86_64.rpm ns2-2.35-4.el7.x86_64.rpm tclcl-1.20-4.el7.x86_64.rpm otcl-1.14-6.el7.x86_64.rpm 
Loaded plugins: fastestmirror, langpacks
Examining nam-1.15-5.el7.x86_64.rpm: nam-1.15-5.el7.x86_64
Marking nam-1.15-5.el7.x86_64.rpm to be installed
Examining ns2-2.35-4.el7.x86_64.rpm: ns2-2.35-4.el7.x86_64
Marking ns2-2.35-4.el7.x86_64.rpm to be installed
Examining tclcl-1.20-4.el7.x86_64.rpm: tclcl-1.20-4.el7.x86_64
Marking tclcl-1.20-4.el7.x86_64.rpm to be installed
Examining otcl-1.14-6.el7.x86_64.rpm: otcl-1.14-6.el7.x86_64
Marking otcl-1.14-6.el7.x86_64.rpm to be installed
Resolving Dependencies
--> Running transaction check
---> Package nam.x86_64 0:1.15-5.el7 will be installed
--> Processing Dependency: tcl for package: nam-1.15-5.el7.x86_64
Loading mirror speeds from cached hostfile
 * base: centos.koyanet.lv
 * epel: ftp.icm.edu.pl
 * extras: centos.hitme.net.pl
 * nux-dextop: mirror.li.nux.ro
 * rpmfusion-free-updates: ftp.icm.edu.pl
 * rpmfusion-nonfree-tainted: ftp.icm.edu.pl
 * rpmfusion-nonfree-updates: ftp.icm.edu.pl
 * updates: centos.slaskdatacenter.com
https://copr-be.cloud.fedoraproject.org/results/gnikandrov/tox-im/epel-7-x86_64/repodata/repomd.xml: [Errno 14] HTTPS Error 404 - Not Found
Trying other mirror.
To address this issue please refer to the below wiki article 

https://wiki.centos.org/yum-errors

If above article doesn't help to resolve this issue please use https://bugs.centos.org/.

--> Processing Dependency: tk for package: nam-1.15-5.el7.x86_64
--> Processing Dependency: libtcl8.5.so()(64bit) for package: nam-1.15-5.el7.x86_64
--> Processing Dependency: libtk8.5.so()(64bit) for package: nam-1.15-5.el7.x86_64
---> Package ns2.x86_64 0:2.35-4.el7 will be installed
---> Package otcl.x86_64 0:1.14-6.el7 will be installed
---> Package tclcl.x86_64 0:1.20-4.el7 will be installed
--> Running transaction check
---> Package tcl.x86_64 1:8.5.13-8.el7 will be installed
---> Package tk.x86_64 1:8.5.13-6.el7 will be installed
--> Finished Dependency Resolution

Dependencies Resolved

=======================================================================================================================================
 Package                 Arch                     Version                             Repository                                  Size
=======================================================================================================================================
Installing:
 nam                     x86_64                   1.15-5.el7                          /nam-1.15-5.el7.x86_64                     810 k
 ns2                     x86_64                   2.35-4.el7                          /ns2-2.35-4.el7.x86_64                     5.1 M
 otcl                    x86_64                   1.14-6.el7                          /otcl-1.14-6.el7.x86_64                    186 k
 tclcl                   x86_64                   1.20-4.el7                          /tclcl-1.20-4.el7.x86_64                   1.2 M
Installing for dependencies:
 tcl                     x86_64                   1:8.5.13-8.el7                      base                                       1.9 M
 tk                      x86_64                   1:8.5.13-6.el7                      base                                       1.4 M

Transaction Summary
=======================================================================================================================================
Install  4 Packages (+2 Dependent packages)

Total size: 11 M
Total download size: 3.3 M
Installed size: 15 M
Is this ok [y/d/N]: 
Downloading packages:
(1/2): tcl-8.5.13-8.el7.x86_64.rpm                                                                              | 1.9 MB  00:00:00     
(2/2): tk-8.5.13-6.el7.x86_64.rpm                                                                               | 1.4 MB  00:00:01     
---------------------------------------------------------------------------------------------------------------------------------------
Total                                                                                                  2.3 MB/s | 3.3 MB  00:00:01     
Running transaction check
Running transaction test
Transaction test succeeded
Running transaction
  Installing : 1:tcl-8.5.13-8.el7.x86_64                                                                                           1/6 
  Installing : 1:tk-8.5.13-6.el7.x86_64                                                                                            2/6 
  Installing : otcl-1.14-6.el7.x86_64                                                                                              3/6 
  Installing : tclcl-1.20-4.el7.x86_64                                                                                             4/6 
  Installing : nam-1.15-5.el7.x86_64                                                                                               5/6 
  Installing : ns2-2.35-4.el7.x86_64                                                                                               6/6 
  Verifying  : tclcl-1.20-4.el7.x86_64                                                                                             1/6 
  Verifying  : 1:tcl-8.5.13-8.el7.x86_64                                                                                           2/6 
  Verifying  : nam-1.15-5.el7.x86_64                                                                                               3/6 
  Verifying  : 1:tk-8.5.13-6.el7.x86_64                                                                                            4/6 
  Verifying  : ns2-2.35-4.el7.x86_64                                                                                               5/6 
  Verifying  : otcl-1.14-6.el7.x86_64                                                                                              6/6 

Installed:
  nam.x86_64 0:1.15-5.el7         ns2.x86_64 0:2.35-4.el7         otcl.x86_64 0:1.14-6.el7         tclcl.x86_64 0:1.20-4.el7        

Dependency Installed:
  tcl.x86_64 1:8.5.13-8.el7                                          tk.x86_64 1:8.5.13-6.el7                                         

Complete!
```

Testing:
```
[p@localhost src]$ mkdir ns-2-test
[p@localhost src]$ cd ns-2-test
[p@localhost ns-2-test]$ vim add.tcl
[p@localhost ns-2-test]$ cat add.tcl
set a 20
set b 30
set c [expr $a + $b]
puts $c

[p@localhost ns-2-test]$ ns add.tcl
50
```
