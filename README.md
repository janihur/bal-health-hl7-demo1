# Ballerina HL7 Demo #1

HL7 related Ballerina features:
* TCP client/server: [ballerina/tcp](https://central.ballerina.io/ballerina/tcp/latest)
  * [TCP service](https://ballerina.io/learn/by-example/tcp-listener/) example
  * [TCP client](https://ballerina.io/learn/by-example/tcp-client/) example
* Core HL7 V2 capabilities: [ballerinax/health.hl7v2](https://central.ballerina.io/ballerinax/health.hl7v2/latest)
* HL7 V2.3 messages: [ballerinax/health.hl7v23](https://central.ballerina.io/ballerinax/health.hl7v23/latest)

Other Ballerina features:
* [Configurability](https://ballerina.io/learn/configure-a-sample-ballerina-service/)

## v1

The basic single file TCP client and server example. The default port is `9000` but it can be set with `-Cport=<PORT>`.

Run server:
```
bal run -- v1/server.bal
```

Try the server with clients:
```
bal run v1/client.bal -- 'lorem ipsum dolor sit amet'
socat - TCP:localhost:9000
```

TCP proxy example:
```
socat -v \
 TCP4-LISTEN:8999,fork \
 TCP4:localhost:9001

bal run v1/server.bal -- -Cport=9001
bal run v1/client.bal -- -Cport=8999 'lorem ipsum dolor sit amet'
```