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
public class consultar {
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
        }catch(ClassNotFoundException ex){
            Logger.getLogger(consultar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try{
            cn = con.getConnection();
            st = cn.createStatement();
            rs = st.executeQuery("SELECT * FROM comunicados");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE COMUNICADOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Comunicado     : " + rs.getInt("id_comunicado"));
                    System.out.println("Título            : " + rs.getString("titulo"));
                    System.out.println("Mensaje           : " + rs.getString("mensaje"));
                    System.out.println("Fecha Publicación : " + rs.getString("fecha_publicacion"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en comunicados.");
            }
            
        }catch (SQLException ex){
            Logger.getLogger(consultar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
