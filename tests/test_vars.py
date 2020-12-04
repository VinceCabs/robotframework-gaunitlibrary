expected_events = """[
    {
        "hit": {
            "t": "pageview",
            "dp": "A"
        },
        "found": true
    },
    {
        "hit": {
            "t": "pageview",
            "dp": "B"
        },
        "found": true
    },
    {
        "hit": {
            "t": "pageview",
            "dp": "C"
        },
        "found": true
    }
]"""

actual_events = """[
    {
        "hit": {
            "v": "1",
            "t": "pageview",
            "dp": "A"
        },
        "expected": true
    },
    {
        "hit": {
            "v": "1",
            "t": "pageview",
            "dp": "B"
        },
        "expected": true
    },
    {
        "hit": {
            "v": "1",
            "t": "pageview",
            "dp": "C"
        },
        "expected": true
    }
]"""
