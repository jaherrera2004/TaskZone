<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="Modelos.Tareas"%>
<%@page import="Modelos.Etiquetas"%>
<%@page import="Modelos.Categorias"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Controlador.Controlador"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es" data-theme="luxury">
    <%@include file="Componentes/head.jsp" %>
    <body>
        <%@include file="Componentes/header.jsp" %>
        <div class="m-10">
            <% if (usuarioActual != null) {%>
            <h1 class="text-5xl font-bold text-center">Mis tareas</h1>
            <br>
            <%@include file="FormAgregar.jsp" %>
            <br> 
            <div id="container-tareas" class="grid grid-cols-1 md:grid-cols-3 gap-20">
                <%
                    ArrayList<Tareas> listaTareas = control.traerListaTareas(usuarioActual.getId());
                    LocalDate fechaActual = LocalDate.now();
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                    for (Tareas tarea : listaTareas) {

                        LocalDate fechaLimite = tarea.getFecha();
                        String fechaFormateada = fechaLimite.format(formatter);
                        // Determinar el color del icono según la fecha límite
                        String colorIcono = "";
                        if (tarea.getEstado() == 0) { // Tarea no completada
                            if (fechaLimite.isEqual(fechaActual)) {
                                colorIcono = "#dca54c"; // amarillo
                            } else if (fechaLimite.isBefore(fechaActual)) {
                                colorIcono = "#fe0000"; // rojo
                            }
                        }
                %>
                <div class="card w-96 bg-primary text-primary-content">
                    <div class="card-body">
                        <h2 class="card-title text-center"><%=tarea.getTitulo()%></h2>
                        <p>Categoría: <%=tarea.getCategoria().getCategoria()%></p>
                        <div style="width: 320px; height: 90px;">
                            <p class="desc text-justify" ><%=tarea.getDescripcion()%></p>
                        </div>

                        <br>
                        <p>Etiqueta: <%=tarea.getEtiqueta().getEtiqueta()%> </p>
                        <p>Fecha limite: <%=fechaFormateada%>
                            <% if (!colorIcono.isEmpty()) {%>
                            <i class="fa-solid fa-circle-exclamation" style="color: <%=colorIcono%>; "></i>
                            <% }%>
                        </p>
                        
                        <p>Estado: 
                            <%=tarea.getEstado() == 0 ? "Sin completar" : "Completado"%>
                            <% if (tarea.getEstado() == 1) { %>
                            <i class="fa-solid fa-check" style="color: #11ff00;"></i>
                            <% }%>
                        </p>
                        <br>
                        <div class="card-actions justify-center">
                            <form id="formCompletar<%=tarea.getId()%>" action="SvTareas" method="POST" >
                                <input type="hidden" name="accion" value="eliminar">
                                <input type="hidden" name="idTarea" value="<%=tarea.getId()%>">
                                <button type="button" id="btn-eliminar" class="btn btn-error btn-eliminar">
                                    <i class="fa-solid fa-x" style="color: #ffffff;"></i>
                                </button>
                            </form>
                            <form action="SvTareas" method="GET">
                                <input type="hidden" name="idTarea" value="<%=tarea.getId()%>">
                                <button type="submit" class="btn btn">Ver detalles</button>
                            </form>
                            <% if (tarea.getEstado() == 0) {%>
                            <form id="formEliminar<%=tarea.getId()%>" action="SvTareas" method="POST">
                                <input type="hidden" name="accion" value="completar">
                                <input type="hidden" name="idTareaE" value="<%=tarea.getId()%>">
                                <button type="button" id="btn-completar" class="btn btn-success">
                                    <i class="fa-solid fa-check" style="color: #ffffff;"></i>
                                </button>
                            </form>
                            <% } %>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
            <% } else { %>
            <div class="alert alert-info shadow-lg mt-10">
                <div>
                    <i class="fa-solid fa-info-circle"></i>
                    <span class="text-xl">Bienvenido a Taskzone.</span>
                </div>
            </div>
            <div class="alert alert-error shadow-lg mt-10">
                <div>
                    <i class="fa-solid fa-exclamation-circle"></i>
                    <span class="text-xl">Por favor, inicia sesión para ver y gestionar tus tareas.</span>
                </div>
                <div class="flex-none">
                    <a href="registrarse.jsp" class="btn btn-outline btn-accent">Iniciar sesión</a>
                </div>
            </div>
            <% }%>
        </div>
        <%@include file="javascript.jsp" %>
        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        

    </script>
</body>
</html>
