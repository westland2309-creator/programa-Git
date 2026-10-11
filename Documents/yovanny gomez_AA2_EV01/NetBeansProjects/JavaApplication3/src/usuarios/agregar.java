package usuarios;

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
        
        String nombreCompleto = "Yovanny Gómez Castro";
        String correo = "gomezyovanny205@gmail.com";
        String telefono = "3238356876";
        String tipoUsuario = "Entrenador";
        
        String sql = "INSERT INTO usuarios (nombre_completo, correo, telefono, tipo_usuario) " +
                     "VALUES ('" + nombreCompleto + "', '" + correo + "', '" + telefono + "', '" + tipoUsuario + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Usuario agregado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM usuarios");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE USUARIOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Usuario     : " + rs.getInt("id_usuario"));
                    System.out.println("Nombre Completo: " + rs.getString("nombre_completo"));
                    System.out.println("Correo         : " + rs.getString("correo"));
                    System.out.println("Teléfono       : " + rs.getString("telefono"));
                    System.out.println("Tipo Usuario   : " + rs.getString("tipo_usuario"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en usuarios.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}