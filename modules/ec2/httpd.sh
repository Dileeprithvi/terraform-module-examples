#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
echo "<h1>Terraform Web Instance Launched Successfully from Public Subnet (Module Example)!!!!!</h1>" | sudo tee /var/www/html/index.html
