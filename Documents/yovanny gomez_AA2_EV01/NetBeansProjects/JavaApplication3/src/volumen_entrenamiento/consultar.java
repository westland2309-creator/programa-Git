package volumen_entrenamiento;

import conexion.conexion;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author yovanny
 */
public class consultar {
    public static void main(String[] args) {
        conexion con = new conexion();
        Connection cn;
        Statement st;
        ResultSet rs;

        String sql = "SELECT * FROM volumen_entrenamiento";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            cn = con.getConnection();
            st = cn.createStatement();
            rs = st.executeQuery(sql);

            System.out.println("--- LISTADO DE VOLUMEN DE ENTRENAMIENTO ---");
            boolean hayRegistros = false;
            
            while (rs.next()) {
                hayRegistros = true;
                System.out.println("========================================");
                System.out.println("ID Volumen    : " + rs.getInt("id_volumen"));
                System.out.println("ID Usuario    : " + rs.getInt("id_usuario"));
                System.out.println("ID Ejercicio  : " + rs.getInt("id_ejercicio"));
                System.out.println("Series        : " + rs.getInt("series"));
                System.out.println("Repeticiones  : " + rs.getInt("repeticiones"));
                System.out.println("Carga         : " + rs.getDouble("carga"));
                System.out.println("Volumen Total : " + rs.getDouble("volumen"));
                System.out.println("Fecha         : " + rs.getDate("fecha"));
                System.out.println("========================================");
            }

            if (!hayRegistros) {
                System.out.println("No hay registros en la tabla volumen_entrenamiento.");
            }

        } catch (ClassNotFoundException | SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }
}