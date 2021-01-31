# Robot Framework GAUnit Library

[![Build Status](https://travis-ci.org/VinceCabs/robotframework-gaunitlibrary.svg?branch=master)](https://travis-ci.org/VinceCabs/robotframework-gaunitlibrary)

GAUnitLibrary is a [Robot Framework](http://robotframework.org/) library to interface with [GAUnit](https://github.com/VinceCabs/GAUnit).

## Installation

Use pip:

```sh
pip install robotframework-gaunitlibrary
```

## Run your first tests (full working samples)

### Automated test with a proxy

You can use BrowserMob Proxy library to intercept Google Analytics events.

- Download **BrowserMob Proxy** [latest release](https://github.com/lightbody/browsermob-proxy/releases) (note: install [Java](https://www.oracle.com/java/technologies/javase-jre8-downloads.html)).
  - add `bin/` directory to your %PATH

- Download [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)

- Install these libraries :

    ```sh
    pip install -r requirements/samples.txt
    ```

- Run the test

    ```sh
    robot samples/home_engie_with_proxy.robot
    ```

### Launch a manual browsing session to test events

- Follow same install instructions as above.

- Run the test

    ```sh
    robot samples/manual_browsing.robot
    ```