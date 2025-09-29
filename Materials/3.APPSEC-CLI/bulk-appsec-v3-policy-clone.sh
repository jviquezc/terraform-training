#!/bin/bash

input_file="policies-data.csv"
output_file="output.csv"

while IFS=',' read -r name prefix hostname path; do
    # Execute clone-policy command and capture the output
    echo "Cloning policy into $name"
    policy_id=$(akamai appsec clone-policy J43R_159644 --name "$name" --prefix "$prefix" --config 80609 --account-key 1-6JHGX)

    # Execute create-match-target command
    echo "Creating new Match Target in policy $policy_id"
    match_target_id=$(akamai appsec create-match-target --hostnames "$hostname" --paths "$path" --config 80609 --policy "$policy_id" --account-key 1-6JHGX)

    # Save the outputs to the output CSV
    echo "$name,$prefix,$hostname,$path,$policy_id,$match_target_id" > "$output_file"
done < "$input_file"