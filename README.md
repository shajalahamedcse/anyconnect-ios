## Problem Statement

  

### Task 1:

  

Setup a standalone master OR a slave build machine for Jenkins to build iOS project.

* Configure Jenkins on a single/local machine. Add a build job to build and package for the provided iOS project.

* Assume that there is already a Jenkins server. Configure the slave build machine so that it can be added as the host system for the iOS project build environment.

For either case, configure build environment write required scripts to execute the build.

Successful completion of the task should build the iOS project successfully on demand.

  

### Task 2 :

Integrate a test framework to test the output generated by the task 1. The provided source has a single button, so able to demonstrate the test would be plus.

* For Xcode code signing using a test Apple account.

* Have documentation as required to explain a particular task.

Task 1 and 2 should follow the continuous integration system process (excluding the part of source repo and triggering the build).

  

## Solution :

  

I do not have any prior experience on ios apps development. So my machine was not ready for that. Most of the time I was busy to configure my machine. However , let's see what is in there.

  

### Jenkins Using Docker :

  

I have deployed a `Jenkins` server using `docker` in my mac. This container will work as `master` and my mac will work as builder . So it's a master slave architecture . Jenkins master will trigger the build and slave will build , test the code.

  

$ docker run -d -v jenkins_home:/var/jenkins_home -p 8080:8080 -p 50000:50000 jenkins/jenkins:latest

  

You have to `exec` into `docker` to get the `initial password`:

  

$ docker ps

64684cc4a76e jenkins/jenkins:latest "/sbin/tini -- /usr/…" 24 hours ago Up 24 hours 0.0.0.0:50000->50000/tcp, 0.0.0.0:8090->8080/tcp gallant_golick

$ docker exec -it 646 bash

jenkins@64684cc4a76e:/$ cat /var/jenkins_home/secrets/initialAdminPassword

  

Now use this `password` to do primary login:

  

### Add Host Mac as Slave:

  

Go to ` System Preference > Sharing > Remote Login`. You will get a remote login IP:

  

ssh shajalahamed@192.168.97.151

Now go to docker exec terminal and ssh into you mac host machine from docker .

  

$ ssh shajalahamed@192.168.97.151

Last login: Sat Feb 8 19:49:25 2020 from 192.168.0.103

  

You are in your mac machine.

  

$ exit

  
  

From your docker container add mac machine as your host.

$ ssh-keyscan -H 192.168.97.151 >> ~/.ssh/known_hosts

  

Add Node from your Jenkins:

  

![Node Add](https://github.com/shajalahamedcse/anyconnect-ios/blob/master/images/slave_configure.png)

  

Agent is Ready:

  

![Node Add](https://github.com/shajalahamedcse/anyconnect-ios/blob/master/images/agent.png)

  
  

## Fastlane as ios Automation Tool :

What is Fastlane ?

_`fastlane`_ is the easiest way to automate beta deployments and releases for your iOS and Android apps. 🚀 It handles all tedious tasks, like generating screenshots, dealing with code signing, and releasing your application.

My Fastfile:

	
	default_platform(:ios)

	platform :ios do
	  desc "This lane test the app"
	  lane :test do
	    run_tests
	  end

	  desc "This lane build the app"
	  lane :build do
	    build_app(export_xcargs: "-allowProvisioningUpdates")
	  end

	  lane :refreshJenkinsKeychain do
	    delete_keychain(name: "jenkins") if File.exists? File.expand_path("~/Library/Keychains/jenkins-db")
	    create_keychain(
	      name: "jenkins",
	      password: "jenkins",
	      timeout: false,
	      lock_when_sleeps: false,
	      unlock: true
	    )
	  end
	end

Now test this script in local:

	$ fastlane test


![Node Add](https://github.com/shajalahamedcse/anyconnect-ios/blob/master/images/test.png)

It's Working.

Now build the code :

	$ fastlane build

## Jenkins and Fastline Integration:

We will use multi-branch pipeline. Here is the configuration :

![Node Add](https://github.com/shajalahamedcse/anyconnect-ios/blob/master/images/jenkins1.png)

![Node Add](https://github.com/shajalahamedcse/anyconnect-ios/blob/master/images/jenkins2.png)

![Node Add](https://github.com/shajalahamedcse/anyconnect-ios/blob/master/images/jenkins3.png)