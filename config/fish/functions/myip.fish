function myip
    ifconfig|grep netmask|awk '{print $2}';
    curl -s https://ip.seeip.org/
end

