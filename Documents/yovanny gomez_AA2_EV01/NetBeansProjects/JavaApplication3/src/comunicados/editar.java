package comunicados;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * @author yovanny
 */
public class editar {
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        int idEditar = 1; // ID del comunicado que deseas actualizar
        String nuevoTitulo = "Especial Mes de Brujas";
        String nuevoMensaje = "¡Llegó el mes de brujas! Inscríbete este mes y llévate 15 días totalmente gratis en tu membresía.";
        String nuevaFecha = "2026-10-01";
        
        // Sentencia SQL UPDATE adaptada a tus columnas
        String sql = "UPDATE comunicados SET titulo = '" + nuevoTitulo + "', mensaje = '" + nuevoMensaje + "', fecha_publicacion = '" + nuevaFecha + "' WHERE id_comunicado = " + idEditar;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            Logger.getLogger(editar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            System.out.println("¡Comunicado actualizado correctamente con la promo del mes de brujas!\n");
            
            rs = st.executeQuery("SELECT * FROM comunicados");
            
            if (rs.next()) {
                System.out.println("--- LISTADO ACTUALIZADO DE COMUNICADOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Comunicado     : " + rs.getInt("id_comunicado"));
                    System.out.println("Título            : " + rs.getString("titulo"));
                    System.out.println("Mensaje           : " + rs.getString("mensaje"));
                    System.out.println("Fecha Publicación : " + rs.getString("fecha_publicacion"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros.");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(editar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
