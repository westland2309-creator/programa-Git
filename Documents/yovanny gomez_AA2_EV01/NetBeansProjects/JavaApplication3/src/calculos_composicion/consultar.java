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
            
            // Consultamos tu tabla real calculos_composicion
            rs = st.executeQuery("SELECT * FROM calculos_composicion");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE CÁLCULOS DE COMPOSICIÓN ---");
                do {
                    // Imprimimos los campos adaptados a la estructura de tu base de datos
                    System.out.println("ID Cálculo: " + rs.getInt("id_calculo") + 
                                       " | Usuario: " + rs.getInt("id_usuario") + 
                                       " | Fecha: " + rs.getString("fecha") + 
                                       " | Peso: " + rs.getDouble("peso") + " kg" + 
                                       " | Estatura: " + rs.getDouble("estatura") + " m" + 
                                       " | IMC: " + rs.getDouble("imc"));
                } while (rs.next());
            } else {
                System.out.println("No hay registros en la tabla calculos_composicion.");
            }
            
        }catch (SQLException ex){
            Logger.getLogger(consultar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
