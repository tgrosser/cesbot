{
    "packageExtensions": [
        {
            "type": "eddi://ai.labs.parser",
            "extensions": {
                "dictionaries": [
                    {
                        "type": "eddi://ai.labs.parser.dictionaries.integer"
                    },
                    {
                        "type": "eddi://ai.labs.parser.dictionaries.decimal"
                    },
                    {
                        "type": "eddi://ai.labs.parser.dictionaries.punctuation"
                    },
                    {
                        "type": "eddi://ai.labs.parser.dictionaries.email"
                    },
                    {
                        "type": "eddi://ai.labs.parser.dictionaries.time"
                    },
                    {
                        "type": "eddi://ai.labs.parser.dictionaries.ordinalNumber"
                    },
                    {
                        "type": "eddi://ai.labs.parser.dictionaries.regular",
                        "config": {
                            "uri": $dict
                        }
                    }
                ],
                "corrections": [
                    {
                        "type": "eddi://ai.labs.parser.corrections.stemming",
                        "config": {
                            "language": "english",
                            "lookupIfKnown": "false"
                        }
                    },
                    {
                        "type": "eddi://ai.labs.parser.corrections.levenshtein",
                        "config": {
                            "distance": "2"
                        }
                    },
                    {
                        "type": "eddi://ai.labs.parser.corrections.mergedTerms"
                    }
                ]
            },
            "config": {}
        },
        {
            "type": "eddi://ai.labs.behavior",
            "config": {
                "uri": $bhvs
            }
        },
        {
            "type": "eddi://ai.labs.httpcalls",
            "config": {
                "uri": $http
            }
        },
        {
            "type": "eddi://ai.labs.output",
            "config": {
                "uri": $otps
            }
        },
        {
            "type": "eddi://ai.labs.templating",
            "extensions": {},
            "config": {}
        }
    ]
}