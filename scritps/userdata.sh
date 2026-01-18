#!/bin/bash
echo "este es un mensaje" > /root/mensaje.txt
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
