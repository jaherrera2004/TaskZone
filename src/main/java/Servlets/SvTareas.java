/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Servlets;

import Controlador.Controlador;
import Modelos.Categorias;
import Modelos.Etiquetas;
import Modelos.SesionActual;
import Modelos.Tareas;
import Modelos.Usuarios;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDate;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "SvTareas", urlPatterns = {"/SvTareas"})
public class SvTareas extends HttpServlet {

    Controlador control = new Controlador();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SvTareas</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SvTareas at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String idTarea = request.getParameter("idTarea");

        HttpSession misession = request.getSession();
        misession.setAttribute("idTareaActual", idTarea); // Corregido a idTareaActual

        response.sendRedirect("tdetalle.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        String accion = request.getParameter("accion");

        switch (accion) {
            case "agregar":

                String titulo = request.getParameter("titulo");
                String descripcion = request.getParameter("descripcion");

                String categoriaStr = request.getParameter("categoria");
                int idCategoria = Integer.parseInt(categoriaStr);
                Categorias categoria = new Categorias(idCategoria);

                String etiquetaStr = request.getParameter("etiqueta");
                int idEtiqueta = Integer.parseInt(etiquetaStr);
                Etiquetas etiqueta = new Etiquetas(idEtiqueta);

                String fechaStr = request.getParameter("fecha");
                LocalDate fecha = LocalDate.parse(fechaStr);

                Tareas tarea = new Tareas.Builder()
                        .withTitulo(titulo)
                        .withDescripcion(descripcion)
                        .withFecha(fecha)
                        .withEtiqueta(etiqueta)
                        .withCategoria(categoria)
                        .build();

                Usuarios usuarioActual = SesionActual.getInstance().getUsuarioActual();
                control.registrarTarea(tarea, usuarioActual.getId());
                response.sendRedirect("index.jsp");
                break;
            case "eliminar":

                int idTarea = Integer.parseInt(request.getParameter("idTarea"));
                control.eliminarTarea(idTarea);
                response.sendRedirect("index.jsp");
                break;

            case "completar":
                int idTareaE = Integer.parseInt(request.getParameter("idTareaE"));
                control.completarTarea(idTareaE);
                response.sendRedirect("index.jsp");
                break;

            case "editar":

                int id = Integer.parseInt(request.getParameter("id"));
                String titulo2 = request.getParameter("titulo");
                String descripcion2 = request.getParameter("descripcion");

                String categoriaStr2 = request.getParameter("categoria");
                
                
                int idCategoria2 = Integer.parseInt(categoriaStr2);
                Categorias categoria2 = new Categorias(idCategoria2);
                
              
                
                String etiquetaStr2 = request.getParameter("etiqueta");
                int idEtiqueta2 = Integer.parseInt(etiquetaStr2);
                Etiquetas etiqueta2 = new Etiquetas(idEtiqueta2);

                String fechaStr2 = request.getParameter("fecha");
                LocalDate fecha2 = LocalDate.parse(fechaStr2);

                Tareas tarea2 = new Tareas.Builder()
                        .withId(id)
                        .withTitulo(titulo2)
                        .withDescripcion(descripcion2)
                        .withFecha(fecha2)
                        .withEtiqueta(etiqueta2)
                        .withCategoria(categoria2)
                        .build();

                control.editarTarea(tarea2);
                response.sendRedirect("tdetalle.jsp");
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
