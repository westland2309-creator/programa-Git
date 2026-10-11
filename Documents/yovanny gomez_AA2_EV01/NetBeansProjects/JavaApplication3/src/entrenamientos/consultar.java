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
            rs = st.executeQuery("SELECT * FROM entrenamientos");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE ENTRENAMIENTOS ---");
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
                System.out.println("No hay registros en entrenamientos.");
            }
            
        }catch (SQLException ex){
            Logger.getLogger(consultar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}