# PAPI Bulk HTTPie examples

Search for all the properties with the origin.dev.host.jaescalo.com in the default rule
```
http --auth-type=edgegrid -a default: POST :/papi/v1/bulk/rules-search-requests-synch accountSwitchKey==1-6JHGX <<< '{"bulkSearchQuery": {"syntax": "JSONPATH", "match": "$.behaviors[?(@.name == '\''origin'\'')].options[?(@.hostname == '\''origin.dev.host.jaescalo.com'\'')].hostname"}}'
```

Now filter further by adding "bulkSearchQualifiers" and let's try filtering by CP Code. Also, because the expression is more complex it is easier to visualize and execute it in multiple lines

```
http --auth-type=edgegrid -a default: POST :/papi/v1/bulk/rules-search-requests-synch \
    accountSwitchKey==1-6JHGX \
    <<< '{
        "bulkSearchQuery": {
            "syntax": "JSONPATH",
            "match": "$.behaviors[?(@.name == '\''origin'\'')].options[?(@.hostname == '\''origin.dev.host.jaescalo.com'\'')].hostname",
            "bulkSearchQualifiers": [
                "$..behaviors[?(@.name == '\''cpCode'\'' && @.options.value.id == 1503920)]"
            ]
        }
    }'
```    

[Reference Here](https://collaborate.akamai.com/confluence/display/DEVOPSHARMONY/Property+Manager+API+%28PAPI%29+Bulk+Search+Operations)