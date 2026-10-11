package lesiones;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author yovanny
 */
public class editar {
    public static void main(String[] args) {
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;

        String sql = "UPDATE lesiones SET estado = 'Recuperado', dolor = 'Ninguno' WHERE id_lesion = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Lesión actualizada correctamente!\n");

            rs = st.executeQuery("SELECT * FROM lesiones");

            if (rs.next()) {
                System.out.println("--- LISTADO ACTUALIZADO DE LESIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Lesión       : " + rs.getInt("id_lesion"));
                    System.out.println("ID Usuario      : " + rs.getInt("id_usuario"));
                    System.out.println("Zona Afectada   : " + rs.getString("zona_afectada"));
                    System.out.println("Tipo de Lesión  : " + rs.getString("tipo_lesion"));
                    System.out.println("Fecha           : " + rs.getDate("fecha"));
                    System.out.println("Dolor           : " + rs.getString("dolor"));
                    System.out.println("Estado          : " + rs.getString("estado"));
                    System.out.println("Restricciones   : " + rs.getString("restricciones"));
                    System.out.println("Observaciones   : " + rs.getString("observaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en lesiones.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}