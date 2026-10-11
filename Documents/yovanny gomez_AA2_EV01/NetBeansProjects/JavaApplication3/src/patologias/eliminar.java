package patologias;

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

        String sql = "DELETE FROM patologias WHERE id_patologia = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Patología eliminada correctamente!\n");

            rs = st.executeQuery("SELECT * FROM patologias");

            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE PATOLOGÍAS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Patología : " + rs.getInt("id_patologia"));
                    System.out.println("ID Usuario   : " + rs.getInt("id_usuario"));
                    System.out.println("Patología    : " + rs.getString("patologia"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla patologias está completamente vacía.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}