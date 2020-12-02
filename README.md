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
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![Apache License 2.0][license-shield]][license-url]




<!-- PROJECT LOGO -->
<br />
<p align="center">
<!--
  <a href="https://github.com/LlamasAreTheBest/kafka-connect">
    <img src="images/logo.png" alt="Logo" width="80" height="80"> 
  </a>
-->
  <h3 align="center">Kafka Connect for Docker</h3>

  <p align="center">
    Start Kafka Connect via Docker image. This image is based on wurstmeister/kafka.
    <br />
    <a href="https://github.com/LlamasAreTheBest/kafka-connect"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/LlamasAreTheBest/kafka-connect">View Demo</a>
    ·
    <a href="https://github.com/LlamasAreTheBest/kafka-connect/issues">Report Bug</a>
    ·
    <a href="https://github.com/LlamasAreTheBest/kafka-connect/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
## Table of Contents

* [About the Project](#about-the-project)
  * [Built With](#built-with)
* [Getting Started](#getting-started)
  * [Prerequisites](#prerequisites)
  * [Docker compose](#installation)
* [Contributing](#contributing)
* [License](#license)



<!-- ABOUT THE PROJECT -->
## About The Project


Testesd on two System Raspberry Pi and Windows machine, checkout the different tags


### Built With

* [Raspberry Pi 4B - 4GB](arm64)
* [Windows 10](amd64)




<!-- GETTING STARTED -->
## Getting Started

Help to fill this part :)

### Prerequisites

You need Docker

### Docker compose

```sh
version: '3'

services: 
    connect1:
        image: maltepfennig/kafka-connect
        container_name: kafka_connect1
        ports:
            - "8083:8083"
        environment: 
            KAFKA_BOOTSTRAP_SERVERS: <ip-address>:<port>,<ip-address2>:<port2>
            KAFKA_GROUP_ID: connect-cluster
            KAFKA_PLUGIN_PATH: /opt/connectors
            KAFKA_STATUS_STORAGE_PARTITIONS: 2
            KAFKA_STATUS_STORAGE_REPLICATION_FACTOR: 3
        volumes: 
            - .\connectors:/opt/connectors:ro
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
[contributors-shield]: https://img.shields.io/github/contributors/LlamasAreTheBest/repo.svg?style=flat-square
[contributors-url]: https://github.com/LlamasAreTheBest/repo/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/LlamasAreTheBest/repo.svg?style=flat-square
[forks-url]: https://github.com/LlamasAreTheBest/repo/network/members
[stars-shield]: https://img.shields.io/github/stars/LlamasAreTheBest/repo.svg?style=flat-square
[stars-url]: https://github.com/LlamasAreTheBest/repo/stargazers
[issues-shield]: https://img.shields.io/github/issues/LlamasAreTheBest/repo.svg?style=flat-square
[issues-url]: https://github.com/LlamasAreTheBest/repo/issues
[license-shield]: https://img.shields.io/github/license/LlamasAreTheBest/repo.svg?style=flat-square
[license-url]: https://github.com/LlamasAreTheBest/repo/blob/master/LICENSE.txt
[product-screenshot]: images/screenshot.png
