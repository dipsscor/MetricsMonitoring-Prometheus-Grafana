FROM openjdk
MAINTAINER Dipankar Chatterjee <dipankar.c@hcl.com>
ADD target/MetricsMonitoring-1.0.jar MetricsMonitoring-1.0.jar
ENTRYPOINT exec java -jar /MetricsMonitoring-1.0.jar metrics-Monitoring-Prometheus-Grafana
EXPOSE 8080