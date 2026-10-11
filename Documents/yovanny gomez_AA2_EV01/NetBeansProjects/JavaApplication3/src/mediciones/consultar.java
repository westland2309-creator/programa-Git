package mediciones;

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

        String sql = "SELECT * FROM mediciones";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }

        try {
            cn = con.getConnection();
            st = cn.createStatement();
            rs = st.executeQuery(sql);

            if (rs.next()) {
                System.out.println("--- LISTADO DE MEDICIONES ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Medición        : " + rs.getInt("id_medicion"));
                    System.out.println("ID Usuario         : " + rs.getInt("id_usuario"));
                    System.out.println("Fecha              : " + rs.getDate("fecha"));
                    System.out.println("Tipo Valoración    : " + rs.getString("tipo_valoracion"));
                    System.out.println("Peso (kg)          : " + rs.getDouble("peso"));
                    System.out.println("Estatura (m)       : " + rs.getDouble("estatura"));
                    System.out.println("Grasa Corporal (%) : " + rs.getDouble("grasa_corporal"));
                    System.out.println("Masa Muscular (kg) : " + rs.getDouble("masa_muscular"));
                    System.out.println("Grasa Visceral     : " + rs.getInt("grasa_visceral"));
                    System.out.println("Edad Metabólica    : " + rs.getInt("edad_metabolica"));
                    System.out.println("Agua Corporal (%)  : " + rs.getDouble("agua_corporal"));
                    System.out.println("Masa Ósea (kg)     : " + rs.getDouble("masa_osea"));
                    System.out.println("TMB Tanita (kcal)  : " + rs.getDouble("tmb_tanita"));
                    System.out.println("Cintura (cm)       : " + rs.getDouble("cintura"));
                    System.out.println("Cuello (cm)        : " + rs.getDouble("cuello"));
                    System.out.println("Cadera (cm)        : " + rs.getDouble("cadera"));
                    System.out.println("Brazo (cm)         : " + rs.getDouble("brazo"));
                    System.out.println("Muslo (cm)         : " + rs.getDouble("muslo"));
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