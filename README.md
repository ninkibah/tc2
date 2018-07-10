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
Then just run ./restart_tomcat.sh.

It will take 10-60 seconds to start up depending on the speed of your machine.

Then in your browser, go to http://localhost:8080/tc2

## Performance problems

If you refresh the page from 5-20 times, you will notice that at least one of the
refresh times is taking a very long time (more than 10 seconds) to come up.
I have noticed that rails itself says it has produced the view (normally in under 500ms).
My guess is that the problem occurs in the jruby/rack code.

Running as a standalone puma app shows no performance problems.

## Performance tests using wrk

I installed wrk: 

Then I ran a 10 second test using 2 threads and 10 connections:

```
wrk -t2 -c10 -d10s http://127.0.0.1:8080/tc2

Running 10s test @ http://127.0.0.1:8080/tc2
  2 threads and 10 connections
  Thread Stats   Avg      Stdev     Max   +/- Stdev
    Latency   406.71us  820.35us  14.22ms   92.74%
    Req/Sec    22.81k     3.09k   29.49k    62.50%
  453939 requests in 10.00s, 45.10MB read
Requests/sec:  45382.48
Transfer/sec:      4.51MB
``` 

So, I don't notice any long running requests using wrk. However, refreshing in the browser
about 10 times caused a long running request.