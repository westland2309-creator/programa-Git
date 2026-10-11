/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package calculos_composicion;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author yovanny
 */
public class eliminar {
    
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        // Sentencia SQL para eliminar todos los registros de la tabla
        String sql = "DELETE FROM calculos_composicion";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            
            // Ejecutamos la eliminación masiva
            st.executeUpdate(sql);
            System.out.println("¡Todos los registros han sido eliminados correctamente!\n");
            
            // Consultamos la tabla para verificar su estado actual
            rs = st.executeQuery("SELECT * FROM calculos_composicion");
            
            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES ---");
                do {
                    System.out.println("ID Cálculo: " + rs.getInt("id_calculo") + 
                                       " | Usuario: " + rs.getInt("id_usuario") + 
                                       " | Peso: " + rs.getDouble("peso") + " kg");
                } while (rs.next());
            } else {
                System.out.println("La tabla calculos_composicion ahora está completamente vacía.");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
