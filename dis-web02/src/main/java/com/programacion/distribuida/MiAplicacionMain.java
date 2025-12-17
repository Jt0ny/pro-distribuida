package com.programacion.distribuida;

import io.helidon.http.media.jsonb.JsonbSupport;
import io.helidon.http.media.jsonp.JsonpSupport;
import io.helidon.webserver.WebServer;
import io.helidon.webserver.http.ServerRequest;
import io.helidon.webserver.http.ServerResponse;
import jakarta.json.Json;
import jakarta.json.JsonBuilderFactory;
import jakarta.json.JsonObject;

import java.time.LocalDateTime;
import java.util.Map;


public class MiAplicacionMain {


    JsonBuilderFactory factory = Json.createBuilderFactory(Map.of());

    static void handleHola1 (ServerRequest req, ServerResponse resp) {
        var name = req.path().pathParameters().get("name");

        JsonObject obj = Json.createObjectBuilder()
                .add("name","hello"+name+" "+LocalDateTime.now())
                .add("fechaHora: ", LocalDateTime.now().toString())
                .build();


        resp.send(obj);
    }
    static void handleHola2 (ServerRequest req, ServerResponse resp) {
        var name = req.path().pathParameters().get("name");

        Persona persona = new Persona();
        persona.setName("hola: "+name);
        persona.setFechaHora(LocalDateTime.now());

        resp.send(persona);
    }
    public static void main(String[] args) {
        WebServer.builder()
                .port(8080)
                .mediaContext(it -> it.
                        mediaSupportsDiscoverServices(true)
                        .addMediaSupport(JsonpSupport.create())
                        .addMediaSupport(JsonbSupport.create()))
                .routing(routing -> routing
                        .get("/hola1/{name}", MiAplicacionMain::handleHola1)
                        .get("/hola2/{name}", MiAplicacionMain::handleHola2)
                )
                .build()
                .start();


    }
}