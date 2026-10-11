package evaluaciones_microbiota;

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

        // Actualizamos por ejemplo el puntaje y el nivel de la evaluación con id 1
        String sql = "UPDATE evaluaciones_microbiota SET puntaje = 95, nivel = 'Excelente' WHERE id_evaluacion = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Evaluación de microbiota actualizada correctamente!\n");

            rs = st.executeQuery("SELECT * FROM evaluaciones_microbiota");

            if (rs.next()) {
                System.out.println("--- LISTADO ACTUALIZADO DE EVALUACIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Evaluación   : " + rs.getInt("id_evaluacion"));
                    System.out.println("ID Usuario      : " + rs.getInt("id_usuario"));
                    System.out.println("Fecha           : " + rs.getDate("fecha"));
                    System.out.println("Evacuaciones    : " + rs.getInt("evacuaciones"));
                    System.out.println("Distensión      : " + rs.getString("distension"));
                    System.out.println("Estreñimiento   : " + rs.getString("estrenimiento"));
                    System.out.println("Agua            : " + rs.getString("agua"));
                    System.out.println("Frutas/Verduras : " + rs.getString("frutas_verduras"));
                    System.out.println("Fibra           : " + rs.getString("fibra"));
                    System.out.println("Fermentados     : " + rs.getString("fermentados"));
                    System.out.println("Ultraprocesados : " + rs.getString("ultraprocesados"));
                    System.out.println("Observaciones   : " + rs.getString("observaciones"));
                    System.out.println("Puntaje         : " + rs.getInt("puntaje"));
                    System.out.println("Nivel           : " + rs.getString("nivel"));
                    System.out.println("Recomendaciones : " + rs.getString("recomendaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en evaluaciones_microbiota.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}