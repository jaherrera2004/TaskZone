<%@page import="Modelos.Etiquetas"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Categorias"%>
<%@page import="Controlador.Controlador"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.time.LocalDate"%>
<%@page import="Modelos.Tareas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es" data-theme="luxury">

    <%@include file="Componentes/head.jsp" %>

    <body>

        <%@include file="Componentes/header.jsp" %>

        <div class="m-10"  style="max-width: 900px; margin: 0 auto;">
            <%
                Controlador control = new Controlador();
                String idtareaActualStr = (String) session.getAttribute("idTareaActual");

                int idTareaActual = Integer.parseInt(idtareaActualStr);
                Tareas tareaActual = control.traerTarea(idTareaActual);

                LocalDate fechaActual = LocalDate.now();
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                LocalDate fechaLimite = tareaActual.getFecha();
                String fechaFormateada = fechaLimite.format(formatter);
                // Determinar el color del icono según la fecha límite
                String colorIcono = "";
                if (tareaActual.getEstado() == 0) { // Tarea no completada
                    if (fechaLimite.isEqual(fechaActual)) {
                        colorIcono = "#dca54c"; // amarillo
                    } else if (fechaLimite.isBefore(fechaActual)) {
                        colorIcono = "#fe0000"; // rojo
                    }
                }

            %>
            <div class="hero min-h-screen bg-base-200">
                <div class="hero-content text-center">
                    <div class="max-w-md">
                        <h1 class="text-3xl"><%=tareaActual.getTitulo()%></h1>
                        <br>
                        <p>Categoría: <%=tareaActual.getCategoria().getCategoria()%></p>
                        <div style="width: 500px; height: auto">
                            <p class="py-6 text-justify">
                                <%=tareaActual.getDescripcion()%>
                            </p>
                        </div>
                        <br>
                        <p>Etiqueta: <%=tareaActual.getEtiqueta().getEtiqueta()%> </p>
                        <p>Fecha limite: <%=fechaFormateada%>
                            <% if (!colorIcono.isEmpty()) {%>
                            <i class="fa-solid fa-circle-exclamation" style="color: <%=colorIcono%>; "></i>
                            <% }%>
                        </p>

                        <p>Estado: 
                            <%=tareaActual.getEstado() == 0 ? "Sin completar" : "Completado"%>
                            <% if (tareaActual.getEstado() == 1) { %>
                            <i class="fa-solid fa-check" style="color: #11ff00;"></i>
                            <% }%>
                        </p>
                        <br>
                        <div class="card-actions justify-center">
                            <form id="formEliminar<%=tareaActual.getId()%>" action="SvTareas" method="POST" >
                                <input type="hidden" name="accion" value="eliminar">
                                <input type="hidden" name="idTarea" value="<%=tareaActual.getId()%>">
                                <button type="button" id="btnEliminar<%=tareaActual.getId()%>" class="btn btn-error btn-eliminar">
                                    <i class="fa-solid fa-x" style="color: #ffffff;"></i>
                                </button>
                            </form>
                            <button class="btn btn-info" onclick="my_modal_3.showModal()">
                                <i class="fa-solid fa-pencil" style="color: #ffffff;"></i>
                            </button>

                            <% if (tareaActual.getEstado() == 0) {%>
                            <form class="form-completar" action="SvTareas" method="POST">
                                <input type="hidden" name="accion" value="completar">
                                <input type="hidden" name="idTareaE" value="<%=tareaActual.getId()%>">
                                <button type="button" class="btn btn-success btn-completar">
                                    <i class="fa-solid fa-check" style="color: #ffffff;"></i>
                                </button>
                            </form>
                            <% }%>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <dialog id="my_modal_3" class="modal flex-1 justify-center">
            <div class="modal-box flex-1 justify-center">
                <form method="dialog">
                    <button class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2" onclick="my_modal_3.close()">✕</button>
                    <br>
                </form>
                <div class="flex-1 justify-center " style="text-align: center;">
                    <div class="">
                        <h1 class="text-3xl font-bold">Editar tarea</h1>
                    </div>
                    <div class="card shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
                        <form action="SvTareas" method="POST" class="card-body">
                            <div class="form-control">
                                <label class="label">
                                    <span class="label-text">Título</span>
                                </label>
                                <input type="hidden" name="accion" value="editar">
                                <input type="hidden" name="id" value="<%=tareaActual.getId()%>" placeholder="Título" class="input input-bordered" required />
                                <input type="text" name="titulo" value="<%=tareaActual.getTitulo()%>" placeholder="Título" class="input input-bordered" required />
                            </div>
                            <div class="form-control">
                                <label class="label">
                                    <span class="label-text">Descripción</span>
                                </label>
                                <textarea name="descripcion" class="textarea textarea-bordered" placeholder="Descripción"><%=tareaActual.getDescripcion()%></textarea>
                            </div>
                            <div class="form-control">
                                <select name="categoria" class="select select-bordered w-full max-w-xs">
                                    <option disabled>Categoría</option>
                                    <%
                                        ArrayList<Categorias> listaCategorias = control.traerListaCategorias();
                                        for (Categorias categoria : listaCategorias) {
                                            String selected = tareaActual.getCategoria().getId() == categoria.getId() ? "selected" : "";
                                    %>
                                    <option value="<%=categoria.getId()%>" <%=selected%>><%=categoria.getCategoria()%></option>
                                    <% } %>
                                </select>
                            </div>
                            <div class="form-control">
                                <select name="etiqueta" class="select select-bordered w-full max-w-xs">
                                    <option disabled>Etiqueta</option>
                                    <%
                                        ArrayList<Etiquetas> listaEtiquetas = control.traerListaEtiquetas();
                                        for (Etiquetas etiqueta : listaEtiquetas) {
                                            String selected = tareaActual.getEtiqueta().getId() == etiqueta.getId() ? "selected" : "";
                                    %>
                                    <option value="<%=etiqueta.getId()%>" <%=selected%>><%=etiqueta.getEtiqueta()%></option>
                                    <% }%>
                                </select>
                            </div>
                            <div class="form-control">
                                <label class="label">
                                    <span class="label-text">Fecha</span>
                                </label>
                                <input name="fecha" type="date" value="<%=tareaActual.getFecha()%>" class="input input-bordered" required />
                            </div>
                            <input type="hidden" name="idTarea" value="<%=tareaActual.getId()%>">
                            <div class="form-control mt-6">
                                <button type="submit" id="btn-editar" class="btn btn-primary">Editar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </dialog>

        <script src="https://cdn.tailwindcss.com"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <script>
            document.getElementById('btnEliminar<%=tareaActual.getId()%>').addEventListener('click', function (event) {
                event.preventDefault();
                Swal.fire({
                    title: "¿Seguro quieres eliminar la tarea?",
                    text: "No podrás revertir esto",
                    icon: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#d33",
                    cancelButtonColor: "#121213",
                    confirmButtonText: "Sí, ¡elimínalo!",
                    cancelButtonText: "Cancelar",
                    customClass: {
                        cancelButton: 'swal2-cancel-btn-color'
                    },
                }).then((result) => {
                    if (result.isConfirmed) {
                        document.getElementById('formEliminar<%=tareaActual.getId()%>').submit();
                    }
                });
            });

            document.querySelectorAll('.btn-completar').forEach(button => {
                button.addEventListener('click', function (event) {
                    event.preventDefault();
                    const form = this.closest('form');
                    Swal.fire({
                        title: "¡Buen trabajo!",
                        text: "Has completado la tarea",
                        icon: "success",
                    }).then((result) => {
                        if (result.isConfirmed) {
                            form.submit(); // Envía el formulario más cercano al botón clickeado
                        }
                    });
                });
            });
        </script>

    </body>

</html>
