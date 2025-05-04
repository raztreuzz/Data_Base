package com.proyecto.sbd.eventos.model;

import jakarta.persistence.*;

@Entity
public class Organizador {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String nombre;
    private String email;

    @ManyToOne
    @JoinColumn(name = "asociacion_id")
    private Asociacion asociacion;

    // Constructor vacío
    public Organizador() {}

    // Constructor con parámetros
    public Organizador(String nombre, String email) {
        this.nombre = nombre;
        this.email = email;
    }

    // Getters y Setters (incluyendo el nuevo)
    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public Asociacion getAsociacion() {
        return asociacion;
    }

    public void setAsociacion(Asociacion asociacion) {
        this.asociacion = asociacion;
    }
}