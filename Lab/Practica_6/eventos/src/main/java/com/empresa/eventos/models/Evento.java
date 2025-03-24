package com.empresa.eventos.models;

import jakarta.persistence.*;
import jakarta.validation.constraints.*;

import java.util.Date;
import java.util.List;

@Entity
@Table(name = "eventos")
public class Evento {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @NotBlank(message = "El nombre no puede estar vacío")
    private String nombre;

    @NotBlank(message = "La descripción no puede estar vacía")
    private String descripcion;

    @Positive(message = "El precio debe ser mayor a 0")
    private double precio;

    @NotNull(message = "La fecha de inicio es obligatoria")
    @Temporal(TemporalType.DATE)
    private Date fechaInicio;

    @NotNull(message = "La fecha de fin es obligatoria")
    @Temporal(TemporalType.DATE)
    private Date fechaFin;

    @ManyToOne
    @JoinColumn(name = "instalacion_id", nullable = false)
    @NotNull(message = "Debe seleccionar una instalación")
    private Instalacion instalacion;

    @ManyToMany
    @JoinTable(
        name = "evento_organizadores",
        joinColumns = @JoinColumn(name = "evento_id"),
        inverseJoinColumns = @JoinColumn(name = "organizador_cui")
    )
    @Size(min = 1, message = "Debe haber al menos un organizador")
    private List<Organizador> organizadores;

    public Evento() {}

    public Evento(String nombre, String descripcion, double precio, Date fechaInicio, Date fechaFin, Instalacion instalacion, List<Organizador> organizadores) {
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.precio = precio;
        this.fechaInicio = fechaInicio;
        this.fechaFin = fechaFin;
        this.instalacion = instalacion;
        this.organizadores = organizadores;
    }

    // Getters y Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }

    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }

    public Date getFechaInicio() { return fechaInicio; }
    public void setFechaInicio(Date fechaInicio) { this.fechaInicio = fechaInicio; }

    public Date getFechaFin() { return fechaFin; }
    public void setFechaFin(Date fechaFin) { this.fechaFin = fechaFin; }

    public Instalacion getInstalacion() { return instalacion; }
    public void setInstalacion(Instalacion instalacion) { this.instalacion = instalacion; }

    public List<Organizador> getOrganizadores() { return organizadores; }
    public void setOrganizadores(List<Organizador> organizadores) { this.organizadores = organizadores; }
}
