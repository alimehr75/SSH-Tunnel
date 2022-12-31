#! /bin/bash 

echo -e "\n----------- This Script Simplifies The SSH Tunnel ------------\n"
echo -e "It Provides a Scoks5 Proxy on your Local Machine"
echo -e "It Has Two Mode:"
echo -e "    1. Just One External Server in Free Land "
echo -e "    2. Both External & Internal Servers \n"

SSH_BINARY=`which ssh`
PS3="Enter A Number:"

# Informations in servers
info() {
	read -p "You'r Username in External Server [Default=root]: " EX_USER
	EX_USER="${EX_USER:-root}"
	#echo $EX_USER 

	read -p "SSH Port For External Server [Default=22]: " EX_SSH_PORT
	EX_SSH_PORT="${EX_SSH_PORT:-22}"
	#echo $EX_SSH_PORT

	read -p "A Random Port [Default=8080]: " EX_DY_PORT
	EX_DY_PORT="${EX_DY_PORT:-8080}"
	#echo $EX_DY_PORT

	read -p "External Server IP: " EX_IP
	if [ -z "$EX_IP" ];then
		echo "ERROR: You Have To Provide an IP"
		exit 1
	else
			echo $EX_IP
	fi
}

info
# A function just for one external server in free land 

external() {
	_EX_Local() {
		$SSH_BINARY -p $EX_SSH_PORT -CnfND $EX_DY_PORT  -l $EX_USER $EX_IP 
	  echo -e "\nUseage in your proxy App/Extension:"
	  echo -e "   Server: 127.0.0.1"
	  echo -e "   Port: $EX_DY_PORT"

	}

	_EX_Allow() {
		ALLOW_LOCAL_DEVICES="0.0.0.0"
		$SSH_BINARY -p $EX_SSH_PORT -CnfND $ALLOW_LOCAL_DEVICES:$EX_DY_PORT  -l $EX_USER $EX_IP 

	}

	CHOICES=("Local" "Allow Other Devices" "Quit")

	select choice in CHOICES ;
	do
		case $choice in
			"Local")
				_EX_Local()
				break
				;;
			"Allow Other Devices")
				_EX_Allow()
				break
				;;
			*)
				echo "You Need To Choose On of The Above Options."
				exit 1
	done 

	echo -e "You Need it just in your local" 
	echo -e "Or All Device will Use it for As A Proxy Server" 

}

external 





























