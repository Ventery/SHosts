#!/bin/bash
#Program:
#		Allow/deny the resolution of some domain names
#History::
#2020/11/25    HP    First release

############################################################

if [ x$host_cur == x ];then 
	hosts_cur=0           #means default file is hosts_ori
	export hosts_cur
fi
if [ x$default_ip == x ];then
	default_ip='127.0.0.1'
	export default_ip
fi

############################################################

function addfunc(){
	if [ $1 != "both" ];then
		echo "Adding $2 in /etc/hosts_$1......"
		sudo echo "$default_ip       $2" >> /etc/hosts_$1
	else 
		echo "Adding $2 in /etc/hosts_ori......"
		sudo echo "$default_ip       $2" >> /etc/hosts_ori
		echo "Adding $2 in /etc/hosts_changed......"
		sudo echo "$default_ip       $2" >> /etc/hosts_changed
	fi
	if [ $hosts_cur == 0 ]; then
		sudo cp /etc/hosts_ori /etc/hosts 
	else sudo cp /etc/host_changed /etc/hosts
	fi
	echo "Refreshed!"
}

##########################################################

echo ""
echo "*****************************************"
echo $(date)
echo "Helld! $(whoami)"
echo '$hosts_cur is '$hosts_cur'; $default_ip is '$default_ip
if [ "$1" == "open" ];then
	sudo cp /etc/hosts_changed /etc/hosts && echo "Opend!" || echo "Open failed!"
	hosts_cur=1
elif [ "$1" == "shut" ];then
    sudo cp /etc/hosts_ori /etc/hosts && echo "Shut!" || echo "Shut failed!"
	hosts_cur=0
elif [ "$1" == "add" ];then
	read -p "Please input the domain name you want to deny:" dn
	while true
	do
		read -p "Which hosts do you want to add line in? [ori|changed|both] :" chioce
		case $chioce in
			ori|changed|both)
				break
				;;
			*)
				echo "Please input again!"
				;;
		esac
	done
	while true
	do
		read -p "Add $dn in $chioce?[Yy|Nn] :" input
		case $input in
			[Yy])
				addfunc $chioce $dn $hosts_cur
				break
				;;
			[Nn])
				break
				;;
			*)
				echo "Please input again!"
				;;
		esac
	done
else echo "Please input $0 [open|shut|add]"
fi
echo "*****************************************"
echo ""
#####################################################
