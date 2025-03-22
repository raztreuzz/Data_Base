package com.empresa.eventos.models;

import jakarta.persistence.*;
import java.util.List;

@Entity
@Table(name = "organizadores")
public class Organizador {
    @Id
    private String cui; // Clave primaria

    private String nombre;
    private String apellidos;
    private String correo;
    private String telefono;

    @ElementCollection
    private List<String> contactos; // Redes sociales

    public Organizador() {}

    public Organizador(String cui, String nombre, String apellidos, String correo, String telefono, List<String> contactos) {
        this.cui = cui;
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.correo = correo;
        this.telefono = telefono;
        this.contactos = contactos;
    }

    // Getters y Setters
    public String getCui() { return cui; }
    public void setCui(String cui) { this.cui = cui; }

    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }

    public String getApellidos() { return apellidos; }
    public void setApellidos(String apellidos) { this.apellidos = apellidos; }

    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }

    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }

    public List<String> getContactos() { return contactos; }
    public void setContactos(List<String> contactos) { this.contactos = contactos; }
}
