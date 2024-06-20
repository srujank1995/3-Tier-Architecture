#!/bin/bash
# Update the package repository
sudo yum update -y

# Install Java
sudo yum install -y java-1.8.0-openjdk

# Create a directory for the application
mkdir /home/ec2-user/myapp

# Download the Java application (assuming you have a JAR file)
wget -O /home/ec2-user/myapp/myapp.jar <URL_TO_YOUR_JAR_FILE>

# Run the Java application
java -jar /home/ec2-user/myapp/myapp.jar &
