# Sample-app

## Description
This is a sample app to buid a static website on AWS using Terraform

## Overview
This is an example to showcase how to build a simple static website and deploy it to AWS S3 using terraform IaC

- The website itself is a simple webpage which shows the text "sample website" with animation
- Website will be hosted in S3
- HTML pages are saved under sample-website folder
- Terraform files are saved under Terraform folder
- terraform.tfvars file -> stores all variables
- main.tf file -> defines the resources to be deployed

You can access the website at following URL http://sample-demo-webpage.s3-website.eu-west-2.amazonaws.com/index.html
