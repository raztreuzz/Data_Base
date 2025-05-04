package com.proyecto.sbd.eventos.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {

    // Página de inicio (raíz)
    @GetMapping("/")
    public String home() {
        return "index"; // Renderiza index.html
    }

    // Página de login (ya existe, pero podemos asegurarnos de que esté mapeada) 
}