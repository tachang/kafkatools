FROM gradle:jdk18-alpine

WORKDIR /root

RUN apk update && apk add --no-cache wget tar bash jq

RUN wget https://github.com/aws/aws-msk-iam-auth/releases/download/v1.1.4/aws-msk-iam-auth-1.1.4-all.jar

ENV KAFKA_VERSION=3.2.0
ENV KAFKA_PACKAGE=kafka_2.13-3.2.0
ENV AWS_MSK_IAM_AUTH=1.1.4

RUN wget https://downloads.apache.org/kafka/$KAFKA_VERSION/$KAFKA_PACKAGE.tgz
RUN tar -xzf $KAFKA_PACKAGE.tgz && rm -rf $KAFKA_PACKAGE.tgz

RUN mv aws-msk-iam-auth-1.1.4-all.jar /root/$KAFKA_PACKAGE/libs

COPY kafka.properties /etc

CMD ["tail", "-f", "/dev/null"]
