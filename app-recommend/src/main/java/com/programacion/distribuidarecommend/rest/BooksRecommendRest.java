package com.programacion.distribuidarecommend.rest;

import com.programacion.distribuidarecommend.dtos.BookRecDto;
import com.programacion.distribuidarecommend.servicios.BooksAiService;
import lombok.AllArgsConstructor;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;


@RestController
@RequestMapping(value = "/recommend")
public class BooksRecommendRest {

    private final BooksAiService booksAiService;

    public BooksRecommendRest (BooksAiService booksAiService) {
        this.booksAiService = booksAiService;
    }

    @GetMapping(produces =  MediaType.APPLICATION_JSON_VALUE)
    public List<BookRecDto> recommend(@RequestParam (name = "title")String title) {
        return booksAiService.recomendar(title);
    }
}
