package factores_riesgo;

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

        String sql = "DELETE FROM factores_riesgo WHERE id_factor_riesgo = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Factor de riesgo eliminado correctamente!\n");

            rs = st.executeQuery("SELECT * FROM factores_riesgo");

            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE FACTORES DE RIESGO ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Factor Riesgo  : " + rs.getInt("id_factor_riesgo"));
                    System.out.println("ID Usuario        : " + rs.getInt("id_usuario"));
                    System.out.println("Factor            : " + rs.getString("factor"));
                    System.out.println("Nivel             : " + rs.getString("nivel"));
                    System.out.println("Fecha Valoración  : " + rs.getDate("fecha_valoracion"));
                    System.out.println("Observaciones     : " + rs.getString("observaciones"));
                    System.out.println("Recomendaciones   : " + rs.getString("recomendaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla factores_riesgo está completamente vacía.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}