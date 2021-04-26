#!/usr/bin/env fish

function fatal
    echo "$argv"
    exit 1
end

set -q DOMAIN; and set -lx DOMAIN "$DOMAIN"; or fatal "No DOMAIN set in env"
set -q SECRET_KEY; and set -lx PB_SEC_KEY "$SECRET_KEY"; or fatal "No SECRET_KEY in env"
set -q API_KEY; and set -lx PB_API_KEY "$API_KEY"; or fatal "No API_KEY in env"

set AUTH "{\"secretapikey\":\"$PB_SEC_KEY\",\"apikey\":\"$PB_API_KEY\"}"
set CURRENT_IP (curl -sSL -X POST -d $AUTH https://porkbun.com/api/json/v3/ping | jq -r '.yourIp')

echo "Current IP: $CURRENT_IP"
set PING_ENDPOINT https://porkbun.com/api/json/v3/dns/retrieve/$DOMAIN
echo "Checking for existing DNS Records for $DOMAIN from $PING_ENDPOINT"
set DOMAIN_ENTRIES (curl -sSL -X POST -d $AUTH $PING_ENDPOINT | jq -c -r '.records[]')

for entry in $DOMAIN_ENTRIES
    set record_id (echo $entry | jq -r '.id')
    set record_name (echo $entry | jq -r '.name' | string replace -r ".?$DOMAIN" '')
    set record_type (echo $entry | jq -r '.type')
    set record_content (echo $entry | jq -r '.content')

    echo "--> record_id      : $record_id"
    echo "--> record_name    : $record_name"
    echo "--> record_type    : $record_type"
    echo "--> record_content : $record_content"

    if test "$record_type" = A
        if test "$record_content" = "$CURRENT_IP"
            echo "Record [$record_name] is up to date"
        else
            echo "Updating [$record_name] content to $CURRENT_IP"
            set payload (jq -n -c --arg secretapikey $PB_SEC_KEY \
                --arg apikey $PB_API_KEY \
                --arg name $record_name \
                --arg type $record_type \
                --arg content $CURRENT_IP \
                '{"apikey"       : $apikey,
                  "secretapikey" : $secretapikey,
                  "name"         : $name,
                  "content"      : $content,
                  "ttl"          : "600",
                  "type"         : $type}'
            )
            set porkbun_endpoint https://porkbun.com/api/json/v3/dns/edit/$DOMAIN/$record_id
            echo "Edit Payload($porkbun_endpoint): $payload"
            set update_result (curl -sSL -X POST -d $payload $porkbun_endpoint | jq -r ".status")
            if test "$update_result" = SUCCESS
                echo "Successfully updated $record_name"
            end
        end
    end
end
