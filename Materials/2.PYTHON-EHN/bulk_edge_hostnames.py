#!/usr/local/bin/python3

# DISCLAIMER:
"""
This script is for demo purposes only which provides customers with programming information regarding the Developer APIs. This script is supplied "AS IS" without any warranties and support.

We assume no responsibility or liability for the use of the script, convey no license or title under any patent or copyright.

We reserve the right to make changes in the script without notification and make no representation or warranty that such application will be suitable for the specified use without further testing or modification.

By Jaime Escalona
Akamai Solutions Architect

"""

"""
Example: 
$ python3 bulk_edge_hostnames.py -a default -c ctr_1-1NC95D -g grp_19293 -s 1-6JHGX

Where the BulkHostnames.csv contains:

pmd.jaescalo.com,prd_Adaptive_Media_Delivery
amd.jaescalo.com,prd_Adaptive_Media_Delivery

"""

import requests, json, sys, os, csv
from akamai.edgegrid import EdgeGridAuth,EdgeRc
import urllib
import argparse
from urllib.parse import urljoin


def menu():
    global args
    parser = argparse.ArgumentParser(description='Bulk Edge Hostname Creator.')
    parser.add_argument('-a', '--section', action='store', required=True, help='Section name in the .edgerc file')
    parser.add_argument('-c', '--contract', action='store', required=True, help='Contract ID')
    parser.add_argument('-g', '--group', action='store', required=True, help='Group ID')
    parser.add_argument('-s', '--switch', action='store', required=True, help='Account Switch Key')
    args = parser.parse_args()

# Initialize the authorization parameters for the API calls
def config_init():
    rc_path = os.path.expanduser('~/.edgerc')
    edgerc = EdgeRc(rc_path)
    global baseurl
    baseurl = 'https://%s' % edgerc.get(args.section, 'host')

    global session
    session = requests.Session()
    session.auth = EdgeGridAuth.from_edgerc(edgerc, args.section)


# Edge hostname creation API call
def create_edgehostname(edgehostname, product_id):
    print('\nINFO: creating Edge hostname:', edgehostname)
    headers = {'content-type': 'application/json'}
    data = {
    'productId': product_id,
    'domainPrefix': edgehostname,
    'domainSuffix': 'edgesuite.net',
    'ipVersionBehavior': 'IPV4'
    }
    # Convert the json object to a string that the API can interpret
    data = json.dumps(data)
    response = session.post(urljoin(baseurl, '/papi/v1/edgehostnames?contractId=' + args.contract + '&groupId=' + args.group + '&accountSwitchKey=' + args.switch), data=data, headers=headers)
    # Convert the response object to a string and format it
    #print(json.dumps(response.json(), indent=4, sort_keys=True))
    # Convert the response into an object for further parsing
    if response.status_code == 201:
        response = json.loads(response.text)
        response['edgeHostnameLink']
        print('INFO: successfull creation:', response)
    else:
        response = json.loads(response.text)
        print('ERROR:', response)
    return()


# Main function: initialization and reads csv file
def bulk_edgehostnames():
    config_init()

    print('INFO: requesting edge hostname creation...')

    with open('BulkHostnames.csv', encoding='utf-8-sig') as csvfile:
        readcsv = csv.reader(csvfile, delimiter=',')
        for row in readcsv:
            edgehostname = row[0]
            product_id = row[1]
            create_edgehostname(edgehostname, product_id)
    return()


# MAIN PROGRAM
if __name__ == "__main__":
    # Main Function
    menu()
    bulk_edgehostnames()