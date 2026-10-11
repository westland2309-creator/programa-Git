package mediciones;

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
        
        // Datos de prueba adaptados a tus 20 columnas de mediciones
        int idUsuario = 1;
        String fecha = LocalDate.now().toString();
        String tipoValoracion = "Antropometria y Bioimpedancia";
        double peso = 79.0;
        double estatura = 1.79;
        double grasaCorporal = 15.5;
        double masaMuscular = 63.2;
        int grasaVisceral = 5;
        int edadMetabolica = 28;
        double aguaCorporal = 60.5;
        double masaOsea = 3.2;
        double tmbTanita = 1850.0;
        double cintura = 82.0;
        double cuello = 38.0;
        double cadera = 95.0;
        double brazo = 35.0;
        double muslo = 56.0;
        double imc = 24.6;
        String observaciones = "Evaluacion inicial completa registrada correctamente.";
        
        String sql = "INSERT INTO mediciones (id_usuario, fecha, tipo_valoracion, peso, estatura, grasa_corporal, masa_muscular, grasa_visceral, edad_metabolica, agua_corporal, masa_osea, tmb_tanita, cintura, cuello, cadera, brazo, muslo, imc, observaciones) " +
                     "VALUES (" + idUsuario + ", '" + fecha + "', '" + tipoValoracion + "', " + peso + ", " + estatura + ", " + grasaCorporal + ", " + masaMuscular + ", " + grasaVisceral + ", " + edadMetabolica + ", " + aguaCorporal + ", " + masaOsea + ", " + tmbTanita + ", " + cintura + ", " + cuello + ", " + cadera + ", " + brazo + ", " + muslo + ", " + imc + ", '" + observaciones + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Medición agregada correctamente en DEXONEFIT!\n");
            
            rs = st.executeQuery("SELECT * FROM mediciones");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE MEDICIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Medición       : " + rs.getInt("id_medicion"));
                    System.out.println("ID Usuario        : " + rs.getInt("id_usuario"));
                    System.out.println("Fecha             : " + rs.getDate("fecha"));
                    System.out.println("Peso (kg)         : " + rs.getDouble("peso"));
                    System.out.println("Grasa Corporal (%) : " + rs.getDouble("grasa_corporal"));
                    System.out.println("Masa Muscular (kg): " + rs.getDouble("masa_muscular"));
                    System.out.println("IMC               : " + rs.getDouble("imc"));
                    System.out.println("Observaciones     : " + rs.getString("observaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en mediciones.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}