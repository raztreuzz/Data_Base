package com.empresa.eventos.repositories;

import com.empresa.eventos.models.Instalacion;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface InstalacionRepository extends JpaRepository<Instalacion, Long> {
}
