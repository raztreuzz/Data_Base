document.addEventListener("DOMContentLoaded", function () {
    cargarEventos();
    cargarUbicaciones();
    cargarOrganizadores();
});

function cargarEventos() {
    fetch("http://localhost:8080/eventos")
        .then(response => response.json())
        .then(data => {
            const tabla = document.getElementById("tablaEventos");
            tabla.innerHTML = "";
            data.forEach(evento => {
                const fila = document.createElement("tr");
                fila.innerHTML = `
                    <td>${evento.nombre}</td>
                    <td>${new Date(evento.fechaInicio).toLocaleDateString()}</td>
                    <td>${new Date(evento.fechaFin).toLocaleDateString()}</td>
                    <td>${evento.instalacion.nombre}</td>
                    <td>${evento.precio}</td>
                    <td>${evento.descripcion}</td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="editarEvento(${evento.id})">✏️</button>
                        <button class="btn btn-danger btn-sm" onclick="eliminarEvento(${evento.id})">🗑️</button>
                    </td>
                `;
                tabla.appendChild(fila);
            });
        })
        .catch(error => console.error("Error al cargar eventos:", error));
}

function cargarUbicaciones() {
    fetch("http://localhost:8080/instalaciones")
        .then(response => response.json())
        .then(data => {
            const selectUbicacion = document.getElementById("ubicacion");
            selectUbicacion.innerHTML = "";
            data.forEach(ubicacion => {
                const option = document.createElement("option");
                option.value = ubicacion.id;
                option.textContent = ubicacion.nombre;
                selectUbicacion.appendChild(option);
            });
        })
        .catch(error => console.error("Error al cargar ubicaciones:", error));
}

function cargarOrganizadores() {
    fetch("http://localhost:8080/organizadores")
        .then(response => response.json())
        .then(data => {
            const container = document.getElementById("organizadoresContainer");
            container.innerHTML = "";
            data.forEach(org => {
                const div = document.createElement("div");
                div.classList.add("form-check");
                div.innerHTML = `
                    <input class="form-check-input" type="checkbox" name="organizadores" value="${org.cui}">
                    <label class="form-check-label">${org.nombre}</label>
                `;
                container.appendChild(div);
            });
        })
        .catch(error => console.error("Error al cargar organizadores:", error));
}

function abrirModalAgregar() {
    document.getElementById("eventoForm").reset();
    document.getElementById("eventoId").value = "";
}

function editarEvento(id) {
    fetch(`http://localhost:8080/eventos/${id}`)
        .then(response => response.json())
        .then(evento => {
            document.getElementById("eventoId").value = evento.id;
            document.getElementById("nombre").value = evento.nombre;
            document.getElementById("fechaInicio").value = new Date(evento.fechaInicio).toISOString().slice(0, 16);
            document.getElementById("fechaFin").value = new Date(evento.fechaFin).toISOString().slice(0, 16);
            document.getElementById("ubicacion").value = evento.instalacion.id;
            document.getElementById("precio").value = evento.precio;
            document.getElementById("descripcion").value = evento.descripcion;
            
            document.querySelectorAll("input[name='organizadores']").forEach(checkbox => {
                checkbox.checked = evento.organizadores.some(org => org.cui == checkbox.value);
            });

            // Abrir el modal de edición
            var modal = new bootstrap.Modal(document.getElementById("eventoModal"));
            modal.show();
        })
        .catch(error => console.error("Error al obtener evento:", error));
}


function eliminarEvento(id) {
    if (!confirm("¿Estás seguro de que deseas eliminar este evento?")) {
        return;
    }

    fetch(`http://localhost:8080/eventos/${id}`, {
        method: "DELETE",
    })
    .then(response => {
        if (!response.ok) {
            throw new Error(`Error al eliminar el evento: ${response.status}`);
        }
        return response.text();
    })
    .then(message => {
        alert(`✅ ${message}`);
        cargarEventos();
    })
    .catch(error => console.error("❌ Error al eliminar el evento:", error));
}

function guardarEvento(event) {
    event.preventDefault();
    
    const id = document.getElementById("eventoId").value;
    const nombre = document.getElementById("nombre").value;
    const fechaInicio = new Date(document.getElementById("fechaInicio").value).getTime();
    const fechaFin = new Date(document.getElementById("fechaFin").value).getTime();
    const precio = parseFloat(document.getElementById("precio").value);
    const descripcion = document.getElementById("descripcion").value;
    const ubicacionId = document.getElementById("ubicacion").value;

    const organizadoresSeleccionados = Array.from(document.querySelectorAll("input[name='organizadores']:checked"))
        .map(checkbox => ({ cui: checkbox.value }));

    const evento = {
        nombre,
        descripcion,
        precio,
        fechaInicio,
        fechaFin,
        instalacion: { id: parseInt(ubicacionId) },
        organizadores: organizadoresSeleccionados
    };

    const url = id ? `http://localhost:8080/eventos/${id}` : "http://localhost:8080/eventos";
    const method = id ? "PUT" : "POST";

    fetch(url, {
        method,
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(evento)
    })
    .then(async response => {
        if (!response.ok) {
            const errorMessage = await response.text();
            throw new Error(`HTTP ${response.status}: ${errorMessage}`);
        }
        return response.json();
    })
    .then(() => {
        cargarEventos();
        document.querySelector("#eventoModal .btn-close").click();
    })
    .catch(error => console.error("❌ Error al guardar evento:", error));
}

document.getElementById("eventoForm").addEventListener("submit", guardarEvento);
