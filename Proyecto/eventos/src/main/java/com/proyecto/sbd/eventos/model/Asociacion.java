package com.proyecto.sbd.eventos.model;

import jakarta.persistence.*;
import lombok.Data;

import java.util.List;

@Entity
@Data
public class Asociacion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nombre;
    private String acronimo;
    private String telefono;

    // Contactos de la asociación
    @OneToMany(mappedBy = "asociacion", cascade = CascadeType.ALL)
    private List<Contacto> contactos;

    @OneToMany(mappedBy = "asociacion")
    private List<Organizador> organizadores;
}
