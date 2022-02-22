# sakai-docker
Docker and configuration files for Sakai

This repository is designed for get you up and running quickly compiling from source code and with a MySQL database with a very basic OOTB (out of the box) Sakai on Docker. You do not need any other configuration for installation and deployment for Sakai 20.x. 

## Versions:
-	Java 1.8.0
-	maven 3.6.3.
-	Apache Tomcat 9
-	Either MySQL 5.7
-	MySQL connector version: 5.1.49

## Deploy
Create a folder named Sakai:

```
git clone https://github.com/sakaiproject/sakai.git
cd Sakai && git checkout 20.x
```

To build the Docker image for Sakai and launch containers for Sakai and MySQL, run:

```
docker-compose up
```

Once the Sakai container image has been built and the container is created, you can access Sakai:

```
http://localhost:8080/portal
```

## References:
- https://github.com/hypothesis/sakai-docker
- https://github.com/sakaiproject/sakai/wiki/Quick-Start-from-Source
- https://sakaiproject.atlassian.net/wiki/spaces/DOC/pages/17310646930/Sakai+21+Install+Guide+Source
