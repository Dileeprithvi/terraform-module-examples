#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
mkdir -p /var/www/html/develop
sudo cd /var/www/html/develop
sudo touch index.thml
echo "<h1>Terraform Web Instance Launched Successfully from Develop (Module Example)!!!!!</h1>" | sudo tee /var/www/html/develop/index.html
