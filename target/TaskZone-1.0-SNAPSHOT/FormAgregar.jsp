<%-- 
    Document   : FormAgregar
    Created on : 21/05/2024, 12:24:57 a. m.
    Author     : jaher
--%>

<%@page import="Modelos.Etiquetas"%>
<%@page import="Controlador.Controlador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Modelos.Categorias"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="flex-none">


    <button class="btn" onclick="my_modal_3.showModal()"> <i class="fa-solid fa-circle-plus"
                                                             style="color: #dca54c;"> </i>Agregar tarea</button>


    <dialog id="my_modal_3" class="modal flex-1 justify-center">
        <div class="modal-box flex-1 justify-center">
            <form method="dialog">
                <button class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
                <br>

            </form>
            <div class="flex-1 justify-center " style="text-align: center;">

                <div class="">
                    <h1 class="text-3xl font-bold">Agregar tarea</h1>
                </div>
                <div class="card shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
                    <form action="SvTareas" method="POST" class="card-body">
                        <div class="form-control">
                            <label class="label">
                                <span class="label-text">Título</span>
                            </label>
                            <input type="hidden" name="accion" value="agregar">
                            <input type="text" name="titulo" placeholder="Título" class="input input-bordered" required />
                        </div>
                        <div class="form-control">
                            <label class="label">
                                <span class="label-text">Descripción</span>
                            </label>
                            <textarea name="descripcion" class="textarea textarea-bordered" placeholder="Descripción"></textarea>
                            </label>
                        </div>
                        <div class="form-control">
                            <select name="categoria" class="select select-bordered w-full max-w-xs">
                                <option disabled selected>Categoría</option>
                                <%
                                    Controlador control = new Controlador();
                                    ArrayList<Categorias> listaCategorias = control.traerListaCategorias();

                                    for (Categorias categoria : listaCategorias) {
                                %>
                                <option value="<%=categoria.getId()%>"><%=categoria.getCategoria()%></option>

                                <% }%>
                            </select>
                        </div>

                        <div class="form-control">
                            <select name="etiqueta" class="select select-bordered w-full max-w-xs">
                                <option disabled selected>Etiqueta</option>
                                <%

                                    ArrayList<Etiquetas> listaEtiquetas = control.traerListaEtiquetas();

                                    for (Etiquetas etiqueta : listaEtiquetas) {
                                %>
                                <option value="<%=etiqueta.getId()%>"><%=etiqueta.getEtiqueta()%></option>

                                <% }%>
                            </select>
                        </div>
                        <div class="form-control">
                            <label class="label">
                                <span class="label-text">Fecha</span>
                            </label>
                            <input name="fecha" type="date" placeholder="Fecha" class="input input-bordered" required />
                        </div>
                        <div class="form-control mt-6">
                            <button type="submit" id="btn-agregar" class="btn btn-primary">Agregar</button>
                        </div>


                    </form>
                </div>

            </div>

        </div>
    </dialog>
</div>