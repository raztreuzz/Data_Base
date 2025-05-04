package com.proyecto.sbd.eventos.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Contacto {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String tipo;  // Ej: Twitter, Instagram, etc.
    private String identificador;  // Ej: @usuario123

    @ManyToOne
    @JoinColumn(name = "organizador_cui")
    private Organizador organizador;

    @ManyToOne
    @JoinColumn(name = "asociacion_id")
    private Asociacion asociacion;
}
