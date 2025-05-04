package com.proyecto.sbd.eventos.repository;

import com.proyecto.sbd.eventos.model.Categoria;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CategoriaRepository extends JpaRepository<Categoria, Long> {
}
