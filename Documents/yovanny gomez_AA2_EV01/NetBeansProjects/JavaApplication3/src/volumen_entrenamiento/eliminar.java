package volumen_entrenamiento;

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

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = con.getConnection();
            st = cn.createStatement();
            
            // Busca automáticamente cualquier ID disponible en la tabla para eliminarlo
            rs = st.executeQuery("SELECT id_volumen FROM volumen_entrenamiento LIMIT 1");
            
            if (rs.next()) {
                int idVolumen = rs.getInt("id_volumen");

                String sql = "DELETE FROM volumen_entrenamiento WHERE id_volumen = " + idVolumen;

                int filasAfectadas = st.executeUpdate(sql);

                if (filasAfectadas > 0) {
                    System.out.println("¡Volumen de entrenamiento con ID " + idVolumen + " eliminado correctamente!");
                }
            } else {
                System.out.println("La tabla está vacía. No hay registros para eliminar.");
            }
            
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}