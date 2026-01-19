package com.programacion.distribuidarecommend;


import com.programacion.distribuidarecommend.servicios.BooksAiService;
import org.springframework.ai.chat.model.ChatModel;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

@SpringBootApplication
public class AppRecommendMain {

   /*private final ChatModel chatModel;

    public AppRecommendMain(ChatModel chatModel) {
        this.chatModel = chatModel;
    }*/

    public static void main(String[] args) {
        SpringApplication.run(AppRecommendMain.class, args);
    }
    @Bean
    public CommandLineRunner run(ChatModel chatModel, BooksAiService booksAiService) {

        return (String... args) -> {
            System.out.println(chatModel);

            var res = booksAiService.recomendar("xxx");
            System.out.println("Recomendacion: " + res);
        };
    }
}
