package promociones;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author yovanny
 */
public class editar {
    public static void main(String[] args) {
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;

        // Actualizamos la descripción y el nombre de la promoción con id_promocion = 1
        String sql = "UPDATE promociones SET nombre = 'Plan Verano DEXONEFIT 2.0', descripcion = '20% de descuento y evaluación de microbiota gratis.' WHERE id_promocion = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Promoción actualizada correctamente!\n");

            rs = st.executeQuery("SELECT * FROM promociones");

            if (rs.next()) {
                System.out.println("--- LISTADO ACTUALIZADO DE PROMOCIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Promoción   : " + rs.getInt("id_promocion"));
                    System.out.println("Nombre         : " + rs.getString("nombre"));
                    System.out.println("Descripción    : " + rs.getString("descripcion"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en promociones.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}