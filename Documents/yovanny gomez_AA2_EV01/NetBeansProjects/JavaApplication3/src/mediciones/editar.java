package mediciones;

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

        // Actualizamos por ejemplo el peso, la masa muscular y las observaciones para el id_medicion = 1
        String sql = "UPDATE mediciones SET peso = 79.5, masa_muscular = 63.8, imc = 24.8, observaciones = 'Actualización de progreso físico registrada.' WHERE id_medicion = 1";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);

            System.out.println("¡Medición actualizada correctamente!\n");

            rs = st.executeQuery("SELECT * FROM mediciones");

            if (rs.next()) {
                System.out.println("--- LISTADO ACTUALIZADO DE MEDICIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Medición        : " + rs.getInt("id_medicion"));
                    System.out.println("ID Usuario         : " + rs.getInt("id_usuario"));
                    System.out.println("Fecha              : " + rs.getDate("fecha"));
                    System.out.println("Peso (kg)          : " + rs.getDouble("peso"));
                    System.out.println("Masa Muscular (kg) : " + rs.getDouble("masa_muscular"));
                    System.out.println("IMC                : " + rs.getDouble("imc"));
                    System.out.println("Observaciones      : " + rs.getString("observaciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en mediciones.");
            }

        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}