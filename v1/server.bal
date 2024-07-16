import ballerina/io;
import ballerina/log;
import ballerina/tcp;

configurable int port = 9000;

service on new tcp:Listener(port) {
    remote function onConnect(tcp:Caller caller) returns tcp:ConnectionService {
        io:println("client connected: ", tostr(caller));
        return new ReverseEchoService();
    }
}

service class ReverseEchoService {
    *tcp:ConnectionService;
    remote function onBytes(tcp:Caller caller, readonly & byte[] inData) returns tcp:Error? {
        io:println("received from client: \"", string:fromBytes(inData), "\"");
        byte[] outData = inData.clone();
        outData = outData.reverse();
        io:println("sending to client: \"", string:fromBytes(outData), "\"");
        check caller->writeBytes(outData);
    }

    remote function onError(tcp:Error err) {
        log:printError("ERROR", 'error = err);
    }

    remote function onClose() {
        io:println("client disconnected");
    }
}

isolated function tostr(tcp:Caller caller) returns string =>
     kv("remoteHost", caller.remoteHost) + 
     kv("remotePort", caller.remotePort) + 
     kv("localHost", caller.localHost) + 
     kv("localPort", caller.localPort) + 
     kv("id", caller.id);

isolated function kv(string key, int|string value) returns string {
    if value is int {
        return string `(${key} = ${value})`;
    }
    return string `(${key} = "${value}")`;
}
