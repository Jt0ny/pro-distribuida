package com.programacion.distribuidarecommend.servicios;


import com.programacion.distribuidarecommend.dtos.BookRecDto;
import org.springframework.ai.chat.client.ChatClient;
import org.springframework.core.ParameterizedTypeReference;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BooksAiServiceIml  implements BooksAiService {

    public final ChatClient chatClient;

    public BooksAiServiceIml(ChatClient.Builder builder) {
        this.chatClient = builder.build();
    }

    public List<BookRecDto> recomendar(String title) {
        String promptText = """
                Recomienda 2 libros para alguien que le interesa {titulo}.
                
                Devuelve exclusivamente un json con el siguiente formato:
                [
                    \\{
                        "titulo": "..",
                        "isbn": "...",
                        "editorial": "...",
                        "descripcion": "..."
                    }
                ]
                No incluyas ningun texto alternativo o adicional fuera del json.
                """;

        return chatClient.prompt()
                .user(userSpec -> userSpec
                        .text(promptText).param("titulo", title))
                .call()
                .entity(new ParameterizedTypeReference<List<BookRecDto>>() {
                });
    }
}
