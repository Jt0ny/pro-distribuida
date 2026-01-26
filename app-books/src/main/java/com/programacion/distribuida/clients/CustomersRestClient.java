package com.programacion.distribuida.clients;

import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import org.eclipse.microprofile.rest.client.inject.RegisterRestClient;

import java.util.List;
import java.util.Objects;

@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
@Path("/customers")
@RegisterRestClient(baseUri = "stork://customers-api")
public interface CustomersRestClient {
    @GET
    List<Object> findAll();
}
