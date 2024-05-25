package Modelos;

import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Usuarios {

    private int id;
    private String nombre;
    private String apellido;
    private String email;
    private String contrasena;
    private ArrayList<Tareas> listaTareas;

    public Usuarios(String nombre, String apellido, String email, String contrasena) {
        this.nombre = nombre;
        this.apellido = apellido;
        this.email = email;
        this.contrasena = contrasena;
    }

    public Usuarios() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContrasena() {
        return contrasena;
    }

    public ArrayList<Tareas> getListaTareas() {
        return listaTareas;
    }

    public void setListaTareas(ArrayList<Tareas> listaTareas) {
        this.listaTareas = listaTareas;
    }

    public void setContrasena(String contrasena) {
        this.contrasena = contrasena;
    }

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public void registrarUsuario(Usuarios usuario) {
        String sql = "INSERT INTO usuarios (nombre,apellido,email,contrasena) values (?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getApellido());
            ps.setString(3, usuario.getEmail());
            ps.setString(4, usuario.getContrasena());

            ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println(e);
        } finally {
            try {
                if (con != null) {
                    con.close();
                }
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

    }

    public void iniciarSesion(String email, String contrasena) {
        Usuarios usuario = traerUsuario(email);

        if (usuario.getContrasena().equals(contrasena)) {
            SesionActual sesionActual = SesionActual.getInstance();
            sesionActual.setUsuarioActual(usuario);

        }

    }

    public Usuarios traerUsuario(String email) {
        Usuarios usuario = null;
        String sql = "SELECT * FROM usuarios WHERE email=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {

                usuario = new Usuarios();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                usuario.setContrasena(rs.getString("contrasena"));

            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {

            try {
                if (con != null) {
                    con.close();
                }

                if (ps != null) {
                    ps.close();
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return usuario;
    }

    public Usuarios traerUsuario(int id) {
        Usuarios usuario = null;
        String sql = "SELECT * FROM usuarios WHERE id=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            rs = ps.executeQuery();

            if (rs.next()) {

                usuario = new Usuarios();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                usuario.setContrasena(rs.getString("contrasena"));

            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {

            try {
                if (con != null) {
                    con.close();
                }

                if (ps != null) {
                    ps.close();
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }

        return usuario;
    }

    public ArrayList<Usuarios> traerListaUsuarios() {
        ArrayList<Usuarios> listaUsuarios = new ArrayList<>();
        String sql = "SELECT * FROM usuarios";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Usuarios usuario = new Usuarios();
                usuario.setId(rs.getInt("id"));
                usuario.setNombre(rs.getString("nombre"));
                usuario.setApellido(rs.getString("apellido"));
                usuario.setEmail(rs.getString("email"));
                usuario.setContrasena(rs.getString("contrasena"));

                listaUsuarios.add(usuario);
            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {

            try {
                if (con != null) {
                    con.close();
                }

                if (ps != null) {
                    ps.close();
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return listaUsuarios;
    }

    public boolean validarCorreo(String correo) {
        ArrayList<String> listaCorreos = traerListaCorreos();
        for (String correol : listaCorreos) {
            if (correol.equals(correo)) {
                return false;
            }
        }
        return true;
    }

    private ArrayList<String> traerListaCorreos() {
        ArrayList<String> listaCorreos = new ArrayList<>();
        String sql = "SELECT email FROM usuarios";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {
                String correo = rs.getString("email");
                listaCorreos.add(correo);

            }

        } catch (SQLException e) {
            e.printStackTrace();

        } finally {

            try {
                if (con != null) {
                    con.close();
                }

                if (ps != null) {
                    ps.close();
                }

            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
        return listaCorreos;
    }
}
