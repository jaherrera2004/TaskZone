package Modelos;

import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;

public class Tareas {

    private int id;
    private String titulo;
    private String descripcion;
    private LocalDate fecha;
    private int estado;
    private Etiquetas etiqueta;
    private Categorias categoria;

    private Tareas(Builder builder) {
        this.id = builder.id;
        this.titulo = builder.titulo;
        this.descripcion = builder.descripcion;
        this.fecha = builder.fecha;
        this.estado = builder.estado;
        this.etiqueta = builder.etiqueta;
        this.categoria = builder.categoria;
    }

    public Tareas() {
    }

    public int getId() {
        return id;
    }

    public String getTitulo() {
        return titulo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public LocalDate getFecha() {
        return fecha;
    }

    public int getEstado() {
        return estado;
    }

    public void setEstado(int estado) {
        this.estado = estado;
    }

    public Etiquetas getEtiqueta() {
        return etiqueta;
    }

    public Categorias getCategoria() {
        return categoria;
    }

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public Tareas traerTarea(int id) {

        Tareas tarea = null;
        String sql = "SELECT * FROM tareas WHERE id=?";
        try {

            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

            rs = ps.executeQuery();

            if (rs.next()) {

                tarea = new Tareas.Builder()
                        .withId(rs.getInt("id"))
                        .withTitulo(rs.getString("titulo"))
                        .withDescripcion(rs.getString("descripcion"))
                        .withFecha(LocalDate.parse(rs.getString("fecha")))
                        .withEstado(rs.getInt("estado"))
                        .withEtiqueta(new Etiquetas(rs.getInt("id_etiqueta")))
                        .withCategoria(new Categorias(rs.getInt("id_categoria")))
                        .build();

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
        return tarea;
    }

    public void registrarTarea(Tareas tarea, int idUsuario) {
        String sql = "INSERT INTO tareas (id_categoria,id_usuario,titulo,descripcion,id_etiqueta,fecha,estado) values (?,?,?,?,?,?,?)";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setInt(1, tarea.getCategoria().getId());
            ps.setInt(2, idUsuario);
            ps.setString(3, tarea.getTitulo());
            ps.setString(4, tarea.getDescripcion());
            ps.setInt(5, tarea.getEtiqueta().getId());
            String fecha = tarea.getFecha().toString();
            ps.setString(6, fecha);
            ps.setInt(7, 0);

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

    public void editarTarea(Tareas tarea) {
        String sql = "UPDATE tareas SET  titulo=?, descripcion=?, id_categoria=?, id_etiqueta=?, fecha=?, estado=? WHERE id=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            ps.setString(1, tarea.getTitulo());
            ps.setString(2, tarea.getDescripcion());
            ps.setInt(3, tarea.getCategoria().getId());
            ps.setInt(4, tarea.getEtiqueta().getId());
            String fecha = tarea.getFecha().toString();
            ps.setString(5, fecha);
            ps.setInt(6, tarea.getEstado());
            ps.setInt(7, tarea.getId());

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

    public ArrayList<Tareas> traerListaTareas(int idUsuario) {

        ArrayList<Tareas> listaTareas = new ArrayList<>();
        String sql = "SELECT * FROM tareas WHERE id_usuario=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, idUsuario);
            rs = ps.executeQuery();

            while (rs.next()) {
                Tareas tarea = new Tareas.Builder()
                        .withId(rs.getInt("id"))
                        .withTitulo(rs.getString("titulo"))
                        .withDescripcion(rs.getString("descripcion"))
                        .withFecha(LocalDate.parse(rs.getString("fecha")))
                        .withEstado(rs.getInt("estado"))
                        .withEtiqueta(new Etiquetas(rs.getInt("id_etiqueta")))
                        .withCategoria(new Categorias(rs.getInt("id_categoria")))
                        .build();

                listaTareas.add(tarea);
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

        return listaTareas;
    }

    public void eliminarTarea(int id) {
        String sql = "DELETE FROM tareas WHERE id=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

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

    public void completarTarea(int id) {
        String sql = "UPDATE tareas "
                + "SET estado=1 WHERE id=?";

        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);
            ps.setInt(1, id);

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

    public static class Builder {

        private int id;
        private String titulo;
        private String descripcion;
        private LocalDate fecha;
        private int estado;
        private Etiquetas etiqueta;
        private Categorias categoria;

        public Builder() {
        }

        public Builder withId(int id) {
            this.id = id;
            return this;
        }

        public Builder withTitulo(String titulo) {
            this.titulo = titulo;
            return this;
        }

        public Builder withDescripcion(String descripcion) {
            this.descripcion = descripcion;
            return this;
        }

        public Builder withFecha(LocalDate fecha) {
            this.fecha = fecha;
            return this;
        }

        public Builder withEstado(int estado) {
            this.estado = estado;
            return this;
        }

        public Builder withEtiqueta(Etiquetas etiqueta) {
            this.etiqueta = etiqueta;
            return this;
        }

        public Builder withCategoria(Categorias categoria) {
            this.categoria = categoria;
            return this;
        }

        public Tareas build() {
            return new Tareas(this);
        }
    }
}
