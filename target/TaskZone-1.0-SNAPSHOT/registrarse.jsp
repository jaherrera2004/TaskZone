<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="es" data-theme="luxury">

    <%@include file="Componentes/head.jsp" %>

    <body>

        <%@include file="Componentes/header.jsp" %>
        <main>
            <div class="flex flex-col lg:flex-row">
                <div class="grid flex-grow h-32 card bg-base-300 rounded-box place-items-center m-5">

                    <div class="hero min-h-screen bg-base-200">
                        <div class="">
                            <h1 class="text-5xl font-bold">Iniciar sesión</h1>
                            <br>
                            <div class="card shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
                                <form action="SvUsuarios" method="GET" class="card-body">
                                    <% if (request.getAttribute("errorMessage") != null) {%>
                                    <div class="alert alert-error">
                                        <span><%= request.getAttribute("errorMessage")%></span>
                                    </div>
                                    <% } %>
                                    <div class="form-control">
                                        <label class="label">
                                            <span class="label-text">Email</span>
                                        </label>
                                        <input type="email" name="email" placeholder="Email" class="input input-bordered" required />
                                    </div>

                                    <div class="form-control">
                                        <label class="label">
                                            <span class="label-text">Contraseña</span>
                                        </label>
                                        <input type="password" name="contrasena" placeholder="Contraseña" class="input input-bordered" required />
                                    </div>

                                    <div class="form-control mt-6">
                                        <button type="submit" class="btn btn-primary">Iniciar sesión</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="divider lg:divider-horizontal"></div>

                <div class="grid flex-grow h-32 card bg-base-300 rounded-box place-items-center m-5">
                    <div id="form-registrarse" class="hero min-h-screen bg-base-200">
                        <div class="">
                            <h1 class="text-5xl font-bold">Registrarse</h1>
                            <br>
                            <% if (request.getAttribute("errorMessageRegister") != null) {%>
                            <div class="alert alert-error">
                                <span><%= request.getAttribute("errorMessageRegister")%></span>
                            </div>
                            <% }%>
                            <div class="card shrink-0 w-full max-w-sm shadow-2xl bg-base-100">
                                <form action="SvUsuarios" method="POST" class="card-body">
                                    <input type="hidden" name="accion" value="registrarse">
                                    <div class="form-control">
                                        <label class="label">
                                            <span class="label-text">Nombre</span>
                                        </label>
                                        <input type="text" name="nombre" placeholder="Nombre" class="input input-bordered" required />
                                    </div>
                                    <div class="form-control">
                                        <label class="label">
                                            <span class="label-text">Apellido</span>
                                        </label>
                                        <input type="text" name="apellido" placeholder="Apellido" class="input input-bordered" required />
                                    </div>

                                    <div class="form-control">
                                        <label class="label">
                                            <span class="label-text">Email</span>
                                        </label>
                                        <input type="email" name="email" placeholder="Email" class="input input-bordered" required />
                                    </div>

                                    <div class="form-control">
                                        <label class="label">
                                            <span class="label-text">Contraseña</span>
                                        </label>
                                        <input type="password" name="contrasena" placeholder="Contraseña" class="input input-bordered" required />
                                    </div>
                                    <div class="form-control mt-6">
                                        <button type="submit" class="btn btn-primary">Registrarse</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </body>
</html>
