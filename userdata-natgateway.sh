#!/bin/bash
sudo apt-get install net-tools -y
sudo apt-get install iptables-persistent -y
sudo bash -c 'echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sudo bash -c 'iptables-save > /etc/iptables/rules.v4'
sudo ifconfig eth1 10.7.1.10/24 up
sudo route add -net 10.0.0.0/8 gw 10.7.1.1
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -A FORWARD -o eth0 -i eth1 -s 10.0.0.0/8 -m conntrack --ctstate NEW -j ACCEPT
sudo iptables -A FORWARD -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
sudo iptables -t nat -F POSTROUTING
sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

# Add Inbout NAT for Web Servers
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 80 -j DNAT --to 10.7.5.20:80
sudo iptables -A FORWARD -p tcp -d 10.7.5.20 --dport 80 -j ACCEPT
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 8081 -j DNAT --to 10.10.1.20:80
sudo iptables -A FORWARD -p tcp -d 10.10.1.20 --dport 80 -j ACCEPT
sudo iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 8082 -j DNAT --to 10.20.1.20:80
sudo iptables -A FORWARD -p tcp -d 10.20.1.20 --dport 80 -j ACCEPT

# Set webservers in the hosts file
echo "10.7.5.20       web1" | sudo tee -a /etc/hosts
echo "10.10.1.20      spoke1-web1" | sudo tee -a /etc/hosts
echo "10.20.1.20      spoke2-web1" | sudo tee -a /etc/hosts

