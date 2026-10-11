package ejercicios;

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
        
        // Datos del ejercicio de sentadilla hack péndulo
        String nombre = "Sentadilla hack péndulo";
        String grupoMuscular = "Cuádriceps";
        String patronMovimiento = "Dominante de rodilla";
        String tipoEjercicio = "Fuerza / Máquina";
        String equipamiento = "Máquina Hack Péndulo";
        String nivel = "Medio";
        String descripcionTecnica = "Colocar la espalda firmemente en el respaldo, apoyar los hombros y descender de forma controlada flexionando las rodillas.";
        String precauciones = "Tomar aire profundo al bajar y botar al subir.";
        
        // Sentencia SQL INSERT adaptada a tus columnas
        String sql = "INSERT INTO ejercicios (nombre, grupo_muscular, patron_movimiento, tipo_ejercicio, equipamiento, nivel, descripcion_tecnica, precauciones) " +
                     "VALUES ('" + nombre + "', '" + grupoMuscular + "', '" + patronMovimiento + "', '" + tipoEjercicio + "', '" + equipamiento + "', '" + nivel + "', '" + descripcionTecnica + "', '" + precauciones + "')";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch(ClassNotFoundException ex) {
            System.out.println("Error del Driver: " + ex.getMessage());
        }
        
        try {
            cn = con.getConnection();
            st = cn.createStatement();
            st.executeUpdate(sql);
            
            System.out.println("¡Ejercicio insertado correctamente!\n");
            
            rs = st.executeQuery("SELECT * FROM ejercicios");
            
            if (rs.next()) {
                System.out.println("--- LISTADO DE EJERCICIOS ---");
                do {
                    System.out.println("========================================");
                    System.out.println("ID Ejercicio       : " + rs.getInt("id_ejercicio"));
                    System.out.println("Nombre             : " + rs.getString("nombre"));
                    System.out.println("Grupo Muscular     : " + rs.getString("grupo_muscular"));
                    System.out.println("Patrón Movimiento  : " + rs.getString("patron_movimiento"));
                    System.out.println("Tipo Ejercicio     : " + rs.getString("tipo_ejercicio"));
                    System.out.println("Equipamiento       : " + rs.getString("equipamiento"));
                    System.out.println("Nivel              : " + rs.getString("nivel"));
                    System.out.println("Descripción Téc.   : " + rs.getString("descripcion_tecnica"));
                    System.out.println("Precauciones       : " + rs.getString("precauciones"));
                    System.out.println("========================================");
                } while (rs.next());
            } else {
                System.out.println("No hay registros en ejercicios.");
            }
            
        } catch (SQLException ex) {
            System.out.println("¡ERROR DE SQL EXACTO!: " + ex.getMessage());
        }
    }  
}
