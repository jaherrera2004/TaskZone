package Modelos;

public class SesionActual {
    
    private static SesionActual instancia;
    private Usuarios usuarioActual;


    private SesionActual() {
    }

   
    public static SesionActual getInstance() {
        if (instancia == null) {
            instancia = new SesionActual();
        }
        return instancia;
    }

    public Usuarios getUsuarioActual() {
        return usuarioActual;
    }

    public void setUsuarioActual(Usuarios usuarioActual) {
        this.usuarioActual = usuarioActual;
    }

   
}
