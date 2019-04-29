#!/bin/bash
yum -y install cloud-utils ec2-api-tools awscli
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
REGION=$(curl -s http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
HN=$(aws ec2 describe-tags --filters "Name=resource-id,Values=$INSTANCE_ID" --region=$REGION "Name=key,Values=Name" --output=text | cut -f5)
echo "127.0.0.1 localhost.localdomain localhost4 localhost4.localdomain4 $HN $HN.${domain_name} localhost" > /etc/hosts
echo "::1 localhost localhost.localdomain localhost6 localhost6.localdomain6" >> /etc/hosts
hostnamectl set-hostname --static $HN
