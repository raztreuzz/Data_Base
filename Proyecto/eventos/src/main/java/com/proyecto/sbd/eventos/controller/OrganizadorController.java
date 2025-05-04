package com.proyecto.sbd.eventos.controller;

import com.proyecto.sbd.eventos.model.Organizador;
import com.proyecto.sbd.eventos.repository.OrganizadorRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/organizadores")
public class OrganizadorController {

    @Autowired
    private OrganizadorRepository organizadorRepository;

    @GetMapping
    public List<Organizador> getAll() {
        return organizadorRepository.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Organizador> getById(@PathVariable Long id) {
        return organizadorRepository.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PostMapping
    public Organizador create(@RequestBody Organizador organizador) {
        return organizadorRepository.save(organizador);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Organizador> update(@PathVariable Long id, @RequestBody Organizador organizadorDetails) {
        return organizadorRepository.findById(id).map(organizador -> {
            organizador.setNombre(organizadorDetails.getNombre());
            organizador.setEmail(organizadorDetails.getEmail());
            return ResponseEntity.ok(organizadorRepository.save(organizador));
        }).orElse(ResponseEntity.notFound().build());
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        if (!organizadorRepository.existsById(id)) {
            return ResponseEntity.notFound().build();
        }
        organizadorRepository.deleteById(id);
        return ResponseEntity.noContent().build();
    }
}

