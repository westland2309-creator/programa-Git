package modelo;

import java.sql.Connection;

public class TestConexion {
    public static void main(String[] args) {
        Connection con = conexion.conectar();
        if (con != null) {
            System.out.println("¡La base de datos está conectada y lista para DEXONEFIT!");
        } else {
            System.out.println("¡Atención! No se pudo establecer la conexión.");
        }
    }
}