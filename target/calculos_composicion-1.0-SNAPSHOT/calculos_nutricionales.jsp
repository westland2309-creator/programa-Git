<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cálculos Nutricionales - DEXONEFIT</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            padding: 30px 20px;
        }
        .contenedor {
            max-width: 950px;
            margin: 0 auto;
        }
        .btn-volver {
            display: inline-block;
            margin-bottom: 20px;
            text-decoration: none;
            color: #00a86b;
            font-weight: bold;
            background: white;
            padding: 10px 15px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.05);
        }
        .btn-volver:hover {
            background: #00a86b;
            color: white;
        }
        .card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.08);
            margin-bottom: 25px;
        }
        h2 {
            color: #333;
            margin-top: 0;
            border-bottom: 2px solid #00a86b;
            padding-bottom: 10px;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 15px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-full {
            grid-column: 1 / -1;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
        }
        input[type="text"] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }
        button {
            background: #00a86b;
            color: white;
            border: none;
            padding: 12px 20px;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.2s;
        }
        button:hover {
            background: #008f5a;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #eee;
            font-size: 13px;
        }
        th {
            background: #f8f9fa;
            color: #333;
        }
        .alerta {
            padding: 12px;
            border-radius: 8px;
            margin-bottom: 15px;
            font-weight: bold;
        }
        .exito { background: #d4edda; color: #155724; }
        .error { background: #f8d7da; color: #721c24; }
    </style>
</head>
<body>

    <div class="contenedor">
        <a href="index.jsp" class="btn-volver">← Volver al Menú Principal</a>

        <div class="card">
            <h2>🍎 Registro de Cálculos Nutricionales</h2>
            
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String idUsuario = request.getParameter("id_usuario");
                    String peso = request.getParameter("peso");
                    String estatura = request.getParameter("estatura");
                    String caloriasObjetivo = request.getParameter("calorias_objetivo");
                    String proteina = request.getParameter("proteina");
                    String carbohidratos = request.getParameter("carbohidratos");
                    String grasas = request.getParameter("grasas");

                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dexonefit?useSSL=false&serverTimezone=UTC", "root", "");

                        String sql = "INSERT INTO calculos_nutricionales (id_usuario, peso, estatura, calorias_objetivo, proteina, carbohidratos, grasas) VALUES (?, ?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, idUsuario);
                        pstmt.setString(2, peso);
                        pstmt.setString(3, estatura);
                        pstmt.setString(4, caloriasObjetivo);
                        pstmt.setString(5, proteina);
                        pstmt.setString(6, carbohidratos);
                        pstmt.setString(7, grasas);
                        
                        pstmt.executeUpdate();
            %>
                        <div class="alerta exito">¡Cálculo nutricional registrado correctamente!</div>
            <%
                    } catch (Exception e) {
            %>
                        <div class="alerta error">Error al registrar: <%= e.getMessage() %></div>
            <%
                    } finally {
                        if (pstmt != null) try { pstmt.close(); } catch (SQLException ignore) {}
                        if (conn != null) try { conn.close(); } catch (SQLException ignore) {}
                    }
                }
            %>

            <form method="POST">
                <div class="form-grid">
                    <div class="form-group form-full">
                        <label>ID del Usuario:</label>
                        <input type="text" name="id_usuario" required placeholder="Ej. 1">
                    </div>
                    <div class="form-group">
                        <label>Peso (kg):</label>
                        <input type="text" name="peso" required placeholder="Ej. 79.0">
                    </div>
                    <div class="form-group">
                        <label>Estatura (cm):</label>
                        <input type="text" name="estatura" required placeholder="Ej. 179">
                    </div>
                    <div class="form-group">
                        <label>Calorías Objetivo (kcal):</label>
                        <input type="text" name="calorias_objetivo" required placeholder="Ej. 2500">
                    </div>
                    <div class="form-group">
                        <label>Proteína (g):</label>
                        <input type="text" name="proteina" required placeholder="Ej. 160">
                    </div>
                    <div class="form-group">
                        <label>Carbohidratos (g):</label>
                        <input type="text" name="carbohidratos" required placeholder="Ej. 300">
                    </div>
                    <div class="form-group">
                        <label>Grasas (g):</label>
                        <input type="text" name="grasas" required placeholder="Ej. 70">
                    </div>
                </div>
                <button type="submit">Guardar Cálculo Nutricional</button>
            </form>
        </div>

        <div class="card">
            <h2>📋 Historial de Cálculos Nutricionales</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Usuario</th>
                        <th>Calorías</th>
                        <th>Proteínas</th>
                        <th>Carbs</th>
                        <th>Grasas</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        Connection connList = null;
                        Statement stmtList = null;
                        ResultSet rsList = null;
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            connList = DriverManager.getConnection("jdbc:mysql://localhost:3306/dexonefit?useSSL=false&serverTimezone=UTC", "root", "");
                            stmtList = connList.createStatement();
                            rsList = stmtList.executeQuery("SELECT * FROM calculos_nutricionales");

                            while (rsList.next()) {
                    %>
                                <tr>
                                    <td><%= rsList.getInt("id_calculo_nutricional") %></td>
                                    <td><%= rsList.getString("id_usuario") %></td>
                                    <td><%= rsList.getString("calorias_objetivo") %></td>
                                    <td><%= rsList.getString("proteina") %></td>
                                    <td><%= rsList.getString("carbohidratos") %></td>
                                    <td><%= rsList.getString("grasas") %></td>
                                </tr>
                    <%
                            }
                        } catch (Exception e) {
                    %>
                            <tr><td colspan="6" style="color: red;">Error cargando datos: <%= e.getMessage() %></td></tr>
                    <%
                        } finally {
                            if (rsList != null) try { rsList.close(); } catch(Exception ignore){}
                            if (stmtList != null) try { stmtList.close(); } catch(Exception ignore){}
                            if (connList != null) try { connList.close(); } catch(Exception ignore){}
                        }
                    %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>