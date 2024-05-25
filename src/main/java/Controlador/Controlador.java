package Controlador;

import Modelos.Categorias;
import Modelos.Etiquetas;
import Modelos.Tareas;
import Modelos.Usuarios;
import java.util.ArrayList;

public class Controlador {
    
    Usuarios usuarioM = new Usuarios();
    Categorias categoriaM = new Categorias();
    Etiquetas etiquetaM = new Etiquetas();
    Tareas tareasM = new Tareas();
    
    public void registrarUsuario(Usuarios usuario) {
        usuarioM.registrarUsuario(usuario);
    }
    
    public void iniciarSesion(String email, String contrasena) {
        usuarioM.iniciarSesion(email, contrasena);
    }
    
    public ArrayList<Categorias> traerListaCategorias() {
        return categoriaM.traerListaCategorias();
    }
    
    public ArrayList<Etiquetas> traerListaEtiquetas() {
        return etiquetaM.traerListaEtiquetas();
    }
    
    public void registrarTarea(Tareas tarea, int idUsuario) {
        tareasM.registrarTarea(tarea, idUsuario);
    }
    
    public ArrayList<Tareas> traerListaTareas(int idUsuario) {
        return tareasM.traerListaTareas(idUsuario);
    }
    
    public Tareas traerTarea(int id) {
        return tareasM.traerTarea(id);
    }

    public void eliminarTarea(int id) {
        tareasM.eliminarTarea(id);
    }

    public void completarTarea(int id) {
        tareasM.completarTarea(id);
    }

    public void editarTarea(Tareas tarea) {
        tareasM.editarTarea(tarea);
    }
      public boolean validarCorreo(String correo) {
      return usuarioM.validarCorreo(correo);
      }
}
