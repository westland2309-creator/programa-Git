package comunicados;

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
        
        // Datos de la promoción adaptados a las columnas reales
        String titulo = "Gran Promo Amor y Amistad y Mes de los Niños";
        String mensaje = "¡Gran promo fin de mes de amor y amistad comenzando octubre mes de niños! Trae a tu hijo y te daremos un mes gratis.";
        String fechaPublicacion = "2026-10-01";
        
        // Sentencia SQL INSERT ajustada a tus columnas
        String sql = "INSERT INTO comunicados (titulo, mensaje, fecha_publicacion) " +
                     "VALUES ('" + titulo + "', '" + mensaje + "', '" + fechaPublicacion + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Promoción de comunicado insertada correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM comunicados");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE COMUNICADOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Comunicado     : " + rs.getInt("id_comunicado"));
                    System.out.println("Título            : " + rs.getString("titulo"));
                    System.out.println("Mensaje           : " + rs.getString("mensaje"));
                    System.out.println("Fecha Publicación : " + rs.getString("fecha_publicacion"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}