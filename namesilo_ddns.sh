#!/bin/bash

# test.namesilo.com

key=your.api.key                # Enter your API Key in here
host=test                       # Enter your host in here
domain=namesilo.com             # Enter your domain in here


api='https://www.namesilo.com/api'

function Update_IP()
{
    ip=`curl -s https://api.ipify.org`
    url="$api/dnsListRecords?version=1&type=xml&key=$key&domain=$domain"
    curl -s $url > /tmp/$domain.xml
    lastIP=`xmllint --xpath "string(//namesilo/reply/resource_record/value[ ../host/text() = '$host.$domain' and ../type/text() = 'A' ])" /tmp/$domain.xml`

    if [[ "$ip" != "$lastIP" ]]
    then 
        rrid=`xmllint --xpath "string(//namesilo/reply/resource_record/record_id[ ../host/text() = '$host.$domain' and ../type/text() = 'A' ])"  /tmp/$domain.xml`
        url="$api/dnsUpdateRecord?version=1&type=xml&key=$key&domain=$domain&rrid=$rrid&rrhost=$host&rrvalue=$ip&rrttl=7207"
        curl -s $url
        echo 'IPv4 Update over!'
    else
        echo 'IPv4 Not need Update!'
    fi

    rm /tmp/$domain.xml
}

function Update_IPv6()
{
    ip=`curl -6 -s https://api6.ipify.org`
    url="$api/dnsListRecords?version=1&type=xml&key=$key&domain=$domain"
    curl -s $url > /tmp/$domain.xml
    lastIP=`xmllint --xpath "string(//namesilo/reply/resource_record/value[ ../host/text() = '$host.$domain' and ../type/text() = 'AAAA' ])" /tmp/$domain.xml`

    if [[ "$ip" != "$lastIP" ]]
    then 
        rrid=`xmllint --xpath "string(//namesilo/reply/resource_record/record_id[ ../host/text() = '$host.$domain' and ../type/text() = 'AAAA' ])"  /tmp/$domain.xml`
        url="$api/dnsUpdateRecord?version=1&type=xml&key=$key&domain=$domain&rrid=$rrid&rrhost=$host&rrvalue=$ip&rrttl=7207"
        curl -s $url
        echo 'IPv6 Update over!'
    else
        echo 'IPv6 Not need Update!'
    fi

    rm /tmp/$domain.xml
}

Update_IP
Update_IPv6