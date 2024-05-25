package Modelos;

import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Categorias {

    private int id;
    private String categoria;

    public Categorias() {
    }

    public Categorias(int id) {
        this.id = id;

        switch (id) {
            case 1:
                this.categoria="Trabajo";
                break;
            case 2:
                 this.categoria="Personal";
                break;
            case 3:
                 this.categoria="Estudios";
                break;
            case 4:
                 this.categoria="Hogar";
                break;
            case 5:
                 this.categoria="Otros";
                break;
            default:
             
        }
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public ArrayList<Categorias> traerListaCategorias() {

        ArrayList<Categorias> listaCategorias = new ArrayList<>();
        String sql = "SELECT * FROM categorias";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Categorias categoria = new Categorias();

                categoria.setId(rs.getInt("id"));
                categoria.setCategoria(rs.getString("categoria"));

                listaCategorias.add(categoria);
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
        return listaCategorias;
    }

}
