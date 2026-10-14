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

@WebServlet(name = "CalculosNutricionalesServlet", urlPatterns = {"/CalculosNutricionalesServlet"})
public class CalculosNutricionalesServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        // Capturamos la acción enviada desde la vista de cálculos nutricionales
        String accion = request.getParameter("accion");
        
        if ("calcularNutricion".equals(accion)) {
            // Capturar parámetros (ej: calorías objetivo, proteínas, carbohidratos, grasas)
            String caloriasStr = request.getParameter("calorias");
            
            try {
                double calorias = Double.parseDouble(caloriasStr);
                
                // Ejemplo de distribución orientativa de macros para tus planes
                double proteinasGramos = (calorias * 0.30) / 4; // 30% de las kcal de proteína
                double carosGramos = (calorias * 0.45) / 4;      // 45% de las kcal de carbohidratos
                double grasasGramos = (calorias * 0.25) / 9;     // 25% de las kcal de grasas
                
                // Verificamos la conexión a la base de datos de DEXONEFIT
                Connection con = conexion.conectar();
                
                // Retornamos los resultados hacia la vista JSP
                request.setAttribute("resProteinas", proteinasGramos);
                request.setAttribute("resCarbos", carosGramos);
                request.setAttribute("resGrasas", grasasGramos);
                
                request.getRequestDispatcher("calculos_nutricionales.jsp").forward(request, response);
                
            } catch (NumberFormatException e) {
                System.out.println("Error procesando los valores nutricionales: " + e.getMessage());
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
        return "Controlador de Calculos Nutricionales para DEXONEFIT";
    }
}