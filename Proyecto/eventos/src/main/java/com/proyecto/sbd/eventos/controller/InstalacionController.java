package com.proyecto.sbd.eventos.controller;

import com.proyecto.sbd.eventos.model.Instalacion;
import com.proyecto.sbd.eventos.repository.InstalacionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/instalaciones")
public class InstalacionController {

    @Autowired
    private InstalacionRepository instalacionRepository;

    @GetMapping
    public List<Instalacion> listar() {
        return instalacionRepository.findAll();
    }

    @PostMapping
    public Instalacion crear(@RequestBody Instalacion instalacion) {
        return instalacionRepository.save(instalacion);
    }

    @GetMapping("/{id}")
    public Instalacion obtener(@PathVariable Long id) {
        return instalacionRepository.findById(id).orElse(null);
    }

    @PutMapping("/{id}")
    public Instalacion actualizar(@PathVariable Long id, @RequestBody Instalacion nueva) {
        return instalacionRepository.findById(id).map(instalacion -> {
            instalacion.setNombre(nueva.getNombre());
            instalacion.setUbicacion(nueva.getUbicacion());
            instalacion.setLatitud(nueva.getLatitud());
            instalacion.setLongitud(nueva.getLongitud());
            return instalacionRepository.save(instalacion);
        }).orElse(null);
    }

    @DeleteMapping("/{id}")
    public void eliminar(@PathVariable Long id) {
        instalacionRepository.deleteById(id);
    }
}
