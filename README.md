# README

This project can be used to show performance problems in a jruby rails app, converted to a
WAR file using warbler.

What appears to happen is that after handling a few page requests, tomcat delays delivering
the rails output for many seconds (I have seen more than 10 seconds in testing).

I tried the sample.war given on the tomcat site, and it doesn't display this problem.
I suspect there is some problem with the delivery of the HTML output, after rails has
processed the request.
 
## Setup

```
git clone repo
rvm use jruby-9.2.0.0
bundle install
rails db:create
rails db:seed
rails assets:precompile
```

You will also need a version of apache tomcat. The problem exists in both tomcat 8.5.32 and
also in tomcat 7.0.53. A similar problem exists in wildfly 13.0.0 Final.

Tomcat 8 can be downloaded here: https://tomcat.apache.org/download-80.cgi

The sample java web app can be downloaded here: https://tomcat.apache.org/tomcat-7.0-doc/appdev/sample/

Wildfly 13.0.0 Final can be downloaded here: http://wildfly.org/downloads/

In all cases, I just unpacked the zip file, copied my war file into the appropriate
directory and started the server. I have included a restart_tomcat.sh script to speed this up.

## Installing in tomcat

You can alter the restart_tomcat.sh and specify the location of your tomcat instance.
