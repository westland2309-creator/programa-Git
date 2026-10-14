package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.conexion;
import java.sql.Connection;

@WebServlet(name = "CalculosComposicionServlet", urlPatterns = {"/CalculosComposicionServlet"})
public class CalculosComposicionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Capturamos la acción enviada desde el formulario JSP
        String accion = request.getParameter("accion");
        
        if ("calcular".equals(accion)) {
            String pesoStr = request.getParameter("peso");
            String alturaStr = request.getParameter("altura");
            
            try {
                double peso = Double.parseDouble(pesoStr);
                double altura = Double.parseDouble(alturaStr);
                
                // Cálculo de ejemplo de composición (IMC)
                double imc = peso / (altura * altura);
                
                // Verificamos la conexión a la base de datos con tu clase modelo.conexion
                Connection con = conexion.conectar();
                
                // Enviamos el resultado de vuelta a la vista
                request.setAttribute("resultadoIMC", imc);
                request.getRequestDispatcher("calculos_composicion.jsp").forward(request, response);
                
            } catch (NumberFormatException e) {
                System.out.println("Error en formato de datos numéricos: " + e.getMessage());
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
        return "Controlador de Calculos de Composicion para DEXONEFIT";
    }
}