#! /bin/bash
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
mkdir -p /var/www/html/testing
sudo cd /var/www/html/testing
sudo touch index.thml
echo "<h1>Terraform Web Instance Launched Successfully from Testing (Module Example)!!!!!</h1>" | sudo tee /var/www/html/testing/index.html
