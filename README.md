# Metrics Monitoring Application using Prometheus and Grafana

Sample Springboot Application demonstrating metrics collection and monitoring using Prometheus and Grafana

License : [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)



# Prerequsites:
	JAVA Version = 8 or higher
	Compute : CPU 4
	Memory : 8GB or higher
	Docker Enviornment available
    Docker enviornment with cache clear - network , volumes , images , containers.
    
    
# Configurations:

## Springboot Application Configuration
The Springboot application contains both the "Actuator" and "Micrometer" dependencies.Micrometer is a dimensional-first metrics collection facade whose aim is to allow you to time, count, and gauge your code with a vendor neutral API. Through classpath and configuration, you may select one or several monitoring systems to export your metrics data to.

Micrometer is the metrics collection facility included in Spring Boot 2’s Actuator. It has also been backported to Spring Boot 1.5, 1.4, and 1.3 with the addition of another dependency.

Micrometer provides a vendor-neutral metrics collection API (rooted in io.micrometer.core.instrument.MeterRegistry) and implementations for a variety of monitoring systems:

	Netflix Atlas
	CloudWatch
	Datadog
	Ganglia
	Graphite
	InfluxDB
	JMX
	New Relic
	Prometheus
	SignalFx
	StatsD (Etsy, dogstatsd, Telegraf, and proprietary formats)
	Wavefront

### Micrometer and Prometheus dependencies
The metrics are exposed to http://localhost:8080/actuator/prometheus 

  		<dependency>
			<groupId>org.springframework.boot</groupId>
			<artifactId>spring-boot-starter-actuator</artifactId>
		</dependency>

		<dependency>
		    <groupId>io.micrometer</groupId>
		    <artifactId>micrometer-core</artifactId>
		</dependency>
		<dependency>
			<groupId>io.micrometer</groupId>
			<artifactId>micrometer-registry-prometheus</artifactId>
		</dependency>	


Application is accessible at:
	
	http://localhost:8080/hello


## Prometheus Configuration
Prometheus is being provisned with Docker-Compose using the latest Prometheus image.


	  prometheus:
	    image: prom/prometheus
	    container_name: prometheus
	    volumes:
	      - ./env/prometheus.yml:/etc/prometheus/prometheus.yml
	    ports:
	      - 9090:9090
	    networks:
	      - metrics-monitor 
	      
Prometheus confugurations are overwritten with prometheus.yml file located at : ./env/prometheus.yml. This goes into the docker container location : /etc/prometheus/prometheus.yml


In "prometheus.yml" file the :
	
	metrics_path is set to receive from : /actuator/prometheus from the spring boot applications.
	metrics_path: '/actuator/prometheus'
	
	Targets point to the springboot application named in "Docker compose" file.
	    static_configs:
	      - targets: ['web:8080']
	
 Prometheus will be running at following location on web:
 
 	http://localhost:9090 
	

## Grafana Configuration
Grafana is being provisned with Docker-Compose using the latest Grafana image.

	  grafana:
	    image: grafana/grafana
	    container_name: grafana
	    volumes:
	      - ./env/grafana_conf/provisioning:/etc/grafana/provisioning
	      - ./env/grafana_conf/custom_dashboards:/var/lib/grafana/dashboards
	    ports:
	      - 3000:3000
	    networks:
	      - metrics-monitor  
	    env_file:
	      - ./env/grafana.env
 Grafana configurations are overwritten through grafana.env file located at local in ./env/grafana.env
 
 In Grafana dashbaords and Datasources are pre-provisned through custom datasources and dashboards kept in env folder. These get copied to the appropriate location in Grafana's default location in Docker container.
 
 In Grafana - datasource.yml under ./env/provisioning/datasources the prometheus container URL is injected as datasource:
 
 	http://prometheus:9090
	
	
 In Grafana - dashboard.yml under ./env/provisioning/dashboards following config is used:
 
	folder: 'Spring-boot-apps'
	  type: 'file'
	  options:
	    folder: '/var/lib/grafana/dashboards'
	      
 #### Folder : Holds the dashboards . By default it is 'General'
 #### Options/Folder : holds the location where custom dashboards are injected.
 
 A custom dashboard is being used and modified from grafana market place for Springboot apps.
