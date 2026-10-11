package promociones;

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
        
        String nombre = "Plan Verano DEXONEFIT";
        String fechaVigencia = LocalDate.now().plusMonths(2).toString();
        String descripcion = "15% de descuento en membresías trimestrales y asesoría nutricional incluida.";
        
        String sql = "INSERT INTO promociones (nombre, fecha_vigencia, descripcion) " +
                     "VALUES ('" + nombre + "', '" + fechaVigencia + "', '" + descripcion + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Promoción agregada correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM promociones");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE PROMOCIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Promoción   : " + rs.getInt("id_promocion"));
                    System.out.println("Nombre         : " + rs.getString("nombre"));
                    System.out.println("Fecha Vigencia : " + rs.getDate("fecha_vigencia"));
                    System.out.println("Descripción    : " + rs.getString("descripcion"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en promociones.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}