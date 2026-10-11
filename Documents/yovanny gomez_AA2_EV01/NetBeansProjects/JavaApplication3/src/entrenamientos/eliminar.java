package entrenamientos;

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
        
        String sql = "DELETE FROM entrenamientos WHERE id_entrenamiento = 1";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            System.out.println("¡Entrenamiento eliminado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM entrenamientos");
            
            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE ENTRENAMIENTOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Entrenamiento : " + rs.getInt("id_entrenamiento"));
                    System.out.println("ID Usuario       : " + rs.getInt("id_usuario"));
                    System.out.println("Nombre Rutina    : " + rs.getString("nombre_rutina"));
                    System.out.println("Objetivo         : " + rs.getString("objetivo"));
                    System.out.println("Días por Semana  : " + rs.getInt("dias_por_semana"));
                    System.out.println("Ejercicios       : " + rs.getString("ejercicios"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla entrenamientos está completamente vacía.");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}