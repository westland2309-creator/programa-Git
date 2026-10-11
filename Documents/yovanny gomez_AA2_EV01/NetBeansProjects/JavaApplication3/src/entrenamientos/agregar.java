package entrenamientos;

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
        
        int idUsuario = 1;
        String nombreRutina = "Rutina Hipertrofia Cuádriceps";
        String objetivo = "Ganancia muscular";
        int diasPorSemana = 4;
        String ejercicios = "Sentadilla hack péndulo, Prensa, Extensiones";
        
        String sql = "INSERT INTO entrenamientos (id_usuario, nombre_rutina, objetivo, dias_por_semana, ejercicios) " +
                     "VALUES (" + idUsuario + ", '" + nombreRutina + "', '" + objetivo + "', " + diasPorSemana + ", '" + ejercicios + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Entrenamiento insertado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM entrenamientos");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE ENTRENAMIENTOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Entrenamiento : " + rs.getInt("id_entrenamiento"));
                    System.out.println("ID Usuario       : " + rs.getInt("id_usuario"));
                    System.out.println("Nombre Rutina    : " + rs.getString("nombre_rutina"));
                    System.out.println("Objetivo         : " + rs.getString("objetivo"));
                    System.out.println("Días por Semana  : " + rs.getInt("dias_por_semana"));
                    System.out.println("Ejercicios       : " + rs.getString("ejercicios"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en entrenamientos.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}