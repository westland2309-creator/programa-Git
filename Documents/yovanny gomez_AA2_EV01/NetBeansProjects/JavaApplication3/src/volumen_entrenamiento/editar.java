package volumen_entrenamiento;

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

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = con.getConnection();
            st = cn.createStatement();
            
            // Busca automáticamente cualquier ID que exista en la tabla
            rs = st.executeQuery("SELECT id_volumen FROM volumen_entrenamiento LIMIT 1");
            
            if (rs.next()) {
                int idVolumen = rs.getInt("id_volumen");
                
                // Nuevos valores de entrenamiento actualizados
                int nuevasSeries = 5;
                int nuevasRepeticiones = 12;
                double nuevaCarga = 85.0;
                double nuevoVolumen = nuevasSeries * nuevasRepeticiones * nuevaCarga;

                String sql = "UPDATE volumen_entrenamiento SET series = " + nuevasSeries + 
                             ", repeticiones = " + nuevasRepeticiones + 
                             ", carga = " + nuevaCarga + 
                             ", volumen = " + nuevoVolumen + 
                             " WHERE id_volumen = " + idVolumen;

                int filasAfectadas = st.executeUpdate(sql);

                if (filasAfectadas > 0) {
                    System.out.println("¡Volumen de entrenamiento con ID " + idVolumen + " actualizado correctamente!");
                }
            } else {
                System.out.println("La tabla está vacía. Ejecuta primero 'agregar' para tener al menos un registro.");
            }
            
        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}