package Modelos;

import Conexion.Conexion;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class Etiquetas {

    private int id;
    private String etiqueta;

    public Etiquetas() {
    }

    public Etiquetas(int id) {
        this.id = id;
        switch (id) {
            case 1:
                this.etiqueta = "Importante";
                break;
            case 2:
                this.etiqueta = "Normal";
                break;
            case 3:
                this.etiqueta = "Opcional";
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

    public String getEtiqueta() {
        return etiqueta;
    }

    public void setEtiqueta(String etiqueta) {
        this.etiqueta = etiqueta;
    }

    Conexion cn = new Conexion();
    Connection con;
    PreparedStatement ps;
    ResultSet rs;

    public ArrayList<Etiquetas> traerListaEtiquetas() {

        ArrayList<Etiquetas> listaEtiquetas = new ArrayList<>();
        String sql = "SELECT * FROM etiquetas";
        try {
            con = cn.getConnection();
            ps = con.prepareStatement(sql);

            rs = ps.executeQuery();

            while (rs.next()) {

                Etiquetas categoria = new Etiquetas();

                categoria.setId(rs.getInt("id"));
                categoria.setEtiqueta(rs.getString("etiqueta"));

                listaEtiquetas.add(categoria);
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
        return listaEtiquetas;
    }

}
