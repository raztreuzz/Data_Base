package com.proyecto.sbd.eventos.repository;

import com.proyecto.sbd.eventos.model.Contacto;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ContactoRepository extends JpaRepository<Contacto, Long> {
}
