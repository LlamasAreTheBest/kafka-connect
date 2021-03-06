# for amd64
FROM openjdk:8u212-jre-alpine

# for arm64
#FROM arm64v8/openjdk:8u201-jdk-alpine 

ARG kafka_version=2.6.0
ARG scala_version=2.13
ARG glibc_version=2.31-r0
ARG vcs_ref=unspecified
ARG build_date=unspecified

LABEL org.label-schema.name="kafka-connect" \
      org.label-schema.description="Apache Kafka Connect" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.vcs-url="https://github.com/LlamasAreTheBest/MQTT-Connector-for-Kafka" \
      org.label-schema.vcs-ref="${vcs_ref}" \
      org.label-schema.version="${scala_version}_${kafka_version}" \
      org.label-schema.schema-version="1.0" \
      maintainer="LlamasAreTheBest"

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka \
    GLIBC_VERSION=$glibc_version

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY download-kafka.sh versions.sh start-kafka-connect.sh /tmp/

RUN apk add --no-cache bash curl jq docker \
    && chmod a+x /tmp/*.sh \
    && mv /tmp/versions.sh /tmp/start-kafka-connect.sh /usr/bin \
    && sync && /tmp/download-kafka.sh \
    && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
    && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} \
    && rm /tmp/* \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk \
    && apk add --no-cache --allow-untrusted glibc-${GLIBC_VERSION}.apk \
    && rm glibc-${GLIBC_VERSION}.apk

VOLUME ["/kafka"]

CMD ["start-kafka-connect.sh"]


