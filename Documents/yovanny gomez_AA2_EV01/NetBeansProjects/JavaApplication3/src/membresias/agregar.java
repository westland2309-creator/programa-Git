package membresias;

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
        String tipoMembresia = "Anual VIP";
        String fechaInicio = LocalDate.now().toString();
        String fechaVencimiento = LocalDate.now().plusYears(1).toString();
        double precio = 1200000.0;
        String estado = "Activa";
        
        String sql = "INSERT INTO membresias (id_usuario, tipo_membresia, fecha_inicio, fecha_vencimiento, precio, estado) " +
                     "VALUES (" + idUsuario + ", '" + tipoMembresia + "', '" + fechaInicio + "', '" + fechaVencimiento + "', " + precio + ", '" + estado + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Membresía agregada correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM membresias");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE MEMBRESÍAS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Membresía       : " + rs.getInt("id_membresia"));
                    System.out.println("ID Usuario         : " + rs.getInt("id_usuario"));
                    System.out.println("Tipo Membresía     : " + rs.getString("tipo_membresia"));
                    System.out.println("Fecha Inicio       : " + rs.getDate("fecha_inicio"));
                    System.out.println("Fecha Vencimiento  : " + rs.getDate("fecha_vencimiento"));
                    System.out.println("Precio             : " + rs.getDouble("precio"));
                    System.out.println("Estado             : " + rs.getString("estado"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en membresias.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}