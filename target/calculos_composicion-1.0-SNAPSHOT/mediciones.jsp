<%@page import="java.sql.*"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.time.format.DateTimeFormatter"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Control de Mediciones - DEXONEFIT</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            padding: 30px 20px;
        }
        .contenedor {
            max-width: 1400px;
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
        h2, h3 {
            color: #333;
            margin-top: 0;
            border-bottom: 2px solid #00a86b;
            padding-bottom: 10px;
        }
        h3 {
            border-bottom: 1px solid #ddd;
            font-size: 16px;
            margin-top: 20px;
            color: #00a86b;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
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
            font-size: 12px;
        }
        input[type="text"], select, textarea {
            width: 100%;
            padding: 9px;
            border: 1px solid #ddd;
            border-radius: 8px;
            font-size: 13px;
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
            margin-top: 15px;
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
            padding: 8px;
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
            <h2>📏 Registro Antropométrico y de Bioimpedancia - DEXONEFIT</h2>
            
            <%
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    try {
                        int idUsuario = Integer.parseInt(request.getParameter("id_usuario"));
                        String tipoValoracion = request.getParameter("tipo_valoracion");

                        // Función auxiliar para parsear valores numéricos opcionales (si están vacíos mandan null)
                        java.util.function.Function<String, Double> parseDoubleOpt = val -> {
                            try { return (val == null || val.trim().isEmpty()) ? null : Double.parseDouble(val); }
                            catch (Exception e) { return null; }
                        };

                        Double peso = parseDoubleOpt.apply(request.getParameter("peso"));
                        Double estatura = parseDoubleOpt.apply(request.getParameter("estatura"));
                        Double grasaCorporal = parseDoubleOpt.apply(request.getParameter("grasa_corporal"));
                        Double masaMuscular = parseDoubleOpt.apply(request.getParameter("masa_muscular"));
                        Double grasaVisceral = parseDoubleOpt.apply(request.getParameter("grasa_visceral"));
                        Double edadMetabolica = parseDoubleOpt.apply(request.getParameter("edad_metabolica"));
                        Double aguaCorporal = parseDoubleOpt.apply(request.getParameter("agua_corporal"));
                        Double masaOsea = parseDoubleOpt.apply(request.getParameter("masa_osea"));
                        Double tmbTanita = parseDoubleOpt.apply(request.getParameter("tmb_tanita"));
                        Double cintura = parseDoubleOpt.apply(request.getParameter("cintura"));
                        Double cuello = parseDoubleOpt.apply(request.getParameter("cuello"));
                        Double cadera = parseDoubleOpt.apply(request.getParameter("cadera"));
                        Double brazo = parseDoubleOpt.apply(request.getParameter("brazo"));
                        Double muslo = parseDoubleOpt.apply(request.getParameter("muslo"));
                        Double imc = parseDoubleOpt.apply(request.getParameter("imc"));
                        
                        String observaciones = request.getParameter("observaciones");

                        LocalDateTime ahora = LocalDateTime.now();
                        String fechaActual = ahora.format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

                        Class.forName("com.mysql.cj.jdbc.Driver");
                        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/dexonefit?useSSL=false&serverTimezone=UTC", "root", "");

                        String sql = "INSERT INTO mediciones (id_usuario, fecha, tipo_valoracion, peso, estatura, grasa_corporal, masa_muscular, grasa_visceral, edad_metabolica, agua_corporal, masa_osea, tmb_tanita, cintura, cuello, cadera, brazo, muslo, imc, observaciones) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                        
                        PreparedStatement pstmt = conn.prepareStatement(sql);
                        pstmt.setInt(1, idUsuario);
                        pstmt.setString(2, fechaActual);
                        pstmt.setString(3, tipoValoracion);

                        // Asignar parámetros manejando nulos correctamente en JDBC
                        java.util.function.BiConsumer<Integer, Double> setParam = (index, val) -> {
                            try {
                                if (val == null) pstmt.setNull(index, java.sql.Types.DOUBLE);
                                else pstmt.setDouble(index, val);
                            } catch (Exception e) {}
                        };

                        setParam.accept(4, peso);
                        setParam.accept(5, estatura);
                        setParam.accept(6, grasaCorporal);
                        setParam.accept(7, masaMuscular);
                        setParam.accept(8, grasaVisceral);
                        setParam.accept(9, edadMetabolica);
                        setParam.accept(10, aguaCorporal);
                        setParam.accept(11, masaOsea);
                        setParam.accept(12, tmbTanita);
                        setParam.accept(13, cintura);
                        setParam.accept(14, cuello);
                        setParam.accept(15, cadera);
                        setParam.accept(16, brazo);
                        setParam.accept(17, muslo);
                        setParam.accept(18, imc);
                        pstmt.setString(19, observaciones);

                        pstmt.executeUpdate();
                        pstmt.close();
                        conn.close();
            %>
                        <div class="alerta exito">¡Mediciones guardadas con éxito en la base de datos!</div>
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
                        <label>Tipo de Valoración:</label>
                        <select name="tipo_valoracion" required>
                            <option value="">Seleccione...</option>
                            <option value="Inicial">Inicial</option>
                            <option value="Control / Progreso">Control / Progreso</option>
                            <option value="Final">Final</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>Peso (kg):</label>
                        <input type="text" name="peso" placeholder="Ej. 79.0">
                    </div>
                    <div class="form-group">
                        <label>Estatura (cm / m):</label>
                        <input type="text" name="estatura" placeholder="Ej. 179">
                    </div>

                    <div class="form-group full">
                        <h3>⚡ Datos de Bioimpedancia (Tanita / Bascula inteligente)</h3>
                    </div>
                    <div class="form-group">
                        <label>% Grasa Corporal:</label>
                        <input type="text" name="grasa_corporal" placeholder="Ej. 15.5">
                    </div>
                    <div class="form-group">
                        <label>Masa Muscular (kg):</label>
                        <input type="text" name="masa_muscular" placeholder="Ej. 64.2">
                    </div>
                    <div class="form-group">
                        <label>Grasa Visceral:</label>
                        <input type="text" name="grasa_visceral" placeholder="Ej. 4">
                    </div>
                    <div class="form-group">
                        <label>Edad Metabólica:</label>
                        <input type="text" name="edad_metabolica" placeholder="Ej. 30">
                    </div>
                    <div class="form-group">
                        <label>% Agua Corporal:</label>
                        <input type="text" name="agua_corporal" placeholder="Ej. 58.0">
                    </div>
                    <div class="form-group">
                        <label>Masa Ósea (kg):</label>
                        <input type="text" name="masa_osea" placeholder="Ej. 3.2">
                    </div>
                    <div class="form-group">
                        <label>TMB Tanita (kcal):</label>
                        <input type="text" name="tmb_tanita" placeholder="Ej. 1750">
                    </div>
                    <div class="form-group">
                        <label>IMC:</label>
                        <input type="text" name="imc" placeholder="Ej. 24.6">
                    </div>

                    <div class="form-group full">
                        <h3>📐 Antropometría y Perímetros (Cinta Métrica)</h3>
                    </div>
                    <div class="form-group">
                        <label>Cintura (cm):</label>
                        <input type="text" name="cintura" placeholder="Ej. 82">
                    </div>
                    <div class="form-group">
                        <label>Cuello (cm):</label>
                        <input type="text" name="cuello" placeholder="Ej. 38">
                    </div>
                    <div class="form-group">
                        <label>Cadera (cm):</label>
                        <input type="text" name="cadera" placeholder="Ej. 98">
                    </div>
                    <div class="form-group">
                        <label>Brazo (cm):</label>
                        <input type="text" name="brazo" placeholder="Ej. 35">
                    </div>
                    <div class="form-group">
                        <label>Muslo (cm):</label>
                        <input type="text" name="muslo" placeholder="Ej. 56">
                    </div>

                    <div class="form-group full">
                        <label>Observaciones de la Evaluación:</label>
                        <textarea name="observaciones" rows="2" placeholder="Ej. Buena hidratación previa, evolución positiva en masa magra..."></textarea>
                    </div>
                </div>
                <button type="submit">Guardar Mediciones</button>
            </form>
        </div>

        <div class="card">
            <h2>📋 Historial de Mediciones Registradas</h2>
            <div class="table-container">
                <table>
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Usuario</th>
                            <th>Fecha</th>
                            <th>Tipo</th>
                            <th>Peso</th>
                            <th>Estatura</th>
                            <th>% Grasa</th>
                            <th>M. Muscular</th>
                            <th>G. Visceral</th>
                            <th>Edad Met.</th>
                            <th>% Agua</th>
                            <th>M. Ósea</th>
                            <th>TMB</th>
                            <th>Cintura</th>
                            <th>Cuello</th>
                            <th>Cadera</th>
                            <th>Brazo</th>
                            <th>Muslo</th>
                            <th>IMC</th>
                            <th>Observaciones</th>
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
                                rsList = stmtList.executeQuery("SELECT * FROM mediciones");

                                while (rsList.next()) {
                        %>
                                    <tr>
                                        <td><%= rsList.getInt("id_medicion") %></td>
                                        <td><%= rsList.getInt("id_usuario") %></td>
                                        <td><%= rsList.getString("fecha") %></td>
                                        <td><%= rsList.getString("tipo_valoracion") %></td>
                                        <td><%= rsList.getObject("peso") != null ? rsList.getDouble("peso") : "-" %></td>
                                        <td><%= rsList.getObject("estatura") != null ? rsList.getDouble("estatura") : "-" %></td>
                                        <td><%= rsList.getObject("grasa_corporal") != null ? rsList.getDouble("grasa_corporal") : "-" %></td>
                                        <td><%= rsList.getObject("masa_muscular") != null ? rsList.getDouble("masa_muscular") : "-" %></td>
                                        <td><%= rsList.getObject("grasa_visceral") != null ? rsList.getDouble("grasa_visceral") : "-" %></td>
                                        <td><%= rsList.getObject("edad_metabolica") != null ? rsList.getDouble("edad_metabolica") : "-" %></td>
                                        <td><%= rsList.getObject("agua_corporal") != null ? rsList.getDouble("agua_corporal") : "-" %></td>
                                        <td><%= rsList.getObject("masa_osea") != null ? rsList.getDouble("masa_osea") : "-" %></td>
                                        <td><%= rsList.getObject("tmb_tanita") != null ? rsList.getDouble("tmb_tanita") : "-" %></td>
                                        <td><%= rsList.getObject("cintura") != null ? rsList.getDouble("cintura") : "-" %></td>
                                        <td><%= rsList.getObject("cuello") != null ? rsList.getDouble("cuello") : "-" %></td>
                                        <td><%= rsList.getObject("cadera") != null ? rsList.getDouble("cadera") : "-" %></td>
                                        <td><%= rsList.getObject("brazo") != null ? rsList.getDouble("brazo") : "-" %></td>
                                        <td><%= rsList.getObject("muslo") != null ? rsList.getDouble("muslo") : "-" %></td>
                                        <td><%= rsList.getObject("imc") != null ? rsList.getDouble("imc") : "-" %></td>
                                        <td><%= rsList.getString("observaciones") %></td>
                                    </tr>
                        <%
                                }
                            } catch (Exception e) {
                        %>
                                <tr><td colspan="20" style="color: red;">Error cargando mediciones: <%= e.getMessage() %></td></tr>
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
