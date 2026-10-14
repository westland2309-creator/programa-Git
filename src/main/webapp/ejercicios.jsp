<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ejercicios - DEXONEFIT</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            padding: 30px 20px;
        }
        .contenedor {
            max-width: 1000px;
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
        input[type="text"], textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 14px;
        }
        textarea {
            resize: vertical;
            height: 80px;
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
            <h2>🏋️ Registrar Nuevo Ejercicio</h2>
            
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String nombre = request.getParameter("nombre");
                    String grupoMuscular = request.getParameter("grupo_muscular");
                    String patronMovimiento = request.getParameter("patron_movimiento");
                    String tipoEjercicio = request.getParameter("tipo_ejercicio");
                    String equipamiento = request.getParameter("equipamiento");
                    String nivel = request.getParameter("nivel");
                    String descripcionTecnica = request.getParameter("descripcion_tecnica");
                    String precauciones = request.getParameter("precauciones");

                    Connection conn = null;
                    PreparedStatement pstmt = null;

                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dexonefit?useSSL=false&serverTimezone=UTC", "root", "");

                        String sql = "INSERT INTO ejercicios (nombre, grupo_muscular, patron_movimiento, tipo_ejercicio, equipamiento, nivel, descripcion_tecnica, precauciones) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setString(1, nombre);
                        pstmt.setString(2, grupoMuscular);
                        pstmt.setString(3, patronMovimiento);
                        pstmt.setString(4, tipoEjercicio);
                        pstmt.setString(5, equipamiento);
                        pstmt.setString(6, nivel);
                        pstmt.setString(7, descripcionTecnica);
                        pstmt.setString(8, precauciones);
                        
                        pstmt.executeUpdate();
            %>
                        <div class="alerta exito">¡Ejercicio registrado con éxito!</div>
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
                    <div class="form-group">
                        <label>Nombre del Ejercicio:</label>
                        <input type="text" name="nombre" required placeholder="Ej. Sentadilla libre">
                    </div>
                    <div class="form-group">
                        <label>Grupo Muscular:</label>
                        <input type="text" name="grupo_muscular" required placeholder="Ej. Cuádriceps / Glúteos">
                    </div>
                    <div class="form-group">
                        <label>Patrón de Movimiento:</label>
                        <input type="text" name="patron_movimiento" placeholder="Ej. Dominante de rodilla">
                    </div>
                    <div class="form-group">
                        <label>Tipo de Ejercicio:</label>
                        <input type="text" name="tipo_ejercicio" placeholder="Ej. Analítico / Multiarticular">
                    </div>
                    <div class="form-group">
                        <label>Equipamiento:</label>
                        <input type="text" name="equipamiento" placeholder="Ej. Barra olímpica / Disco">
                    </div>
                    <div class="form-group">
                        <label>Nivel:</label>
                        <input type="text" name="nivel" placeholder="Ej. Intermedio / Avanzado">
                    </div>
                    <div class="form-group form-full">
                        <label>Descripción Técnica (Biomecánica):</label>
                        <textarea name="descripcion_tecnica" placeholder="Detalles de la ejecución en los planos anatómicos..."></textarea>
                    </div>
                    <div class="form-group form-full">
                        <label>Precauciones / Consideraciones:</label>
                        <textarea name="precauciones" placeholder="Cuidados de columna, rodilla, etc..."></textarea>
                    </div>
                </div>
                <button type="submit">Guardar Ejercicio</button>
            </form>
        </div>

        <div class="card">
            <h2>📋 Catálogo de Ejercicios</h2>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Nombre</th>
                        <th>Grupo Muscular</th>
                        <th>Patrón</th>
                        <th>Nivel</th>
                        <th>Descripción Técnica</th>
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
                            rsList = stmtList.executeQuery("SELECT * FROM ejercicios");

                            while (rsList.next()) {
                    %>
                                <tr>
                                    <td><%= rsList.getInt("id_ejercicio") %></td>
                                    <td><%= rsList.getString("nombre") %></td>
                                    <td><%= rsList.getString("grupo_muscular") %></td>
                                    <td><%= rsList.getString("patron_movimiento") %></td>
                                    <td><%= rsList.getString("nivel") %></td>
                                    <td><%= rsList.getString("descripcion_tecnica") %></td>
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