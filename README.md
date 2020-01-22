# CustomerPortalSampleApplication

Sample Customer Management Application demonstrating microservices with Springboot, Netflix OSS , Docker and docker-compose.

License : [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

### Using Travis-Ci build:
[![Build Status](https://travis-ci.org/dipsscor/CustomerPortalSampleApplication.svg?branch=master)](https://travis-ci.org/dipsscor/CustomerPortalSampleApplication)


### Using SonarCloud Coverage:
[![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=com.customerPortalApp%3AcustomerPortalApp)](https://sonarcloud.io/dashboard?id=com.customerPortalApp%3AcustomerPortalApp)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=com.customerPortalApp%3AcustomerPortalApp&metric=coverage)](https://sonarcloud.io/dashboard?id=com.customerPortalApp%3AcustomerPortalApp)
[![Quality Gate Status](https://sonarcloud.io/api/project_badges/measure?project=com.customerPortalApp%3AcustomerPortalApp&metric=alert_status)](https://sonarcloud.io/dashboard?id=com.customerPortalApp%3AcustomerPortalApp)


# Prerequsites:
	JAVA Version = 8 or higher
	Compute : CPU 4
	Memory : 8GB or higher
	Docker Enviornment available
	Travis-ci for CI/CD
	Sonar.io for Code quality
    Docker enviornment with cache clear - network , volumes , images , containers.

# Architecture:
![alt text](https://github.com/dipsscor/CustomerPortalSampleApplication/blob/master/Architecture.png)

# Account Management
The Account Management Service provides the REST APIs for Account Service . The Rest APIs can be accessed using Swagger UI based on number of instances launched in docker-compose:

	http://locahost:12001/swagger-ui.html
	http://locahost:12002/swagger-ui.html


# Customer Management
The Customer Management Service provides the REST APIs for Customer Service . The Rest APIs can be accessed using Swagger UI based on number of instances launched in docker-compose:

	http://locahost:11001/swagger-ui.html
	http://locahost:11002/swagger-ui.html


# Customer Account Management
The Customer Account Management Service is a composite that provides the REST APIs for bot Account and Customer Service . The Rest APIs can be accessed using Swagger UI:

	http://locahost:13001/swagger-ui.html



# Eureka Discovery Service
The Eureka Discovery Service provides the Service Discovery capablities.

	http://locahost:9001


# Zipkin Tracing Service
The Zipkin Tracing Service provides the distributed tracing capablities.

	http://locahost:9411

       
# Spring Cloud Config Service
The Spring Cloud Config Service provides the externalization of configurations from github.

	http://locahost:8001
	
Configurations are stored in :
	https://github.com/dipsscor/CustomerPortalSampleApplication-Repos.git

# Zuul Gateway Service
The Zuul Gateway Service works as the API Gateway for customer portal Management Application
	
	http://locahost:10001


  
    Zuul URL: http://localhost:10001/API/customer-management-service/CUSTOMER-MANAGEMENT/V1.0/CUSTOMER/LIST
    Zuul URL: http://localhost:10001/API/account-management-service/ACCOUNT-MANAGEMENT/V1.0/ACCOUNT/LIST


    Zuul account Swagger URL: http://localhost:10001/API/account-management-service/swagger-ui.html#/account-management
    Zuul customer Swagger URL: http://localhost:10001/API/customer-management-service/swagger-ui.html#

# Spring Admin Service
The Spring Admin Service is a community project to manage and monitor your Spring Boot applications.

	http://locahost:8002
The Spring Admin Service is integrated with SLACK to send notifications to Webhook:
Slack Webhook link mentioned in Admin Service - application.yml file and application.properties.


# Hystrix Circuit breaker Dashboard Service
The Hystrix Dashboard Service allows to monitor the Hystrix Streams from applications.
In CustomerPortalSampleApplication Hystrix Circuit breaker has been configured for "Customer Account Management" Service. The hystrix streams flows from the "Customer Account Management" to Hystrix Dashboard Service when configured the URL. 

### Hystrix Stream URL for "Customer Account Management":

    http://localhost:13001/actuator/hystrix.stream

### Hystrix Dashboard 
Service needs to be configured with the above URL to monitor with Service name instead of localhost.

    URL : http://customer-account-management-service:13001/actuator/hystrix.stream

Hystrix Dashboard Service URL: 

    http://localhost:9090/hystrix




# Order of Execution

   ## prequisites of execution
   If you are using docker desktop , clear all the unused images , networks , volumes etc in docker engine.
   
   1.Spring Cloud Config Service
   
   2.Eureka Discovery Service
   
   3.Zipkin Tracing Service
   
   4.Zuul Gateway Service.
   
   5.Spring Admin Service

   6.Hystrix Dashboard Service
   
   7.Rest of Services


# Docker Compose Intructions
  Run as : docker-compose up --scale account-management-service=2 --scale customer-management-service=2

	Here AccountManagementService and CustomerManagementService are started with 2 instances each so that Ribbon loadbalancing can be shown. Both the services have allowable 4 ports configured in Docker compose.



# Jacoco Code Coverage
Jacoco plugin has been used for code coverage. 
Add the following plugin to pom.xml:

	In Properties: <jacoco.version>0.8.2</jacoco.version>	
	In Plugins:
	     <plugin>
                <groupId>org.jacoco</groupId>
                <artifactId>jacoco-maven-plugin</artifactId>
                <version>${jacoco.version}</version>
                <executions>
                    <execution>
                        <goals>
                            <goal>prepare-agent</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>jacoco-report</id>
                        <phase>test</phase>
                        <goals>
                            <goal>report</goal>
                        </goals>
                    </execution>
                    <execution>
                        <id>jacoco-check</id>
                        <goals>
                            <goal>check</goal>
                        </goals>
                        <configuration>
                            <rules>
                                <rule>
                                    <element>PACKAGE</element>
                                    <limits>
                                        <limit>
                                            <counter>LINE</counter>
                                            <value>COVEREDRATIO</value>
                                            <minimum>0.0</minimum>		# Sets the code coverage value
                                        </limit>
                                    </limits>
                                </rule>
                            </rules>
                        </configuration>
                    </execution>
                </executions>
            </plugin>






# Travis-CI
Travis-CI is being used for CI/CD.Create a travis-ci account in travis-ci.org and log in through Github. In this project travis-ci.org is being used for public repositories. For private repositories use "travis-ci.com"
Travis-ci supports pipeline as a code , so you need a .travis.yml in your project for build pipelines. 
Embed the travis-ci build icon url in the Github repo for linking:
		[![Build Status](https://travis-ci.org/dipsscor/CustomerPortalSampleApplication.svg?branch=master)](https://travis-ci.org/dipsscor/CustomerPortalSampleApplication)
		
### Steps:
	1. Create an account in travis-ci.org and authenticate in with github.
	2. Create an account in SonaCloud.io and authenticate with github.
	3. Sync Github projects in travis-ci.
	4. Create .travis.yml in root project folder for pipeline as a code
	5. Builds will be triggered for every commits ,but excluded for pull and other branch commits.
	6. Create a security token in SonarCloud.io account and add to the .travis.yml in add-ons for Sonar integrations.
	7. Get SonarCloud badges going into Projects-->get badges.
	




# Telemetry 
Spring Boot includes a number of additional features to help you monitor and manage your application when you push it to production. You can choose to manage and monitor your application by using HTTP endpoints or with JMX. Auditing, health, and metrics gathering can also be automatically applied to your application.The "spring-boot-actuator" module provides all of Spring Boot’s production-ready features. 


### Exposed Endpoints for Customer Portal Sample Application

|Metric| Description|
|------|------------|
|/configprops|Displays a collated list of all @ConfigurationProperties.|
|/env|Exposes properties from Spring’s ConfigurableEnvironment.|
|/health|Shows application health information.|
|/info| Shows the application Name.|
|/metrics|Shows ‘metrics’ information for the current application.|

### Access the endpoints
	http://<host>:<port>/actuator/<property
	e.g. http://localhost:11001/actuator/health



# References
	# How to Create Slack Webhook:
	https://api.slack.com/incoming-webhooks
	 
	#Sonar Cloud config
	https://docs.travis-ci.com/user/sonarcloud/
	
	#Springboot-travis-ci
	https://sivalabs.in/2018/01/ci-cd-springboot-applications-using-travis-ci/
