# Robot Framework GAUnit Library

GAUnitLibrary is a [Robot Framework](http://robotframework.org/) library to interface with [GAUnit](https://pypi.org/project/gaunit/).

## Installation

```sh
pip3 install robotframework-gaunitlibrary  # Linux
pip install robotframework-gaunitlibrary  # Windows
```

## Run your first tests (full working samples)

### Automated test with a proxy

We can use BrowserMob Proxy library to intercept Google Analytics events.

- Download **BrowserMob Proxy** [latest release](https://github.com/lightbody/browsermob-proxy/releases) (note: install [Java](https://www.oracle.com/java/technologies/javase-jre8-downloads.html)).
  - add `bin/` directory to your %PATH

- Download [ChromeDriver](https://sites.google.com/a/chromium.org/chromedriver/downloads)

- Install these libraries :

    ```sh
    pip install -r samples/requirements.txt
    ```

- Run the test

    ```sh
    robot samples/home_engie_with_proxy.robot
    ```

### Automated test with Performance Log (Chrome only)

Intercept GA events without a proxy. More details [here](https://github.com/VinceCabs/GAUnit#automated-test-with-performance-log-chrome-only)

```sh
robot samples/home_engie_with_perf_log.robot
```
