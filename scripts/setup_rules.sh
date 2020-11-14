#!/bin/sh

print_welcome_banner() {
    clear
    echo "+--------------------------------+"
    echo "|     PFSENSE FIREWALL RULES     |"
    echo "+--------------------------------+"
    echo "quickly setup rules using easyrule"
    echo ""
}

prompt_interface() {
    read -p "[*] Enter an Interface: " interface
    echo $interface
}

prompt_action() {
    read -p "[*] Wish to Pass/Block: " pass_block
    echo $pass_block
}

prompt_protocol() {
    read -p "[*] Enter the Protocol: " protocol
    echo $protocol
}

prompt_source_ip() {
    read -p "[*] Enter source ip: " source_ip
    echo $source_ip
}

prompt_destination_ip() {
    read -p "[*] Enter destination ip: " dest_ip
    echo $dest_ip
}

prompt_ports() {
    read -p "[*] Enter ports: " ports
    echo $ports
}

print_welcome_banner

interface="$(prompt_interface)"
action="$(prompt_action)"
protocol="$(prompt_protocol)"
src_ip="$(prompt_source_ip)"
dest_ip="$(prompt_destination_ip)"
ports="$(prompt_ports)"

echo ""

if [ $action == "pass" ]; then
    for port in $ports; do
        echo "Passing traffic from $src_ip to $dest_ip on port $port"
        if [ $interface == "wan" ]; then 
            easyrule pass wan $protocol $src_ip $dest_ip $port
        elif [ $interface == "lan"]; then
            easyrule pass lan $protocol $src_ip $dest_ip $port
        fi
    done
elif [ $action == "block" ]; then
    easyrule block $interface $src_ip
else
    echo "Action not permitted"
fi

