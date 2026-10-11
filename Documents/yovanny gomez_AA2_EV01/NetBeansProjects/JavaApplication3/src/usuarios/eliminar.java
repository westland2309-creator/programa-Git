package usuarios;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author yovanny
 */
public class eliminar {
    public static void main(String[] args) {
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();

            // 1. Primero eliminamos los registros dependientes en otras tablas para evitar el conflicto de llave foránea
            st.executeUpdate("DELETE FROM entrenamientos WHERE id_usuario = 1");
            st.executeUpdate("DELETE FROM mediciones WHERE id_usuario = 1");
            st.executeUpdate("DELETE FROM membresias WHERE id_usuario = 1");
            st.executeUpdate("DELETE FROM patologias WHERE id_usuario = 1");

            // 2. Una vez libres las dependencias, eliminamos al usuario con éxito
            String sql = "DELETE FROM usuarios WHERE id_usuario = 1";
            st.executeUpdate(sql);

            System.out.println("¡Usuario y sus registros asociados eliminados correctamente!\n");

            rs = st.executeQuery("SELECT * FROM usuarios");

            if (rs.next()) {
                System.out.println("--- REGISTROS RESTANTES DE USUARIOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Usuario     : " + rs.getInt("id_usuario"));
                    System.out.println("Nombre Completo: " + rs.getString("nombre_completo"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("La tabla usuarios está completamente vacía.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}