package com.programacion.distribuida.db;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Table(name = "authors")
@Getter
@Setter
public class Author {
    @Id
    @GeneratedValue(strategy= GenerationType.IDENTITY)
    private Integer id;


    private String name;

    private Integer version;


}
