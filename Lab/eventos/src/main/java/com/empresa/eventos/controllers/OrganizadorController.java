package com.empresa.eventos.controllers;

import com.empresa.eventos.models.Organizador;
import com.empresa.eventos.repositories.OrganizadorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/organizadores")
public class OrganizadorController {

    @Autowired
    private OrganizadorRepository organizadorRepository;

    @GetMapping
    public List<Organizador> getAllOrganizadores() {
        return organizadorRepository.findAll();
    }

    @GetMapping("/{id}")
    public Optional<Organizador> getOrganizadorById(@PathVariable Long id) {
        return organizadorRepository.findById(id.toString());
    }

    @PostMapping
    public Organizador createOrganizador(@RequestBody Organizador organizador) {
        return organizadorRepository.save(organizador);
    }

    @PutMapping("/{id}")
    public Organizador updateOrganizador(@PathVariable Long id, @RequestBody Organizador organizadorDetails) {
        return organizadorRepository.findById(id.toString()).map(organizador -> {
            organizador.setNombre(organizadorDetails.getNombre());
            organizador.setCorreo(organizadorDetails.getCorreo());
            return organizadorRepository.save(organizador);
        }).orElseThrow(() -> new RuntimeException("Organizador no encontrado"));
    }

    @DeleteMapping("/{id}")
    public String deleteOrganizador(@PathVariable Long id) {
        organizadorRepository.deleteById(id.toString());
        return "Organizador eliminado";
    }
}
