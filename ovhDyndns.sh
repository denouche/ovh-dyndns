#!/bin/bash

# DEFAULT CONFIG
LIBS="libs"
GET_IP_URL="http://ipecho.net/plain"
CURRENT_PATH="$(pwd)"


help()
{
    echo
    echo "Help: possible arguments are:"
    echo "  --domain <domain>       : the domain on which update the A record in the DNS zone"
    echo "  --subdomain <subdomain> : the subdomain for this A record"
    echo
}


requestApi()
{
    URL=$1
    METHOD=$2
    DATA=$3
    
    PARAMS=("--url")
    PARAMS+=("$URL")
    
    if [ "$METHOD" ]
    then
        PARAMS+=("--method")
        PARAMS+=("$METHOD")
    fi

    if [ "$DATA" ]
    then
        PARAMS+=("--data")
        PARAMS+=("$DATA")
    fi
    $CURRENT_PATH/$LIBS/ovhApiBashClient.sh "${PARAMS[@]}"
}

updateIp()
{
    IP=$(wget -q -O - $GET_IP_URL)
}

getJSONString()
{
    JSON="$1"
    FIELD="$2"
    RESULT=$(echo $JSON | $CURRENT_PATH/$LIBS/JSON.sh -l | grep "\[$FIELD\]" | sed -r "s/\[$FIELD\]\s+(.*)/\1/")
    echo ${RESULT:1:-1}
}

getJSONArrayLength()
{
    JSON="$1"
    echo $JSON | $CURRENT_PATH/$LIBS/JSON.sh -l | wc -l
}

parseArguments()
{
    while [ $# -gt 0 ]
    do
        case $1 in
        --domain)
            shift
            DOMAIN=$1
            ;;
        --subdomain)
            shift
            SUBDOMAIN=$1
            ;;
        esac
        shift
    done

}


main()
{
    parseArguments "$@"

    if [ -z $DOMAIN ] || [ -z $SUBDOMAIN ]
    then
        echo "No domain or subdomain given"
        help
        exit 1
    fi

    updateIp
    IDS=$(requestApi "/domain/zone/$DOMAIN/record?subDomain=$SUBDOMAIN&fieldType=A")
    
    if [ $(getJSONArrayLength $IDS) -ne 1 ]
    then
        echo "Error, multiple results found for record"
        echo "$IDS"
        exit 1
    fi

    RECORD=$(getJSONString $IDS '0')
    RECORD_IP=$(getJSONString $(requestApi "/domain/zone/$DOMAIN/record/$RECORD") '"target"')

    if [ $IP != $RECORD_IP ]
    then
        requestApi "/domain/zone/$DOMAIN/record/$RECORD" 'PUT' '{"target":"'$IP'", "ttl": 60}' > /dev/null
        requestApi "/domain/zone/$DOMAIN/refresh" 'POST' > /dev/null
    fi
}


main "$@"

