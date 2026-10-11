package calculos_composicion;

import conexion.conexion;
import java.sql.Connection; 
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author yovanny
 */
public class agregar {
    public static void main (String[] args){
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;
        
        // Datos completos incluyendo todas las columnas obligatorias
        int idUsuario = 1;
        String fecha = "2026-09-30";
        int sexo = 1;
        int edad = 33;
        double peso = 79.0;
        double estatura = 1.79;
        double cintura = 85.0;
        double cuello = 38.0;
        double cadera = 95.0;
        double imc = 24.6;
        String clasificacionImc = "Normal";
        double grasaCorporal = 15.5;
        double masaGrasa = 12.2;
        double masaLibreGrasa = 66.8;
        double relacionCinturaEstatura = 0.47;
        int fcMaxima = 187;
        int zona1Min = 93;
        int zona1Max = 112;
        int zona2Min = 112;
        int zona2Max = 131;
        int zona3Min = 131;
        int zona3Max = 150;
        int zona4Min = 150;
        int zona4Max = 168;
        int zona5Min = 168;
        int zona5Max = 187;
        
        // Sentencia SQL con todos los campos requeridos por la tabla
        String sql = "INSERT INTO calculos_composicion (id_usuario, fecha, sexo, edad, peso, estatura, cintura, cuello, cadera, imc, clasificacion_imc, grasa_corporal, masa_grasa, masa_libre_grasa, relacion_cintura_estatura, fc_maxima, zona1_min, zona1_max, zona2_min, zona2_max, zona3_min, zona3_max, zona4_min, zona4_max, zona5_min, zona5_max) " +
                     "VALUES (" + idUsuario + ", '" + fecha + "', " + sexo + ", " + edad + ", " + peso + ", " + estatura + ", " + cintura + ", " + cuello + ", " + cadera + ", " + imc + ", '" + clasificacionImc + "', " + grasaCorporal + ", " + masaGrasa + ", " + masaLibreGrasa + ", " + relacionCinturaEstatura + ", " + fcMaxima + ", " + zona1Min + ", " + zona1Max + ", " + zona2Min + ", " + zona2Max + ", " + zona3Min + ", " + zona3Max + ", " + zona4Min + ", " + zona4Max + ", " + zona5Min + ", " + zona5Max + ")";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Datos insertados correctamente en la base de datos!");
            
            // Consultamos los registros de la tabla para mostrarlos en consola
            rs = st.executeQuery("SELECT * FROM calculos_composicion");
            
            if (rs.next()) {
                do {
                    System.out.println("ID Cálculo: " + rs.getInt("id_calculo") + 
                                       " | Usuario: " + rs.getInt("id_usuario") + 
                                       " | Peso: " + rs.getDouble("peso") + 
                                       " | Estatura: " + rs.getDouble("estatura") +
                                       " | IMC: " + rs.getDouble("imc"));
                } while (rs.next());
            } else {
                System.out.println("No hay registros en la tabla.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}