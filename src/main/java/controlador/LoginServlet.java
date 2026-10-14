package controlador;

import modelo.Usuario;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String accion = request.getParameter("accion");
        
        if (accion != null) {
            if ("ingresar".equals(accion)) {
                String email = request.getParameter("email");
                String password = request.getParameter("password");
                String rolSeleccionado = request.getParameter("rol"); // Recogemos el rol del formulario

                // Instancia del DAO
                UsuarioDAO dao = new UsuarioDAO();
                
                // Método que valida el usuario en el DAO
                Usuario usuario = dao.validarLogin(email, password);

                if (usuario != null) {
                    // Si el usuario existe, creamos la sesión
                    HttpSession session = request.getSession();
                    session.setAttribute("usuarioLogueado", usuario);
                    session.setAttribute("nombreUsuario", usuario.getNombre());
                    session.setAttribute("rolUsuario", usuario.getRol());

                    // Redirigir según el rol o al index principal de DEXONEFIT
                    response.sendRedirect("index.jsp");
                } else {
                    // Si los datos son incorrectos, mandamos mensaje de error
                    request.setAttribute("error", "Correo o contraseña incorrectos.");
                    request.getRequestDispatcher("login.jsp").forward(request, response);
                }
                
            } else if ("cerrar".equals(accion)) {
                // Destruye la sesión actual para desloguear al usuario de forma segura
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.invalidate();
                }
                // Redirige de regreso a la pantalla de login de DEXONEFIT
                response.sendRedirect("login.jsp");
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet de Autenticación para DEXONEFIT";
    }
}