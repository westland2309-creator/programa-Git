package factores_riesgo;

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
        String factor = "Sedentarismo previo / Sobrecarga lumbar";
        String nivel = "Moderado";
        String fechaValoracion = LocalDate.now().toString();
        String observaciones = "Requiere atención en la técnica de bisagra de cadera y biomecánica de sentadilla.";
        String recomendaciones = "Incluir trabajo de core, movilidad articular y pausas activas.";
        
        String sql = "INSERT INTO factores_riesgo (id_usuario, factor, nivel, fecha_valoracion, observaciones, recomendaciones) " +
                     "VALUES (" + idUsuario + ", '" + factor + "', '" + nivel + "', '" + fechaValoracion + "', '" + observaciones + "', '" + recomendaciones + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Factor de riesgo agregado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM factores_riesgo");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE FACTORES DE RIESGO ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Factor Riesgo  : " + rs.getInt("id_factor_riesgo"));
                    System.out.println("ID Usuario        : " + rs.getInt("id_usuario"));
                    System.out.println("Factor            : " + rs.getString("factor"));
                    System.out.println("Nivel             : " + rs.getString("nivel"));
                    System.out.println("Fecha Valoración  : " + rs.getDate("fecha_valoracion"));
                    System.out.println("Observaciones     : " + rs.getString("observaciones"));
                    System.out.println("Recomendaciones   : " + rs.getString("recomendaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en factores_riesgo.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}