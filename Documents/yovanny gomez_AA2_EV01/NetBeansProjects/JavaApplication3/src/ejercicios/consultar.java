package ejercicios;

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
            rs = st.executeQuery("SELECT * FROM ejercicios");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE EJERCICIOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Ejercicio       : " + rs.getInt("id_ejercicio"));
                    System.out.println("Nombre             : " + rs.getString("nombre"));
                    System.out.println("Grupo Muscular     : " + rs.getString("grupo_muscular"));
                    System.out.println("Patrón Movimiento  : " + rs.getString("patron_movimiento"));
                    System.out.println("Tipo Ejercicio     : " + rs.getString("tipo_ejercicio"));
                    System.out.println("Equipamiento       : " + rs.getString("equipamiento"));
                    System.out.println("Nivel              : " + rs.getString("nivel"));
                    System.out.println("Descripción Téc.   : " + rs.getString("descripcion_tecnica"));
                    System.out.println("Precauciones       : " + rs.getString("precauciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en ejercicios.");
            }
            
        }catch (SQLException ex){
            Logger.getLogger(consultar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
