package promociones;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author yovanny
 */
public class consultar {
    public static void main(String[] args) {
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;

        String sql = "SELECT * FROM promociones";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            rs = st.executeQuery(sql);

            if (rs.next()) {
                System.out.println("--- LISTADO DE PROMOCIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Promoción   : " + rs.getInt("id_promocion"));
                    System.out.println("Nombre         : " + rs.getString("nombre"));
                    System.out.println("Fecha Vigencia : " + rs.getDate("fecha_vigencia"));
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