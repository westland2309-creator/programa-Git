<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DEXONEFIT - Sistema Integral de Gestión</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            display: flex;
            min-height: 100vh;
        }
        
        /* BARRA LATERAL IZQUIERDA TIPO ACORDEÓN */
        .sidebar {
            width: 310px;
            background: #1f2937;
            color: white;
            padding: 20px 12px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            overflow-y: auto;
            border-right: 1px solid #374151;
        }
        .sidebar-brand {
            font-size: 20px;
            font-weight: bold;
            color: #00a86b;
            margin-bottom: 25px;
            text-align: center;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 8px;
        }
        
        /* GRUPOS DE ACORDEÓN */
        .acordeon-grupo {
            margin-bottom: 12px;
            border-radius: 8px;
            overflow: hidden;
            background: #2d3748;
        }
        .acordeon-header {
            width: 100%;
            background: #2d3748;
            color: white;
            padding: 12px 14px;
            font-size: 12px;
            font-weight: bold;
            text-align: left;
            border: none;
            cursor: pointer;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: background 0.2s;
            letter-spacing: 0.3px;
        }
        .acordeon-header:hover {
            background: #374151;
            color: #00a86b;
        }
        
        /* CONTENIDO DESPLEGABLE */
        .acordeon-content {
            display: none;
            background: #1a202c;
            padding: 8px 10px;
        }
        .acordeon-content.abierto {
            display: block;
        }
        
        .menu-item {
            display: flex;
            align-items: center;
            gap: 10px;
            color: #d1d5db;
            padding: 10px 12px;
            border-radius: 6px;
            text-decoration: none;
            font-size: 13px;
            margin-bottom: 4px;
            transition: all 0.2s;
        }
        .menu-item:hover {
            background: #00a86b;
            color: white;
            transform: translateX(4px);
        }

        /* CONTENIDO PRINCIPAL ALINEADO ARRIBA */
        .main-content {
            flex: 1;
            padding: 15px 30px;
            overflow-y: auto;
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }
        
        /* TARJETA PRINCIPAL */
        .bienvenida-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            padding: 18px 25px;
            border: 1px solid #e5e7eb;
            width: 100%;
            max-width: 900px;
            text-align: center;
        }
        .bienvenida-card h2 {
            color: #1f2937;
            margin: 0 0 6px 0;
            font-size: 21px;
        }
        .bienvenida-card h2 span {
            color: #00a86b;
        }
        .bienvenida-card p {
            color: #4b5563;
            font-size: 13px;
            line-height: 1.4;
            margin-bottom: 15px;
        }

        /* CONTENEDOR DE VIDEO GIGANTE Y VERTICAL */
        .video-container {
            position: relative;
            width: 100%;
            max-width: 440px; /* Ancho ampliado */
            margin: 0 auto;
            height: 640px; /* Altura imponente para ocupar toda la vista vertical */
            background: #000;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
        }
        .video-container iframe {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border: none;
        }
    </style>
</head>
<body>

    <!-- MENÚ LATERAL IZQUIERDO CON ACORDEÓN -->
    <div class="sidebar">
        <div>
            <div class="sidebar-brand">
                🧠 DEXONEFIT 🚀
            </div>

            <!-- GRUPO 1: ADMINISTRACIÓN, USUARIOS Y MEMBRESÍAS -->
            <div class="acordeon-grupo">
                <button class="acordeon-header" onclick="toggleAcordeon('menu-admin')">
                    ⚙️ Administración, Usuarios y Membresías
                </button>
                <div id="menu-admin" class="acordeon-content abierto">
                    <a href="<%= request.getContextPath() %>/usuarios.jsp" class="menu-item">
                        <span>👥</span> Gestión de Usuarios
                    </a>
                    <a href="<%= request.getContextPath() %>/membresias.jsp" class="menu-item">
                        <span>💳</span> Membresías
                    </a>
                    <a href="<%= request.getContextPath() %>/promociones.jsp" class="menu-item">
                        <span>🏷️</span> Promociones y Novedades
                    </a>
                    <a href="<%= request.getContextPath() %>/comunicados.jsp" class="menu-item">
                        <span>📢</span> Comunicados
                    </a>
                </div>
            </div>

            <!-- GRUPO 2: SALUD, NUTRICIÓN Y COMPOSICIÓN CORPORAL -->
            <div class="acordeon-grupo">
                <button class="acordeon-header" onclick="toggleAcordeon('menu-salud')">
                    ❤️ Salud, Nutrición y Composición Corporal
                </button>
                <div id="menu-salud" class="acordeon-content">
                    <a href="<%= request.getContextPath() %>/calculos_nutricionales.jsp" class="menu-item">
                        <span>🥗</span> Cálculos Nutricionales
                    </a>
                    <a href="<%= request.getContextPath() %>/calculos_composicion.jsp" class="menu-item">
                        <span>📊</span> Cálculos de Composición
                    </a>
                    <a href="<%= request.getContextPath() %>/evaluacion_clinica.jsp" class="menu-item">
                        <span>🩺</span> Evaluación Clínica
                    </a>
                    <a href="<%= request.getContextPath() %>/evaluaciones_microbiota.jsp" class="menu-item">
                        <span>🦠</span> Evaluaciones de Microbiota
                    </a>
                    <a href="<%= request.getContextPath() %>/mediciones.jsp" class="menu-item">
                        <span>📏</span> Mediciones Corporales
                    </a>
                </div>
            </div>

            <!-- GRUPO 3: ENTRENAMIENTO, RUTINAS Y RENDIMIENTO -->
            <div class="acordeon-grupo">
                <button class="acordeon-header" onclick="toggleAcordeon('menu-entrenamiento')">
                    🏋️‍♂️ Entrenamiento, Rutinas y Rendimiento
                </button>
                <div id="menu-entrenamiento" class="acordeon-content">
                    <a href="<%= request.getContextPath() %>/ejercicios.jsp" class="menu-item">
                        <span>📋</span> Catálogo de Ejercicios
                    </a>
                    <a href="<%= request.getContextPath() %>/entrenamientos.jsp" class="menu-item">
                        <span>⚡</span> Gestión de Entrenamientos
                    </a>
                    <a href="<%= request.getContextPath() %>/volumen_entrenamiento.jsp" class="menu-item">
                        <span>📈</span> Volumen de Entrenamiento
                    </a>
                </div>
            </div>

        </div>
        
        <div style="font-size: 11px; color: #9ca3af; text-align: center; margin-top: 20px;">
            SENA / DEXONEFIT © 2026
        </div>
    </div>

    <!-- PANTALLA PRINCIPAL CON MENSAJE Y VIDEO SÚPER GRANDE -->
    <div class="main-content">
        <div class="bienvenida-card">
            <h2>Panel de Control <span>DEXONEFIT</span></h2>
            <p>Sistema integral de gestión para el entrenamiento personalizado, la biomecánica clínica y la nutrición basada en evidencia.</p>

            <div class="video-container">
                <iframe src="https://www.youtube.com/embed/qToKj1zpNVM" title="YouTube Short DEXONEFIT" allowfullscreen></iframe>
            </div>
        </div>
    </div>

    <script>
        function toggleAcordeon(idMenu) {
            const contenido = document.getElementById(idMenu);
            const estaAbierto = contenido.classList.contains('abierto');
            
            if (estaAbierto) {
                contenido.classList.remove('abierto');
            } else {
                contenido.classList.add('abierto');
            }
        }
    </script>

</body>
</html>