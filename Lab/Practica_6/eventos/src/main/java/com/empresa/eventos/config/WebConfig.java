package com.empresa.eventos.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.lang.NonNull;

@Configuration
@EnableWebMvc  // Asegura que las configuraciones MVC sean aplicadas
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(@NonNull CorsRegistry registry) {
        registry.addMapping("/**")  // Aplica CORS a todas las rutas
                .allowedOrigins("http://localhost:5000")  // Permite solicitudes desde Flask
                .allowedMethods("*")  // Permite todos los métodos
                .allowedHeaders("*")  // Permite todos los encabezados
                .allowCredentials(true);  // Habilita cookies si es necesario
    }
}
