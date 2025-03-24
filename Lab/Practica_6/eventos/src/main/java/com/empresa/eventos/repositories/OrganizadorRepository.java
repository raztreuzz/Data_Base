package com.empresa.eventos.repositories;

import com.empresa.eventos.models.Organizador;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrganizadorRepository extends JpaRepository<Organizador, String> {
}
