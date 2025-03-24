package com.empresa.eventos.controllers;

import com.empresa.eventos.models.Evento;
import com.empresa.eventos.repositories.EventoRepository;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/eventos")
public class EventoController {

    @Autowired
    private EventoRepository eventoRepository;

    @GetMapping
    public List<Evento> getAllEventos() {
        return eventoRepository.findAll();
    }

    @GetMapping("/{id}")
    public Optional<Evento> getEventoById(@PathVariable Long id) {
        return eventoRepository.findById(id);
    }

@PostMapping
public Evento createEvento(@Valid @RequestBody Evento evento) {
    return eventoRepository.save(evento);
}

    @PutMapping("/{id}")
    public Evento updateEvento(@PathVariable Long id, @RequestBody Evento eventoDetails) {
        return eventoRepository.findById(id).map(evento -> {
            evento.setNombre(eventoDetails.getNombre());
            evento.setDescripcion(eventoDetails.getDescripcion());
            evento.setPrecio(eventoDetails.getPrecio());
            evento.setFechaInicio(eventoDetails.getFechaInicio());
            evento.setFechaFin(eventoDetails.getFechaFin());
            evento.setInstalacion(eventoDetails.getInstalacion());
            evento.setOrganizadores(eventoDetails.getOrganizadores());
            return eventoRepository.save(evento);
        }).orElseThrow(() -> new RuntimeException("Evento no encontrado"));
    }
    
    @DeleteMapping("/{id}")
    public String deleteEvento(@PathVariable Long id) {
        eventoRepository.deleteById(id);
        return "Evento eliminado";
    }
}
