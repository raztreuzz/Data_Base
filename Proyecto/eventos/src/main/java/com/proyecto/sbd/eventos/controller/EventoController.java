package com.proyecto.sbd.eventos.controller;

import com.proyecto.sbd.eventos.model.Evento;
import com.proyecto.sbd.eventos.repository.EventoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/eventos")
@CrossOrigin(origins = "*") // Para que el frontend pueda acceder
public class EventoController {

    @Autowired
    private EventoRepository eventoRepository;

    @GetMapping
    public List<Evento> obtenerTodos() {
        return eventoRepository.findAll();
    }

    @PostMapping
    public Evento crear(@RequestBody Evento evento) {
        return eventoRepository.save(evento);
    }

    @PutMapping("/{id}")
    public Evento actualizar(@PathVariable Long id, @RequestBody Evento eventoActualizado) {
        return eventoRepository.findById(id).map(evento -> {
            evento.setNombre(eventoActualizado.getNombre());
            evento.setDescripcion(eventoActualizado.getDescripcion());
            evento.setFecha(eventoActualizado.getFecha());
            evento.setLugar(eventoActualizado.getLugar());
            return eventoRepository.save(evento);
        }).orElseThrow(() -> new RuntimeException("Evento no encontrado"));
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        eventoRepository.deleteById(id);
    }
}
