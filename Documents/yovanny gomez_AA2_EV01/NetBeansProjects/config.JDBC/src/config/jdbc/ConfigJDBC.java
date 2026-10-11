package config.jdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConfigJDBC {
    
    // Configura aquí el nombre de tu base de datos en MySQL Workbench si es diferente
    private static final String URL = "jdbc:mysql://localhost:3306/dexonefit?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    // Si tu usuario root tiene contraseña en MySQL Workbench, escríbela entre las comillas de abajo. 
    // Si no tiene contraseña, déjala vacía como "".
    private static final String PASSWORD = ""; 

    public static Connection getConnection() {
        Connection conexion = null;
        try {
            // Cargar el driver moderno de MySQL que agregamos al pom.xml
            Class.forName("com.mysql.cj.jdbc.Driver");
            conexion = DriverManager.getConnection(URL, USER, PASSWORD);
            System.out.println("¡Conexión exitosa a la base de datos DEXONEFIT!");
        } catch (ClassNotFoundException e) {
            System.err.println("Error: No se encontró el driver de MySQL -> " + e.getMessage());
        } catch (SQLException e) {
            System.err.println("Error de SQL / Credenciales -> " + e.getMessage());
        }
        return conexion;
    }

    public static void main(String[] args) {
        // Prueba rápida de conexión desde NetBeans
        getConnection();
    }
}