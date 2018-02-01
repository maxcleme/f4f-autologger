#!/bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
	-u|--username)
	F4F_USERNAME="$2"
	shift
	shift
	;;
	-p|--password)
	F4F_PASSWORD="$2"
	shift
	shift
	;;
esac
done

if [[ -z "$F4F_USERNAME" ]]
	then
		read -p 'Username:' F4F_USERNAME
fi

if [[ -z "$F4F_PASSWORD" ]]
	then
		read -sp 'Password:' F4F_PASSWORD
fi


RGX=".*name=\"form_key\".*value=\"(.*)\".*"
USER_AGENT="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.132 Safari/537.36"
RESULT=$(curl -s -c cookie-jar.txt -A "$USER_AGENT" -X POST https://www.first4figures.com/customer/account/login | grep "form_key")
if [[ $RESULT =~ $RGX ]]
	then
		FORM_KEY="${BASH_REMATCH[1]}"
	       	echo "`date`: Find form_key value : $FORM_KEY"
	        echo "`date`: Trying to connect with $F4F_USERNAME"
	        HELLO=$(curl -s -b cookie-jar.txt -L -X POST \
			-A "$USER_AGENT" \
			-F "form_key=$FORM_KEY" \
			-F "login[username]=$F4F_USERNAME" \
			-F "login[password]=$F4F_PASSWORD" \
			https://www.first4figures.com/customer/account/loginPost/ | grep "Hello")
	        if [[ -z "$HELLO" ]]
			then
				echo "`date`: Failed to login"
			else
				echo "`date`: Login successful"
		fi	
	else
		echo "`date`: Couldn't retrieve form key"
fi
