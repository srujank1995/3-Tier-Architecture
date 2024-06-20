# Java Application Deployment on AWS using 3-Tier Architecture with Terraform

## Table of Contents

- [Introduction](#introduction)
- [Architecture Overview](#architecture-overview)
- [Prerequisites](#prerequisites)
- [Setup Instructions](#setup-instructions)
  - [1. Clone the Repository](#1-clone-the-repository)
  - [2. Configure AWS CLI](#2-configure-aws-cli)
  - [3. Initialize Terraform](#3-initialize-terraform)
  - [4. Deploy Infrastructure](#4-deploy-infrastructure)
- [File Structure](#file-structure)
- [Usage](#usage)
- [Cleaning Up](#cleaning-up)
- [Contributing](#contributing)
- [License](#license)

## Introduction

This repository contains the necessary Terraform scripts to deploy a Java application on AWS using a 3-Tier Architecture. The architecture includes the following layers:

- **Presentation Layer**: Amazon EC2 instances and an Elastic Load Balancer (ELB).
- **Application Layer**: Amazon EC2 instances running the Java application.
- **Database Layer**: Amazon RDS for the database.

## Architecture Overview
        +------------------------+
        |   Elastic Load Balancer|
        +----------+-------------+
                   |
           +-------+--------+
           |                |
  +--------+--------+ +-----+------+
  | EC2 Instance 1   | | EC2 Instance 2 |
  | (Web/Application)| | (Web/Application)|
  +------------------+ +-----------------+
                   |
          +--------+-------+
          |  Amazon RDS    |
          +----------------+

## Prerequisites

Before you begin, ensure you have the following installed on your local machine:

- [Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- An AWS account with appropriate permissions to create resources

## Setup Instructions

### 1. Clone the Repository

git clone https://github.com/srujank1995/3-Tier-Architecture.git
cd Dev-3Tier-Architecture

## Configure AWS CLI
Configure your AWS CLI with your credentials:
* aws configure
## Initialize Terraform
Initialize the Terraform environment:
* terraform init 
## Deploy Infrastructure
Plan and apply the Terraform configuration to deploy the infrastructure:
* terraform plan
* terraform apply

## File Structure

Dev-3Tier Architecture/
├── main.tf                     # Main Terraform configuration
├── outputs.tf                  # Outputs from the Terraform execution
├── variables.tf                # Variable definitions
├── scripts                     # Script for initializing web server
   ├── install_java_app.sh      # Script for deploying Java application
└── .gitignore                  # Git ignore file

## Usage
Web Layer: The web server should be accessible via the ELB's DNS name.
Application Layer: The application server runs the Java application.
Database Layer: The Amazon RDS instance hosts the database.

## Accessing the Web Server
After deployment, you can access the web server using the ELB's public DNS name, 
which will be displayed as an output of the Terraform apply command.

## Managing the Application
Ensure your Java application is correctly deployed on the application servers as per the install_java_app.sh script.

## Cleaning App
* Terraform destroy

## Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or fixes.

# Hit the Star! ⭐