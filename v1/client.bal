import ballerina/io;
import ballerina/tcp;

configurable int port = 9000;

public function main(string data) returns error? {
    tcp:Client 'client = check new("localhost", port);

    check 'client->writeBytes(data.toBytes());

    readonly & byte[] receivedData = check 'client->readBytes();
    io:println("received from server: \"", string:fromBytes(receivedData), "\"");

    check 'client->close();
}