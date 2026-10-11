package volumen_entrenamiento;

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
        
        // IDs confirmados en tu base de datos
        int idUsuario = 2;   // Usuario Yovanny Gómez Castro
        int idEjercicio = 2; // ID de ejercicio verificado en MySQL
        
        int series = 4;
        int repeticiones = 10;
        double carga = 80.5;
        double volumenTotal = series * repeticiones * carga; 
        String fecha = LocalDate.now().toString();
        
        String sql = "INSERT INTO volumen_entrenamiento (id_usuario, id_ejercicio, series, repeticiones, carga, volumen, fecha) " +
                     "VALUES (" + idUsuario + ", " + idEjercicio + ", " + series + ", " + repeticiones + ", " + carga + ", " + volumenTotal + ", '" + fecha + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Volumen de entrenamiento agregado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM volumen_entrenamiento");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE VOLUMEN DE ENTRENAMIENTO ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Volumen    : " + rs.getInt("id_volumen"));
                    System.out.println("ID Usuario    : " + rs.getInt("id_usuario"));
                    System.out.println("ID Ejercicio  : " + rs.getInt("id_ejercicio"));
                    System.out.println("Series        : " + rs.getInt("series"));
                    System.out.println("Repeticiones  : " + rs.getInt("repeticiones"));
                    System.out.println("Carga         : " + rs.getDouble("carga"));
                    System.out.println("Volumen Total : " + rs.getDouble("volumen"));
                    System.out.println("Fecha         : " + rs.getDate("fecha"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en volumen_entrenamiento.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}