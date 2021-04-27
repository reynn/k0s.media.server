#!/usr/bin/env fish

function fatal
    set_color red
    echo -e "$argv" 1>&2
    set_color normal
    exit 1
end

function log
    set_color green
    echo -e "$argv" 1>&2
    set_color normal
end

set -x SCRIPT_NAME (basename (status current-filename))
log "----> $SCRIPT_NAME v0.2.0 <----"

set PB_ENDPOINT_PING 'https://porkbun.com/api/json/v3/ping'
set PB_ENDPOINT_RETRIEVE 'https://porkbun.com/api/json/v3/dns/retrieve'
set -q DOMAIN; or fatal "No DOMAIN set in env"
set -q SECRET_KEY; or fatal "No SECRET_KEY in env"
set -q API_KEY; or fatal "No API_KEY in env"

if test -n "$DEBUG"
    log "---->    Vars     <----"
    log "PB_ENDPOINT_PING     : $PB_ENDPOINT_PING"
    log "PB_ENDPOINT_RETRIEVE : $PB_ENDPOINT_RETRIEVE"
    log "DOMAIN               : $DOMAIN"
    log "SECRET_KEY           : $SECRET_KEY"
    log "API_KEY              : $API_KEY "
    log -----------------------
    log "----> Environment <----"
    env | sort
    log -----------------------
end

set CURRENT_IP (http "$PB_ENDPOINT_PING" "secretapikey=$SECRET_KEY" "apikey=$API_KEY" | jq -r '.yourIp')
test $status; or fatal "Failed to ping Porkbun servers"
log "Current IP: $CURRENT_IP"

log "Checking for existing DNS Records for $DOMAIN from $PB_ENDPOINT_RETRIEVE/$DOMAIN"
set DOMAIN_ENTRIES (http "$PB_ENDPOINT_RETRIEVE/$DOMAIN" "secretapikey=$SECRET_KEY" "apikey=$API_KEY" | jq -c -r '.records[]')

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
            set porkbun_endpoint https://porkbun.com/api/json/v3/dns/edit/$DOMAIN/$record_id
            echo "Edit Payload($porkbun_endpoint): $payload" 1>&2
            set update_result (http $porkbun_endpoint secretapikey=$SECRET_KEY apikey=$API_KEY name=$record_name type=$record_type content=$CURRENT_IP  | jq -r ".status")
            if test "$update_result" = SUCCESS
                echo "Successfully updated $record_name"
            end
        end
    end
end
