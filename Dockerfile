FROM maven:3.6.3-jdk-8 as build

# Work around a bug in Java 1.8u181 / the Maven Surefire plugin.
# See https://stackoverflow.com/questions/53010200 and
# https://issues.apache.org/jira/browse/SUREFIRE-1588.
ENV JAVA_TOOL_OPTIONS "-Djdk.net.URLClassPath.disableClassPathURLCheck=true"

# Build Sakai.
COPY sakai sakai
WORKDIR sakai

# nb. Skip tests to speed up the container build.
# RUN mvn clean install -Dmaven.tomcat.home=$CATALINA_HOME -Dsakai.home=$CATALINA_HOME\sakai -Dmaven.test.skip=true -DskipTests

# Download and install Apache Tomcat.
RUN mkdir -p /opt/tomcat
RUN curl "https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.54/bin/apache-tomcat-9.0.54.tar.gz" > /opt/tomcat/tomcat.tar.gz
RUN tar -C /opt/tomcat -xf /opt/tomcat/tomcat.tar.gz --strip-components 1

# Configure Tomcat.
# See https://confluence.sakaiproject.org/display/BOOT/Install+Tomcat+9
ENV CATALINA_HOME /opt/tomcat
COPY context.xml /opt/tomcat/conf/

# Install web app.
RUN mvn clean install sakai::deploy -Dmaven.tomcat.home=$CATALINA_HOME -Dsakai.home=$CATALINA_HOME\sakai -Dmaven.test.skip=true -DskipTests

FROM openjdk:8

# Copy Sakai configuration.
COPY sakai.properties /opt/tomcat/sakai/
COPY setenv.bat /opt/tomcat/bin/
COPY mysql-connector-java-5.1.49.jar /opt/tomcat/lib/
# Copy Sakai and Tomcat.
COPY --from=build /opt/tomcat /opt/tomcat

# Run Sakai
EXPOSE 8080
WORKDIR /opt/tomcat/bin
CMD ./startup.sh && tail -f ../logs/catalina.out
