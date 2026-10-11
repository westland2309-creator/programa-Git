package mediciones;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author yovanny
 */
public class eliminar {
    public static void main(String[] args) {
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;

        // Elimina el registro con id_medicion = 1 (puedes cambiarlo según convenga)
        String sql = "DELETE FROM mediciones WHERE id_medicion = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Medición eliminada correctamente!\n");

            rs = st.executeQuery("SELECT * FROM mediciones");

            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE MEDICIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Medición : " + rs.getInt("id_medicion"));
                    System.out.println("ID Usuario  : " + rs.getInt("id_usuario"));
                    System.out.println("Fecha       : " + rs.getDate("fecha"));
                    System.out.println("Peso (kg)   : " + rs.getDouble("peso"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla mediciones está completamente vacía.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}