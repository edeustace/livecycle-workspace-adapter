#!/bin/bash
##
## The following files are not part of the repo as they are part of Livecycle DataServices: fds.swc and fds_rb.swc.
## Once you have these, place them in this folder, run this command and they will be installed to your local maven repository.
##
mvn install:install-file -DgroupId=com.adobe.flex.dataservices -DartifactId=fds -Dpackaging=swc -Dversion=4.1.0.16076 -Dfile=fds.swc -DgeneratePom=true
mvn install:install-file -DgroupId=com.adobe.flex.dataservices -DartifactId=fds -Dpackaging=rb.swc -Dversion=4.1.0.16076 -Dfile=fds.swc -DgeneratePom=true

