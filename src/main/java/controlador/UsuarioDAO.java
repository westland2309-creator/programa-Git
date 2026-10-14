package controlador;

import modelo.conexion;
import modelo.Usuario;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.ArrayList;

public class UsuarioDAO {

    public boolean existeEmail(String correo) {
        boolean existe = false;
        String sql = "SELECT COUNT(*) FROM usuarios WHERE correo = ?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, correo);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                existe = rs.getInt(1) > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return existe;
    }

    public void registrar(Usuario usuario) {
        String sql = "INSERT INTO usuarios (nombre_completo, correo, telefono, tipo_usuario, password) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, usuario.getNombre());
            ps.setString(2, usuario.getEmail());
            ps.setString(3, usuario.getTelefono() != null ? usuario.getTelefono() : "3000000000");
            ps.setString(4, usuario.getRol() != null ? usuario.getRol() : "Administrador");
            ps.setString(5, usuario.getPassword());
            ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Método para validar el inicio de sesión (Login)
    public Usuario validarLogin(String correo, String password) {
        Usuario usuario = null;
        String sql = "SELECT id_usuario, nombre_completo, correo, telefono, tipo_usuario, password FROM usuarios WHERE correo = ? AND password = ?";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, correo);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                usuario = new Usuario();
                usuario.setNombre(rs.getString("nombre_completo"));
                usuario.setEmail(rs.getString("correo"));
                usuario.setTelefono(rs.getString("telefono"));
                usuario.setPassword(rs.getString("password"));
                usuario.setRol(rs.getString("tipo_usuario"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return usuario;
    }

    // Método para listar todos los usuarios
    public List<Usuario> listarUsuarios() {
        List<Usuario> lista = new ArrayList<>();
        String sql = "SELECT id_usuario, nombre_completo, correo, telefono, tipo_usuario, password FROM usuarios";
        try (Connection con = conexion.conectar();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Usuario u = new Usuario();
                u.setNombre(rs.getString("nombre_completo"));
                u.setEmail(rs.getString("correo"));
                u.setTelefono(rs.getString("telefono"));
                u.setPassword(rs.getString("password"));
                u.setRol(rs.getString("tipo_usuario"));
                lista.add(u);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return lista;
    }
}