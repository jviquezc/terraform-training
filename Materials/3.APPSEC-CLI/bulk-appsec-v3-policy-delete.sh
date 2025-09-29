#!/bin/bash

input_file="output.csv"

while IFS=',' read -r name prefix hostname path policy_id match_target_id; do
    # Execute match target delete command
    echo "Deleting Match Target $match_target_id"
    akamai appsec delete-match-target "$match_target_id" --config 80609 --account-key 1-6JHGX

    # Execute policy delete command
    echo "Deleting Policy ID $policy_id"
    akamai appsec delete-security-policy --config 80609 --policy "$policy_id" --account-key 1-6JHGX

done < "$input_file"