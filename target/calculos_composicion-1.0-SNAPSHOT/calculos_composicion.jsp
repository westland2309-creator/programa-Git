<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cálculo de Composición - DEXONEFIT</title>
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
            grid-template-columns: repeat(4, 1fr);
            gap: 15px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
            color: #555;
            font-size: 13px;
        }
        input[type="text"], select {
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
            padding: 10px;
            text-align: left;
            border-bottom: 1px solid #eee;
            font-size: 11px;
            white-space: nowrap;
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
            <h2>📊 Registro Antropométrico y Zonas de Entrenamiento (Tanaka)</h2>
            
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    try {
                        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
                        String sexo = request.getParameter("sexo");
                        double edad = Double.parseDouble(request.getParameter("edad"));
                        double peso = Double.parseDouble(request.getParameter("peso"));
                        double estaturaCm = Double.parseDouble(request.getParameter("estatura"));
                        double cintura = Double.parseDouble(request.getParameter("cintura"));
                        double cuello = Double.parseDouble(request.getParameter("cuello"));
                        double cadera = Double.parseDouble(request.getParameter("cadera"));

                        double estaturaM = estaturaCm / 100.0;

                        // 1. Cálculo de IMC
                        double imc = peso / (estaturaM * estaturaM);

                        // 2. Clasificación de IMC
                        String clasificacionImc = "Normal";
                        if (imc < 18.5) clasificacionImc = "Bajo peso";
                        else if (imc >= 25 && imc < 30) clasificacionImc = "Sobrepeso";
                        else if (imc >= 30) clasificacionImc = "Obesidad";

                        // 3. Porcentaje de Grasa Corporal (Fórmula Marina de Guerra de EE.UU.)
                        double grasaCorporal = 0;
                        if ("M".equalsIgnoreCase(sexo)) {
                            grasaCorporal = 495 / (1.0324 - 0.19077 * Math.log10(cintura - cuello) + 0.15456 * Math.log10(estaturaCm)) - 450;
                        } else {
                            grasaCorporal = 495 / (1.29579 - 0.35004 * Math.log10(cintura + cadera - cuello) + 0.22100 * Math.log10(estaturaCm)) - 450;
                        }
                        if (grasaCorporal < 3) grasaCorporal = 3;

                        // 4. Masas corporales
                        double masaGrasa = peso * (grasaCorporal / 100.0);
                        double masaLibreGrasa = peso - masaGrasa;

                        // 5. Relación Cintura-Estatura
                        double relacionCinturaEstatura = cintura / estaturaCm;

                        // 6. FC Máxima con la fórmula de Tanaka: 208 - (0.7 * edad)
                        double fcMaxima = 208 - (0.7 * edad);

                        // 7. Zonas de entrenamiento cardíaco
                        double zona1Min = fcMaxima * 0.50; double zona1Max = fcMaxima * 0.60;
                        double zona2Min = fcMaxima * 0.60; double zona2Max = fcMaxima * 0.70;
                        double zona3Min = fcMaxima * 0.70; double zona3Max = fcMaxima * 0.80;
                        double zona4Min = fcMaxima * 0.80; double zona4Max = fcMaxima * 0.90;
                        double zona5Min = fcMaxima * 0.90; double zona5Max = fcMaxima * 1.00;

                        LocalDateTime ahora = LocalDateTime.now();
                        String fechaActual = ahora.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

                        Connection conn = null;
                        PreparedStatement pstmt = null;

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dexonefit?useSSL=false&serverTimezone=UTC", "root", "");

                        String sql = "INSERT INTO calculos_composicion (id_usuario, fecha, sexo, edad, peso, estatura, cintura, cuello, cadera, imc, clasificacion_imc, grasa_corporal, masa_grasa, masa_libre_grasa, relacion_cintura_estatura, fc_maxima, zona1_min, zona1_max, zona2_min, zona2_max, zona3_min, zona3_max, zona4_min, zona4_max, zona5_min, zona5_max) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        
                        pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, idUsuario);
                        pstmt.setString(2, fechaActual);
                        pstmt.setString(3, sexo);
                        pstmt.setDouble(4, edad);
                        pstmt.setDouble(5, peso);
                        pstmt.setDouble(6, estaturaCm);
                        pstmt.setDouble(7, cintura);
                        pstmt.setDouble(8, cuello);
                        pstmt.setDouble(9, cadera);
                        pstmt.setDouble(10, imc);
                        pstmt.setString(11, clasificacionImc);
                        pstmt.setDouble(12, grasaCorporal);
                        pstmt.setDouble(13, masaGrasa);
                        pstmt.setDouble(14, masaLibreGrasa);
                        pstmt.setDouble(15, relacionCinturaEstatura);
                        pstmt.setDouble(16, fcMaxima);
                        pstmt.setDouble(17, zona1Min); pstmt.setDouble(18, zona1Max);
                        pstmt.setDouble(19, zona2Min); pstmt.setDouble(20, zona2Max);
                        pstmt.setDouble(21, zona3Min); pstmt.setDouble(22, zona3Max);
                        pstmt.setDouble(23, zona4Min); pstmt.setDouble(24, zona4Max);
                        pstmt.setDouble(25, zona5Min); pstmt.setDouble(26, zona5Max);

                        pstmt.executeUpdate();
                        pstmt.close();
                        conn.close();
            %>
                        <div class="alerta exito">¡Cálculo antropométrico y zonas de Tanaka guardados con éxito!</div>
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
                        <label>Sexo:</label>
                        <select name="sexo" required>
                            <option value="">Seleccione...</option>
                            <option value="M">Masculino</option>
                            <option value="F">Femenino</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Edad (años):</label>
                        <input type="text" name="edad" required placeholder="Ej. 33">
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
                        <label>Cintura (cm):</label>
                        <input type="text" name="cintura" required placeholder="Ej. 85">
                    </div>
                    <div class="form-group">
                        <label>Cuello (cm):</label>
                        <input type="text" name="cuello" required placeholder="Ej. 38">
                    </div>
                    <div class="form-group">
                        <label>Cadera (cm):</label>
                        <input type="text" name="cadera" required placeholder="Ej. 95">
                    </div>
                </div>
                <button type="submit">Calcular y Guardar (Incluye Tanaka y Composición)</button>
            </form>
        </div>

        <div class="card">
            <h2>📋 Historial Registrado en Base de Datos</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Usuario</th>
                            <th>Fecha</th>
                            <th>Sexo</th>
                            <th>Edad</th>
                            <th>Peso</th>
                            <th>Estatura</th>
                            <th>IMC</th>
                            <th>Clasif.</th>
                            <th>% Grasa</th>
                            <th>Masa Grasa</th>
                            <th>Masa Libre</th>
                            <th>Cint/Est</th>
                            <th>FC Máx (Tanaka)</th>
                            <th>Z1 Min-Max</th>
                            <th>Z2 Min-Max</th>
                            <th>Z3 Min-Max</th>
                            <th>Z4 Min-Max</th>
                            <th>Z5 Min-Max</th>
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
                                rsList = stmtList.executeQuery("SELECT * FROM calculos_composicion");

                                while (rsList.next()) {
                        %>
                                    <tr>
                                        <td><%= rsList.getInt("id_calculo") %></td>
                                        <td><%= rsList.getInt("id_usuario") %></td>
                                        <td><%= rsList.getString("fecha") %></td>
                                        <td><%= rsList.getString("sexo") %></td>
                                        <td><%= rsList.getDouble("edad") %></td>
                                        <td><%= rsList.getDouble("peso") %></td>
                                        <td><%= rsList.getDouble("estatura") %></td>
                                        <td><%= String.format("%.2f", rsList.getDouble("imc")) %></td>
                                        <td><%= rsList.getString("clasificacion_imc") %></td>
                                        <td><%= String.format("%.2f%%", rsList.getDouble("grasa_corporal")) %></td>
                                        <td><%= String.format("%.2f kg", rsList.getDouble("masa_grasa")) %></td>
                                        <td><%= String.format("%.2f kg", rsList.getDouble("masa_libre_grasa")) %></td>
                                        <td><%= String.format("%.2f", rsList.getDouble("relacion_cintura_estatura")) %></td>
                                        <td><strong><%= String.format("%.1f lpm", rsList.getDouble("fc_maxima")) %></strong></td>
                                        <td><%= String.format("%.0f - %.0f", rsList.getDouble("zona1_min"), rsList.getDouble("zona1_max")) %></td>
                                        <td><%= String.format("%.0f - %.0f", rsList.getDouble("zona2_min"), rsList.getDouble("zona2_max")) %></td>
                                        <td><%= String.format("%.0f - %.0f", rsList.getDouble("zona3_min"), rsList.getDouble("zona3_max")) %></td>
                                        <td><%= String.format("%.0f - %.0f", rsList.getDouble("zona4_min"), rsList.getDouble("zona4_max")) %></td>
                                        <td><%= String.format("%.0f - %.0f", rsList.getDouble("zona5_min"), rsList.getDouble("zona5_max")) %></td>
                                    </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                                <tr><td colspan="19" style="color: red;">Error cargando historial: <%= e.getMessage() %></td></tr>
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