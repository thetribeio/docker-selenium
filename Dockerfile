FROM ubuntu:19.04

# Install commands used for build
RUN apt-get update && apt-get install --yes curl unzip

# Install dependencies
RUN apt-get update && apt-get install --yes default-jre-headless chromium-browser firefox

# Install selenium and drivers
RUN mkdir /opt/selenium
WORKDIR /opt/selenium

RUN curl --location --output /opt/selenium/selenium-server https://selenium-release.storage.googleapis.com/3.141/selenium-server-standalone-3.141.59.jar
RUN curl --location --output /tmp/chromedriver_linux64.zip https://chromedriver.storage.googleapis.com/76.0.3809.126/chromedriver_linux64.zip && unzip /tmp/chromedriver_linux64.zip && rm /tmp/chromedriver_linux64.zip
RUN curl --location https://github.com/mozilla/geckodriver/releases/download/v0.25.0/geckodriver-v0.25.0-linux64.tar.gz | tar -xz

CMD ["java", "-Dwebdriver.chrome.driver=/opt/selenium/chromedriver", "-Dwebdriver.gecko.driver=/opt/selenium/geckodriver", "-jar", "/opt/selenium/selenium-server"]
