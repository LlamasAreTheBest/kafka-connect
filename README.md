<!--
*** Thanks for checking out this README Template. If you have a suggestion that would
*** make this better, please fork the repo and create a pull request or simply open
*** an issue with the tag "enhancement".
*** Thanks again! Now go create something AMAZING! :D
***
***
***
*** To avoid retyping too much info. Do a search and replace for the following:
*** github_username, repo_name, twitter_handle, email
-->





<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!-- PROJECT LOGO -->
<br />
<p align="center">
<!--
  <a href="https://github.com/LlamasAreTheBest/kafka-connect">
    <img src="images/logo.png" alt="Logo" width="80" height="80"> 
  </a>
-->
  <h2>Kafka Connect for Docker</h2>

  <p>
    Kafka Connect for Docker. This image is based on <a href="https://github.com/wurstmeister/kafka-docker">wurstmeister/kafka</a>. 
    <ul>
    <li>llamasarethebest/kafka-connect:amd64-snapshot</li>
    <li>llamsarethebest/kafka-connect:arm64-snapshot</li>
    </ul>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Docker compose](#docker-compose)
  * [Docker run](#docker-run)
* [Contributing](#contributing)
* [License](#license)



<!-- ABOUT THE PROJECT -->
## About The Project

This Projekt started due to the need of an MQTT-Connector for Kafka. (This will be avalible soon on my GitHubPage). 
Some files are based on the image from [wurstmeister/kafka](https://github.com/wurstmeister/kafka-docker). 

I build the kafka-connect image on two systems. Checkout the tags to get the architecture you need, [here!](https://hub.docker.com/repository/docker/maltepfennig/kafka-connect/tags?page=1&ordering=last_updated)

### Built With

* arm64 - Raspberry Pi 4B - 4GB - Ubuntu focal
* amd64 - Windows 10


<!-- GETTING STARTED -->
## Getting Started

First you need Docker ;) You can finde an installation guide online: [Install Docker](https://docs.docker.com/get-docker/)



### Docker compose

If you use Docker compose create a file *docker-compose.yml*. You can copy the file below or check out the *[docker-compose.yml](https://github.com/LlamasAreTheBest/kafka-connect/blob/main/docker-compose.yml)* file in this repository. You definetly need __KAFKA_BOOTSTRAP_SERVERS__  and __KAFKA_GROUP_ID__ as environment varibles.

To configure the *connect-distributed.properties* you can create enviroment varibles. Use **KAFKA_** as prefix and add the desired value in __Kapital Latters__. In Example:
```
KAFKA_KEY_CONVERTER: org.apache.kafka.connect.storage.StringConverter
```
will result the following output in the *connect-distributed.properties* file:
```
key.converter=org.apache.kafka.connect.storage.StringConverter
```

To add your own Kafka Connectors collect them in a folder and mount it. Make sure that the __KAFKA_PLUGIN_PATH__ matches the destination folder of the mounted volume.

```sh
version: '3'

services: 
    connect1:
        image: maltepfennig/kafka-connect:SNAPSHOT
        container_name: kafka_connect1
        ports:
            - "8083:8083"
        environment: 
            KAFKA_BOOTSTRAP_SERVERS: <ip-address>:<port>,<ip-address2>:<port2>,<...
            KAFKA_GROUP_ID: connect-cluster
            KAFKA_PLUGIN_PATH: /opt/connectors
            KAFKA_STATUS_STORAGE_PARTITIONS: 2
            KAFKA_STATUS_STORAGE_REPLICATION_FACTOR: 3
        volumes: 
            - .\connectors:/opt/connectors:ro
```


### Docker run

To make it simple, create an *conf.env*-File an attach it to the docker run command. In the file you definetly need __KAFKA_BOOTSTRAP_SERVERS__  and __KAFKA_GROUP_ID__ as environment varibles. To find more commands for the file checkout [Docker compose](#docker-compose).

Example of *[conf.env](https://github.com/LlamasAreTheBest/kafka-connect/blob/main/conf.env)* file:
```
KAFKA_BOOTSTRAP_SERVERS=<ip-address1>:<port1>,<ip-address2>:<port2>,...
KAFKA_GROUP_ID=connect-cluster
KAFKA_PLUGIN_PATH=/opt/connectors
```

To attach Kafka Connectors mount a volume with all desired connectors inside. Make sure the destination volume matches with the __KAFKA_PLUGIN_PATH__ in the *conf.env* file.

```
docker run -p 8083:8083 --volume /home/pi/kafka-connect/connectors:/opt/connectors:ro --env-file conf.env llamasarethebest/kafka-connect:arm64_snapshot
```


<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to be learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<!-- LICENSE -->
## License

Distributed under the Apache License 2.0. See `LICENSE` for more information.




<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/LlamasAreTheBest/kafka-connect.svg?style=flat-square
[contributors-url]: https://github.com/LlamasAreTheBest/kafka-connect/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/LlamasAreTheBest/kafka-connect.svg?style=flat-square
[forks-url]: https://github.com/LlamasAreTheBest/kafka-connect/network/members
[stars-shield]: https://img.shields.io/github/stars/LlamasAreTheBest/kafka-connect.svg?style=flat-square
[stars-url]: https://github.com/LlamasAreTheBest/kafka-connect/stargazers
[issues-shield]: https://img.shields.io/github/issues/LlamasAreTheBest/kafka-connect.svg?style=flat-square
[issues-url]: https://github.com/LlamasAreTheBest/kafka-connect/issues
[license-shield]: https://img.shields.io/github/license/LlamasAreTheBest/kafka-connect.svg?style=flat-square
[license-url]: https://github.com/LlamasAreTheBest/kafka-connect/blob/main/LICENSE
[product-screenshot]: images/screenshot.png
