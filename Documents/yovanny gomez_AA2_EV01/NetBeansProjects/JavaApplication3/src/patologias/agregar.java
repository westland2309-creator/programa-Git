package patologias;

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
        String patologia = "Hipertension arterial";
        String estado = "Controlada";
        String fechaDiagnostico = LocalDate.now().minusYears(2).toString();
        String observaciones = "Mantiene controles periódicos y buena respuesta al ejercicio cardiovascular.";
        
        String sql = "INSERT INTO patologias (id_usuario, patologia, estado, fecha_diagnostico, observaciones) " +
                     "VALUES (" + idUsuario + ", '" + patologia + "', '" + estado + "', '" + fechaDiagnostico + "', '" + observaciones + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Patología agregada correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM patologias");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE PATOLOGÍAS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Patología      : " + rs.getInt("id_patologia"));
                    System.out.println("ID Usuario        : " + rs.getInt("id_usuario"));
                    System.out.println("Patología         : " + rs.getString("patologia"));
                    System.out.println("Estado            : " + rs.getString("estado"));
                    System.out.println("Fecha Diagnóstico : " + rs.getDate("fecha_diagnostico"));
                    System.out.println("Observaciones     : " + rs.getString("observaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en patologias.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}