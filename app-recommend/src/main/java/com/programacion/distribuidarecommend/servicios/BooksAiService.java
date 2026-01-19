package com.programacion.distribuidarecommend.servicios;

import com.programacion.distribuidarecommend.dtos.BookRecDto;

import java.util.List;

public interface BooksAiService {

    List<BookRecDto> recomendar(String title);
}
