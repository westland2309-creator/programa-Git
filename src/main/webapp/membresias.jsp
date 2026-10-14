<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDate"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Membresías - DEXONEFIT</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            padding: 30px 20px;
        }
        .contenedor {
            max-width: 1200px;
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
        .form-group.full {
            grid-column: 1 / -1;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
            font-size: 13px;
        }
        input[type="text"], input[type="date"], select {
            width: 100%;
            padding: 10px;
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
            grid-column: 1 / -1;
        }
        button:hover {
            background: #008f5a;
        }
        .table-container {
            width: 100%;
            overflow-x: auto;
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
            <h2>💳 Gestión y Control de Membresías - DEXONEFIT</h2>
            
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    try {
                        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
                        String tipoMembresia = request.getParameter("tipo_membresia");
                        String fechaInicio = request.getParameter("fecha_inicio");
                        String fechaVencimiento = request.getParameter("fecha_vencimiento");
                        double precio = Double.parseDouble(request.getParameter("precio"));
                        String estado = request.getParameter("estado");

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dexonefit?useSSL=false&serverTimezone=UTC", "root", "");

                        String sql = "INSERT INTO membresias (id_usuario, tipo_membresia, fecha_inicio, fecha_vencimiento, precio, estado) VALUES (?, ?, ?, ?, ?, ?)";
                        
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, idUsuario);
                        pstmt.setString(2, tipoMembresia);
                        pstmt.setString(3, fechaInicio);
                        pstmt.setString(4, fechaVencimiento);
                        pstmt.setDouble(5, precio);
                        pstmt.setString(6, estado);

                        pstmt.executeUpdate();
                        pstmt.close();
                        conn.close();
            %>
                        <div class="alerta exito">¡Membresía registrada y asignada con éxito en la base de datos!</div>
            <%
                    } catch (Exception e) {
            %>
                        <div class="alerta error">Error al procesar: <%= e.getMessage() %></div>
            <%
                    }
                }
            %>

            <form method="POST">
                <div class="form-grid">
                    <div class="form-group">
                        <label>ID del Usuario:</label>
                        <input type="text" name="id_usuario" required placeholder="Ej. 1">
                    </div>
                    <div class="form-group">
                        <label>Tipo de Membresía:</label>
                        <input type="text" name="tipo_membresia" required placeholder="Ej. Mensual Personalizada / Trimestral VIP">
                    </div>
                    <div class="form-group">
                        <label>Fecha de Inicio:</label>
                        <input type="date" name="fecha_inicio" required>
                    </div>
                    <div class="form-group">
                        <label>Fecha de Vencimiento:</label>
                        <input type="date" name="fecha_vencimiento" required>
                    </div>
                    <div class="form-group">
                        <label>Precio ($):</label>
                        <input type="text" name="precio" required placeholder="Ej. 150000">
                    </div>
                    <div class="form-group">
                        <label>Estado:</label>
                        <select name="estado" required>
                            <option value="">Seleccione...</option>
                            <option value="Activa">Activa</option>
                            <option value="Vencida">Vencida</option>
                            <option value="Suspendida">Suspendida</option>
                        </select>
                    </div>
                </div>
                <button type="submit">Guardar y Asignar Membresía</button>
            </form>
        </div>

        <div class="card">
            <h2>📋 Historial de Membresías Registradas</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID Membresía</th>
                            <th>ID Usuario</th>
                            <th>Tipo</th>
                            <th>Fecha Inicio</th>
                            <th>Fecha Vencimiento</th>
                            <th>Precio</th>
                            <th>Estado</th>
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
                                rsList = stmtList.executeQuery("SELECT * FROM membresias");

                                while (rsList.next()) {
                        %>
                                    <tr>
                                        <td><%= rsList.getInt("id_membresia") %></td>
                                        <td><%= rsList.getInt("id_usuario") %></td>
                                        <td><strong><%= rsList.getString("tipo_membresia") %></strong></td>
                                        <td><%= rsList.getString("fecha_inicio") %></td>
                                        <td><%= rsList.getString("fecha_vencimiento") %></td>
                                        <td>$<%= rsList.getDouble("precio") %></td>
                                        <td><%= rsList.getString("estado") %></td>
                                    </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                                <tr><td colspan="7" style="color: red;">Error cargando membresías: <%= e.getMessage() %></td></tr>
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
    </div>

</body>
</html>