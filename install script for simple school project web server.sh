#updating the system
sudo apt update;
sudo apt -y upgrade;

#installing the webserver
sudo apt install -y apache2;
sudo apt install -y php;

#downloading the project and moving them to the right folder
git clone https://github.com/andre7455/sam-en-de-niet-sams
sudo rm /var/www/html/*
sudo mv sam-en-de-niet-sams/* /var/www/html/

#restarting the webserver
sudo systemctl restart apache2;
sudo systemctl enable apache2;
