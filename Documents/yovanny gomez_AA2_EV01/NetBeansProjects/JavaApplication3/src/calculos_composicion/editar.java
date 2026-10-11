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
public class editar {
    
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        // ID del cálculo que deseas modificar y los nuevos valores de prueba
        int idEditar = 1;
        double nuevoPeso = 80.5;
        double nuevoImc = 25.1;
        
        // Sentencia SQL UPDATE adaptada a tu tabla calculos_composicion
        String sql = "UPDATE calculos_composicion SET peso = " + nuevoPeso + ", imc = " + nuevoImc + " WHERE id_calculo = " + idEditar;
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            Logger.getLogger(editar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            
            // Ejecutamos la actualización
            st.executeUpdate(sql);
            System.out.println("¡Registro actualizado correctamente en la base de datos!\n");
            
            // Consultamos la tabla completa para ver los cambios reflejados
            rs = st.executeQuery("SELECT * FROM calculos_composicion");
            
            if (rs.next()) {
                System.out.println("--- LISTADO ACTUALIZADO DE CÁLCULOS ---");
                do {
                    System.out.println("ID Cálculo: " + rs.getInt("id_calculo") + 
                                       " | Usuario: " + rs.getInt("id_usuario") + 
                                       " | Peso: " + rs.getDouble("peso") + " kg" + 
                                       " | IMC: " + rs.getDouble("imc"));
                } while (rs.next());
            } else {
                System.out.println("No hay registros en la tabla.");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(editar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
