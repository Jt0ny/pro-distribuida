package com.programacion.distribuida.rest;

import com.programacion.distribuida.clients.AuthorRestClient;
import com.programacion.distribuida.clients.CustomersRestClient;
import com.programacion.distribuida.dto.BookDto;
import com.programacion.distribuida.repo.BookRepository;
import io.smallrye.stork.Stork;
import io.smallrye.stork.api.Service;
import jakarta.annotation.PostConstruct;
import jakarta.enterprise.context.ApplicationScoped;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.MediaType;
import jakarta.ws.rs.core.Response;
import org.eclipse.microprofile.rest.client.inject.RestClient;
import org.modelmapper.ModelMapper;
import org.eclipse.microprofile.rest.client.RestClientBuilder;

import java.util.List;
import java.util.Map;
import java.util.concurrent.atomic.AtomicInteger;

@Path("/books")
@ApplicationScoped
@Transactional
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class BookRest {

    @Inject
    BookRepository bookRepository;

    @Inject
    ModelMapper mapper;

    @Inject
    @RestClient
    AuthorRestClient client;

    @Inject
    @RestClient
    CustomersRestClient customerClient;

    AtomicInteger index = new AtomicInteger();

    /*@PostConstruct
    void init() {
        var authorsServer ="http://localhost:8070";

        var client = RestClientBuilder.newBuilder()
                .baseUri(authorsServer)
                .build(AuthorRestClient.class);

    }*/

    @GET
    @Path("/{isbn}")
    public Response findByIsbn(@PathParam("isbn") String isbn) {

       /* var authorsServer ="http://localhost:8070";

        var client = RestClientBuilder.newBuilder()
                .baseUri(authorsServer)
                .build(AuthorRestClient.class);*/


        return bookRepository.findByIdOptional(isbn)
                .map(book -> {
                    System.out.println("Buscando autores para el libro isbn= " + isbn);
                    var authors= client.findByBook(isbn);
                    var dto = new BookDto();
                    mapper.map(book, dto);
                    dto.setAuthors(authors);
                    return Response.ok(dto).build();
                })
                .orElse(Response.status(Response.Status.NOT_FOUND).build());

        /*var obj = bookRepository.findByIdOptional(isbn);
        if (obj.isEmpty()) {
            return Response.status(Response.Status.NOT_FOUND).build();
        }

        BookDto ret =  new BookDto();

        mapper.map(obj.get(), ret);

        ret.setAuthors(
                List.of()
        );

        return Response.ok(obj.get()).build();*/
    }


    @GET
    public List<BookDto> findAll() {
         return bookRepository.streamAll()
                .map(Book->{
                    var dto = new BookDto();
                    mapper.map(Book, dto);
                    return dto;
                })
                 .map(book -> {
                     var authors = client.findByBook(book.getIsbn());
                     book.setAuthors(authors);
                     return book;
                 })
                 .toList();
    }


    @GET
    @Path("/test")
    public Response test(){

//        Stork stork = Stork.getInstance();
//        //----------imprimir lo que esta en el registro
//        Map<String, Service> services = stork.getServices();
//        services.entrySet()
//                .stream()
//                .forEach(it ->{
//                    String key = it.getKey();
//                    Service service = it.getValue();
//
//                    System.out.println("--grupo: "+key);
//
//
//                    Multi<ServiceInstance> instancias = service.getInstances()
//                            .onItem()
//                            .transformToMulti(items -> Multi.createFrom().iterable(items));
//                    instancias.subscribe()
//                            .with(item ->{
//                                System.out.println("    "+item.getHost()+"  "+item.getPort());
//                            });
//                });
        //---------buscar un servicio, seleccionar instancia, balancear
//        Service service = stork.getService("authors-api");
//        List<ServiceInstance> instancias = service.getInstances().await().indefinitely();
//
//        int curIndex= index.getAndIncrement() % instancias.size();
//        var instancia = instancias.get(curIndex);
//
//        System.out.println("Invocando authros-api: "+instancia.getHost()+":"+instancia.getPort());
        return Response.ok("ok").build();
    }

    @GET
    @Path("/test2")
    public List<Object> test2(){
        return customerClient.findAll();
    }
}



