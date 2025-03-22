package com.empresa.eventos.controllers;

import com.empresa.eventos.models.Instalacion;
import com.empresa.eventos.repositories.InstalacionRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Optional;

@RestController
@RequestMapping("/instalaciones")
public class InstalacionController {

    @Autowired
    private InstalacionRepository instalacionRepository;

    @GetMapping
    public List<Instalacion> getAllInstalaciones() {
        return instalacionRepository.findAll();
    }

    @GetMapping("/{id}")
    public Optional<Instalacion> getInstalacionById(@PathVariable Long id) {
        return instalacionRepository.findById(id);
    }

    @PostMapping
    public Instalacion createInstalacion(@RequestBody Instalacion instalacion) {
        return instalacionRepository.save(instalacion);
    }

    @PutMapping("/{id}")
    public Instalacion updateInstalacion(@PathVariable Long id, @RequestBody Instalacion instalacionDetails) {
        return instalacionRepository.findById(id).map(instalacion -> {
            instalacion.setNombre(instalacionDetails.getNombre());
            instalacion.setUbicacion(instalacionDetails.getUbicacion());
            return instalacionRepository.save(instalacion);
        }).orElseThrow(() -> new RuntimeException("Instalación no encontrada"));
    }

    @DeleteMapping("/{id}")
    public String deleteInstalacion(@PathVariable Long id) {
        instalacionRepository.deleteById(id);
        return "Instalación eliminada";
    }
}

