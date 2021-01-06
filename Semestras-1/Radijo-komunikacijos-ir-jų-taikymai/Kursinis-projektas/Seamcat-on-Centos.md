As our instructor offered the class only these two files, I guess he means Windows-based `Seamcat` setups only:
```
.../118110/mod_resource/content/1/seamcat.msi  
.../118111/mod_resource/content/1/jxpiinstall.exe  
```

Of course which some students cannot handle because of the different OS they use (eg. Chrome OS, or CentOS Linux).

Thus [@saulius-krasuckas](https://github.com/saulius-krasuckas) is about to investigate the way to run `Seamcat` on CentOS.

### Finding the downloads

So, as you go to the https://www.seamcat.org/, you get redirected to CEPT homepage:  
https://cept.org/eco/eco-tools-and-services/seamcat-spectrum-engineering-advanced-monte-carlo-analysis-tool

Here, in the **Download** subsection you will be asked for *registration*, but I guess that isn't strictly required.  
You could access downloads directly here:  

https://www.seamcat.org/download/

Here is the file list as of `2021-01-06`:
```
 4/24/2020  1:32 PM        <dir> plugin
 4/24/2020  1:32 PM     31481145 SEAMCAT-5.4.1.jar
  6/6/2019  1:19 PM     31282565 seamcat-application-5.3.0.jar
 1/16/2018 12:02 PM     21614811 SEAMCAT_5.1.1.jar
  6/6/2019  7:49 AM     23580855 SEAMCAT_5.2.0.jar
11/18/2019  1:22 PM     31253485 SEAMCAT_5.3.1.jar
 2/27/2020  2:51 PM     31447365 SEAMCAT_5.4.0.jar
11/19/2019 10:33 AM        <dir> source
 11/4/2019 10:48 AM          168 web.config
```
### Downloading
```
$ sudo curl -OLv http://www.seamcat.org/download/SEAMCAT-5.4.1.jar
[sudo] password for p: 
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0* About to connect() to www.seamcat.org port 80 (#0)
*   Trying 194.182.137.14...
* Connected to www.seamcat.org (194.182.137.14) port 80 (#0)
> GET /download/SEAMCAT-5.4.1.jar HTTP/1.1
> User-Agent: curl/7.29.0
> Host: www.seamcat.org
> Accept: */*
> 
< HTTP/1.1 200 OK
< Content-Type: application/java-archive
< Last-Modified: Fri, 24 Apr 2020 12:32:18 GMT
< Accept-Ranges: bytes
< ETag: "bed29664341ad61:0"
< Server: Microsoft-IIS/10.0
< X-Powered-By: ASP.NET
< Date: Wed, 06 Jan 2021 13:58:58 GMT
< Content-Length: 31481145
< 
{ [data not shown]
100 30.0M  100 30.0M    0     0   796k      0  0:00:38  0:00:38 --:--:-- 1016k^B
* Connection #0 to host www.seamcat.org left intact
```
### Chek OpenJDK versions, if any:
```
$ rpm -qa | grep -i jdk
java-1.7.0-openjdk-headless-1.7.0.261-2.6.22.2.el7_8.x86_64
java-1.7.0-openjdk-1.7.0.261-2.6.22.2.el7_8.x86_64
java-1.8.0-openjdk-headless-1.8.0.275.b01-0.el7_9.x86_64
java-1.8.0-openjdk-1.8.0.275.b01-0.el7_9.x86_64
copy-jdk-configs-3.3-10.el7_5.noarch

$ java -version
openjdk version "1.8.0_275"
OpenJDK Runtime Environment (build 1.8.0_275-b01)
OpenJDK 64-Bit Server VM (build 25.275-b01, mixed mode)
```
