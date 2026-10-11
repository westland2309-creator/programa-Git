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
public class eliminar {
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        String sql = "DELETE FROM ejercicios WHERE id_ejercicio = 1";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            System.out.println("¡Ejercicio eliminado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM ejercicios");
            
            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE EJERCICIOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Ejercicio    : " + rs.getInt("id_ejercicio"));
                    System.out.println("Nombre          : " + rs.getString("nombre_ejercicio"));
                    System.out.println("Grupo Muscular  : " + rs.getString("grupo_muscular"));
                    System.out.println("Descripción     : " + rs.getString("descripcion"));
                    System.out.println("Dificultad      : " + rs.getString("nivel_dificultad"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla ejercicios está completamente vacía.");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}