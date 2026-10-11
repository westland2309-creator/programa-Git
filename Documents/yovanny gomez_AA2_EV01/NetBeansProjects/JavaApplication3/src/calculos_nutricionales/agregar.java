package calculos_nutricionales;

import conexion.conexion;
import java.sql.Connection; 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author yovanny
 */
public class agregar {
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        // Datos ajustados a las columnas reales de tu tabla calculos_nutricionales
        int idUsuario = 1;
        String fecha = "2026-10-01";
        String sexo = "hombre";
        int edad = 33;
        double peso = 79.0;
        double estatura = 1.79;
        String actividad = "Moderada";
        String objetivo = "Definición";
        double tmb = 1750.0;
        double getEnergetico = 2400.0;
        double caloriasObjetivo = 2100.0;
        double proteina = 160.0;
        double carbohidratos = 200.0;
        double grasas = 65.0;
        
        // Sentencia SQL INSERT con todas las columnas obligatorias
        String sql = "INSERT INTO calculos_nutricionales (id_usuario, fecha, sexo, edad, peso, estatura, actividad, objetivo, tmb, get_energetico, calorias_objetivo, proteina, carbohidratos, grasas) " +
                     "VALUES (" + idUsuario + ", '" + fecha + "', '" + sexo + "', " + edad + ", " + peso + ", " + estatura + ", '" + actividad + "', '" + objetivo + "', " + tmb + ", " + getEnergetico + ", " + caloriasObjetivo + ", " + proteina + ", " + carbohidratos + ", " + grasas + ")";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Cálculo nutricional insertado correctamente!");
            
            rs = st.executeQuery("SELECT * FROM calculos_nutricionales");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE CÁLCULOS NUTRICIONALES ---");
                do {
                    System.out.println("ID: " + rs.getInt("id_calculo_nutricional") + 
                                       " | Usuario: " + rs.getInt("id_usuario") + 
                                       " | Cal. Objetivo: " + rs.getDouble("calorias_objetivo") + " kcal" +
                                       " | Proteína: " + rs.getDouble("proteina") + "g");
                } while (rs.next());
            } else {
                System.out.println("No hay registros.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}
