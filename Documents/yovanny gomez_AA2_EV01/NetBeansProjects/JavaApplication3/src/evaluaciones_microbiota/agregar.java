package evaluaciones_microbiota;

import conexion.conexion;
import java.sql.Connection; 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

/**
 * @author yovanny
 */
public class agregar {
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        int idUsuario = 1;
        String fecha = LocalDate.now().toString();
        int evacuaciones = 2; // Veces al día
        String distension = "Baja";
        String estrenimiento = "No";
        String agua = "2.5 Litros";
        String frutasVerduras = "Diario (4 porciones)";
        String fibra = "Adecuada";
        String fermentados = "Diario (Kéfir de leche)";
        String ultraprocesados = "Ocasional";
        String observaciones = "Excelente tolerancia al kéfir y buena digestión post-entreno.";
        int puntaje = 90;
        String nivel = "Saludable";
        String recomendaciones = "Mantener consumo de fermentados, hidratación y aporte de fibra.";
        
        // Usamos comillas invertidas `estreñimiento` para blindar la eñe ante MySQL
        String sql = "INSERT INTO evaluaciones_microbiota (id_usuario, fecha, evacuaciones, distension, `estrenimiento`, agua, frutas_verduras, fibra, fermentados, ultraprocesados, observaciones, puntaje, nivel, recomendaciones) " +
                     "VALUES (" + idUsuario + ", '" + fecha + "', " + evacuaciones + ", '" + distension + "', '" + estrenimiento + "', '" + agua + "', '" + frutasVerduras + "', '" + fibra + "', '" + fermentados + "', '" + ultraprocesados + "', '" + observaciones + "', " + puntaje + ", '" + nivel + "', '" + recomendaciones + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Evaluación de microbiota insertada correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM evaluaciones_microbiota");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE EVALUACIONES DE MICROBIOTA ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Evaluación   : " + rs.getInt("id_evaluacion"));
                    System.out.println("ID Usuario      : " + rs.getInt("id_usuario"));
                    System.out.println("Fecha           : " + rs.getDate("fecha"));
                    System.out.println("Evacuaciones    : " + rs.getInt("evacuaciones"));
                    System.out.println("Distensión      : " + rs.getString("distension"));
                    System.out.println("Estreñimiento   : " + rs.getString("estreñimiento"));
                    System.out.println("Agua            : " + rs.getString("agua"));
                    System.out.println("Frutas/Verduras : " + rs.getString("frutas_verduras"));
                    System.out.println("Fibra           : " + rs.getString("fibra"));
                    System.out.println("Fermentados     : " + rs.getString("fermentados"));
                    System.out.println("Ultraprocesados : " + rs.getString("ultraprocesados"));
                    System.out.println("Observaciones   : " + rs.getString("observaciones"));
                    System.out.println("Puntaje         : " + rs.getInt("puntaje"));
                    System.out.println("Nivel           : " + rs.getString("nivel"));
                    System.out.println("Recomendaciones : " + rs.getString("recomendaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en evaluaciones_microbiota.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}