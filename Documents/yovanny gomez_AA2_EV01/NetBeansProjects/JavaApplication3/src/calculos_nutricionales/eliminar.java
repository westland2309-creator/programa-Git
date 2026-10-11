package calculos_nutricionales;

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
        
        // Puedes cambiar el ID a eliminar o quitar el WHERE si quieres vaciar toda la tabla
        String sql = "DELETE FROM calculos_nutricionales WHERE id_calculo_nutricional = 1";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);    
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            System.out.println("¡Registro nutricional eliminado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM calculos_nutricionales");
            
            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES (VERTICAL) ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Cálculo     : " + rs.getInt("id_calculo_nutricional"));
                    System.out.println("ID Usuario     : " + rs.getInt("id_usuario"));
                    System.out.println("Fecha          : " + rs.getString("fecha"));
                    System.out.println("Sexo           : " + rs.getString("sexo"));
                    System.out.println("Edad           : " + rs.getInt("edad"));
                    System.out.println("Peso           : " + rs.getDouble("peso") + " kg");
                    System.out.println("Estatura       : " + rs.getDouble("estatura") + " m");
                    System.out.println("Actividad      : " + rs.getString("actividad"));
                    System.out.println("Objetivo       : " + rs.getString("objetivo"));
                    System.out.println("TMB            : " + rs.getDouble("tmb") + " kcal");
                    System.out.println("Gasto Energ.   : " + rs.getDouble("get_energetico") + " kcal");
                    System.out.println("Cal. Objetivo  : " + rs.getDouble("calorias_objetivo") + " kcal");
                    System.out.println("Proteína       : " + rs.getDouble("proteina") + " g");
                    System.out.println("Carbohidratos  : " + rs.getDouble("carbohidratos") + " g");
                    System.out.println("Grasas         : " + rs.getDouble("grasas") + " g");
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla calculos_nutricionales está completamente vacía.");
            }
            
        } catch (SQLException ex) {
            Logger.getLogger(eliminar.class.getName()).log(Level.SEVERE, null, ex);
        }
    }   
}
