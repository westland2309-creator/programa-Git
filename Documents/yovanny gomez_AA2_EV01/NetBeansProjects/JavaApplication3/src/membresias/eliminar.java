package membresias;

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

        String sql = "DELETE FROM membresias WHERE id_membresia = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Membresía eliminada correctamente!\n");

            rs = st.executeQuery("SELECT * FROM membresias");

            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE MEMBRESÍAS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Membresía   : " + rs.getInt("id_membresia"));
                    System.out.println("ID Usuario     : " + rs.getInt("id_usuario"));
                    System.out.println("Tipo Membresía : " + rs.getString("tipo_membresia"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla membresias está completamente vacía.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}