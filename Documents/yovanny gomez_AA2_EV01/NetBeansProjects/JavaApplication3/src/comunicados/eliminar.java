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
public class eliminar {
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        // Puedes cambiar el ID del comunicado que deseas eliminar
        String sql = "DELETE FROM comunicados WHERE id_comunicado = 1";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            System.out.println("¡Comunicado eliminado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM comunicados");
            
            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE COMUNICADOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Comunicado     : " + rs.getInt("id_comunicado"));
                    System.out.println("Título            : " + rs.getString("titulo"));
                    System.out.println("Mensaje           : " + rs.getString("mensaje"));
                    System.out.println("Fecha Publicación : " + rs.getString("fecha_publicacion"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla comunicados está completamente vacía.");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
