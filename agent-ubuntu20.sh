#!/bin/sh

mkdir /home/zabbixagent

cd /home/zabbixagent

##############################################
# Download & Install zabbix agent for Ubuntu #
##############################################

wget https://repo.zabbix.com/zabbix/5.4/ubuntu/pool/main/z/zabbix/zabbix-agent_5.4.9-1+ubuntu20.04_amd64.deb

dpkg -i zabbix-agent_5.4.9-1+ubuntu20.04_amd64.deb

cd /etc/zabbix/

################################
## Configure the zabbix agent ##
################################

sed -i 's/127.0.0.1/prod-zabbix-lk.wso2.com/g' zabbix_agentd.conf

HOSTNAME=$(cat /etc/hostname)

sed -i 's/Zabbix server/'"$HOSTNAME"'/g' zabbix_agentd.conf

###########################################
## Edit localhost file & start the agent ##
###########################################

echo "192.168.8.95 prod-zabbix-lk.wso2.com" >> /etc/hosts

systemctl restart zabbix-agent

systemctl enable zabbix-agent

echo "PLEASE MAKE SURE THE HOSTNAME IS CORRECT IN GOOGLE SHEET. INSTALLATION SUCCESSFULL"
