# FROM tomcat:8.5.40
# COPY target/sampleapp.war /usr/local/tomcat/webapps
# EXPOSE 8080
# CMD /usr/local/tomcat/bin/catalina.sh run
# #


# Pull base image 
From tomcat:8-jre8  
COPY ./sampleapp.war /usr/local/tomcat/webapps
