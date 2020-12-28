expected_events = """[
    {
        "event": {
            "t": "pageview",
            "dp": "A"
        },
        "found": true
    },
    {
        "event": {
            "t": "pageview",
            "dp": "B"
        },
        "found": true
    },
    {
        "event": {
            "t": "pageview",
            "dp": "C"
        },
        "found": true
    }
]"""

actual_events = """[
    {
        "event": {
            "v": "1",
            "t": "pageview",
            "dp": "A"
        },
        "expected": true
    },
    {
        "event": {
            "v": "1",
            "t": "pageview",
            "dp": "B"
        },
        "expected": true
    },
    {
        "event": {
            "v": "1",
            "t": "pageview",
            "dp": "C"
        },
        "expected": true
    }
]"""
