<%@page import="Modelos.Usuarios"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<header style="border-right: 50px;">

    <%
        Usuarios usuarioActual = (Usuarios) session.getAttribute("usuarioActual");


    %>
    <div class="navbar bg-base-100 ">
        <div class="flex-1">
            <a class="btn btn-ghost text-xl">TaskZone</a>
        </div>
        <div class="flex-none gap-2 ">

            <%                        if (usuarioActual == null) {
            %>
            <p>Mi cuenta</p>

            <%} else {%>
            <p>Hola, <%=usuarioActual.getNombre()%></p>
            <%}%>
            <div class="dropdown dropdown-end">

                <div tabindex="0" role="button" class="btn btn-ghost btn-circle">

                    <div class="w-6 full">

                        <img alt="Tailwind CSS Navbar component" src="/recursos/user-solid.svg"/>
                    </div>
                </div>
                <%                        if (usuarioActual == null) {
                %>
                <ul tabindex="0"
                    class="mt-3 z-[1] p-2 shadow menu menu-sm dropdown-content bg-base-100 rounded-box w-52">
                    <li>
                        <a href="../registrarse.jsp">
                            Crear cuenta
                        </a>
                    </li>
                    <li><a href="../registrarse.jsp">Iniciar sesión</a></li>
                </ul>

                <%
                } else {%>
                <ul tabindex="0"
                    class="mt-3 z-[1] p-2 shadow menu menu-sm dropdown-content bg-base-100 rounded-box w-52">
                 
                    <li><a>
                            <form action="SvUsuarios" method="POST">
                                <input type="hidden" name="accion"  value="cerrar">
                                <button type="submit">
                                    Cerrar sesión
                                </button>
                            </form>
                        </a></li>
                </ul>
                <%}%>
            </div>
        </div>
    </div>

</header>