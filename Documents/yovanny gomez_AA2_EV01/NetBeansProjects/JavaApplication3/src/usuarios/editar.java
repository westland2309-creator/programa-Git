package usuarios;

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

        // Actualizamos el número de teléfono al nuevo número (3152090811) para el usuario con id_usuario = 1
        String sql = "UPDATE usuarios SET telefono = '3152090811' WHERE id_usuario = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Teléfono del usuario actualizado correctamente!\n");

            rs = st.executeQuery("SELECT * FROM usuarios");

            if (rs.next()) {
                System.out.println("--- LISTADO ACTUALIZADO DE USUARIOS ---");
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