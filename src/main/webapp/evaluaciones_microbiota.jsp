<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evaluación de Salud Intestinal y Microbiota - DEXONEFIT</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            padding: 30px 20px;
        }
        .contenedor {
            max-width: 900px;
            margin: 0 auto;
        }
        .barra-navegacion {
            margin-bottom: 20px;
        }
        .btn-volver {
            display: inline-flex;
            align-items: center;
            background: #00a86b;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            font-size: 14px;
            box-shadow: 0 2px 6px rgba(0,168,107,0.2);
            transition: all 0.2s ease;
        }
        .btn-volver:hover {
            background: #008f5a;
            transform: translateY(-2px);
        }
        .header-seccion h2 {
            color: #00a86b;
            margin: 0 0 25px 0;
            font-size: 24px;
        }
        .card-formulario {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            padding: 30px;
            border: 1px solid #e9ecef;
            margin-bottom: 20px;
        }
        .form-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
            gap: 20px;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            color: #333;
            margin-bottom: 6px;
            font-size: 13px;
        }
        .form-control {
            width: 100%;
            padding: 10px 12px;
            border: 1px solid #cbd5e1;
            border-radius: 8px;
            font-size: 14px;
            background-color: #fff;
            transition: border-color 0.2s, box-shadow 0.2s;
        }
        .form-control:focus {
            outline: none;
            border-color: #00a86b;
            box-shadow: 0 0 0 3px rgba(0,168,107,0.15);
        }
        select.form-control {
            cursor: pointer;
        }
        .btn-guardar {
            background: #00a86b;
            color: white;
            border: none;
            padding: 12px 25px;
            font-size: 15px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            transition: background 0.2s;
            box-shadow: 0 4px 10px rgba(0,168,107,0.2);
            margin-top: 15px;
        }
        .btn-guardar:hover {
            background: #008f5a;
        }

        /* TARJETA DE RESULTADO / PROTOCOLO META */
        .card-resultado {
            display: none;
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0,0,0,0.08);
            padding: 25px;
            border: 1px solid #d1d5db;
            margin-top: 20px;
        }
        .titulo-principal-protocolo {
            font-size: 16px;
            font-weight: bold;
            color: #1f2937;
            margin-bottom: 15px;
        }
        .recuperacion-habitos {
            font-size: 14px;
            color: #1f2937;
            background: #f3f4f6;
            padding: 14px;
            border-radius: 6px;
            margin-bottom: 15px;
            border-left: 4px solid #00a86b;
            line-height: 1.5;
        }
        .caja-interna-protocolo {
            background: #fdf8f6;
            border: 1px solid #f1d3ce;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 15px;
        }
        .subtitulo-caja {
            font-size: 15px;
            font-weight: bold;
            color: #991b1b;
            margin-bottom: 12px;
        }
        .seccion-item {
            font-size: 14px;
            color: #374151;
            margin-bottom: 10px;
            line-height: 1.5;
        }
        .titulo-seccion-item {
            font-weight: bold;
            color: #111827;
            display: block;
            margin-bottom: 4px;
        }
        .pie-cientifico-protocolo {
            font-size: 12px;
            color: #4b5563;
            border-top: 1px solid #e5e7eb;
            padding-top: 12px;
            margin-top: 10px;
        }
        .badge-fuente {
            display: inline-block;
            background: #e0f2fe;
            color: #0369a1;
            padding: 6px 12px;
            border-radius: 6px;
            font-weight: bold;
            font-size: 12px;
            text-decoration: none;
            transition: background 0.2s;
        }
        .badge-fuente:hover {
            background: #bae6fd;
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <div class="contenedor">
        <div class="barra-navegacion">
            <a href="index.jsp" class="btn-volver">
                <span>🏠</span> Menú Principal (DEXONEFIT)
            </a>
        </div>

        <div class="header-seccion">
            <h2>🦠 Evaluación de Salud Intestinal, Microbiota y Recomendaciones - DEXONEFIT</h2>
        </div>

        <div class="card-formulario">
            <form id="formMicrobiota" onsubmit="procesarEvaluacionMicrobiota(event)">
                
                <div class="form-grid">
                    <div class="form-group">
                        <label for="usuario">ID o Nombre del Usuario:</label>
                        <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ej. 101 o Juan Pérez" required>
                    </div>

                    <div class="form-group">
                        <label for="agua">Consumo de Agua Diario (Litros):</label>
                        <input type="number" step="0.1" id="agua" name="agua" class="form-control" placeholder="Ej. 2.5" required>
                    </div>

                    <div class="form-group">
                        <label for="frutas">Porciones de Frutas y Verduras / Día:</label>
                        <input type="number" id="frutas" name="frutas" class="form-control" placeholder="Ej. 4" required>
                    </div>

                    <div class="form-group">
                        <label for="evacuaciones">Consistencia de Evacuaciones (Bristol):</label>
                        <select id="evacuaciones" name="evacuaciones" class="form-control" required>
                            <option value="">Seleccione...</option>
                            <option value="Tipo 1-2 (Estreñimiento)">Tipo 1-2 (Estreñimiento / Duras)</option>
                            <option value="Tipo 3-4 (Ideal)">Tipo 3-4 (Ideal / Óptimas)</option>
                            <option value="Tipo 5-7 (Tránsito Acelerado)">Tipo 5-7 (Tránsito Acelerado / Diarreicas)</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="distension">¿Presenta Distensión Abdominal?:</label>
                        <select id="distension" name="distension" class="form-control" required>
                            <option value="No">No</option>
                            <option value="Leve / Ocasional">Leve / Ocasional</option>
                            <option value="Moderada / Frecuente">Moderada / Frecuente</option>
                            <option value="Severa / Diaria">Severa / Diaria</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="estreñimiento">Nivel de Estreñimiento:</label>
                        <select id="estreñimiento" name="estreñimiento" class="form-control" required>
                            <option value="Ninguno">Ninguno</option>
                            <option value="Leve">Leve</option>
                            <option value="Moderado">Moderado</option>
                            <option value="Severo">Severo</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="kefir">¿Consume Alimentos Fermentados (Kéfir)?:</label>
                        <select id="kefir" name="kefir" class="form-control" required>
                            <option value="Diario">Sí, a diario</option>
                            <option value="Ocasional">Ocasionalmente</option>
                            <option value="No">No consume</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="ultraprocesados">Consumo de Ultraprocesados:</label>
                        <select id="ultraprocesados" name="ultraprocesados" class="form-control" required>
                            <option value="Bajo / Nulo">Bajo / Nulo</option>
                            <option value="Moderado">Moderado</option>
                            <option value="Alto">Alto</option>
                        </select>
                    </div>
                </div>

                <div class="form-group" style="margin-top: 15px;">
                    <label for="recomendaciones_manual">Recomendaciones y Protocolo Funcional (Generado por el Meta):</label>
                    <textarea id="recomendaciones_manual" name="recomendaciones_manual" class="form-control" rows="3" placeholder="Se autocompletará con base en el análisis de microbiota..."></textarea>
                </div>

                <button type="submit" class="btn-guardar">Generar Protocolo y Guardar Evaluación</button>

            </form>
        </div>

        <!-- TARJETA DE RESULTADO CIENTÍFICO (META DEXONEFIT) -->
        <div id="seccionResultado" class="card-resultado">
            <div class="titulo-principal-protocolo">
                🦠 Protocolo de Salud Intestinal y Microbiota (Meta DEXONEFIT)
            </div>

            <div class="recuperacion-habitos" id="resHabitos">
                <strong>Soporte Funcional:</strong> Modulación de la permeabilidad intestinal y aumento de ácidos grasos de cadena corta (AGCC).
            </div>

            <div class="caja-interna-protocolo">
                <div class="subtitulo-caja">
                    🌿 Pautas Nutricionales y Modulación de Microbiota (Kéfir, Cúrcuma, Jengibre)
                </div>

                <div class="seccion-item">
                    <span class="titulo-seccion-item">🧪 Acciones Directas (Haz esto):</span>
                    <span id="resAcciones">- Incrementar gradualmente la ingesta de fibra prebiótica e incorporar kéfir en ayunas.<br>- Uso de infusión de jengibre y cúrcuma con pimienta negra post-entreno para modular la inflamación sistémica.</span>
                </div>

                <div class="seccion-item" style="margin-top: 12px;">
                    <span class="titulo-seccion-item">🚫 Alimentos / Hábitos a Evitar Temporalmente:</span>
                    <span id="resEvitarMicrobiota">- Reducir azúcares refinados, edulcorantes artificiales y alimentos ultraprocesados que alteren la disbiosis.</span>
                </div>

                <div class="seccion-item" style="margin-top: 12px;">
                    <span id="resDirectrizMicrobiota">💡 Directriz DEXONEFIT: Un eje intestinal íntegro optimiza la absorción de aminoácidos y la supercompensación muscular.</span>
                </div>
            </div>

            <div class="pie-cientifico-protocolo">
                <div style="margin-bottom: 8px;">
                    <strong>Evidencia científica de respaldo (PubMed):</strong>
                </div>
                <div style="margin-bottom: 10px;">
                    <a href="https://pubmed.ncbi.nlm.nih.gov/30291170/" target="_blank" class="badge-fuente" id="resEnlacePubmedMicrobiota">📖 Ver estudio sobre Microbiota y Rendimiento en PubMed ↗️</a>
                </div>
                <div><span id="resEstudioTituloMicrobiota">Gut Microbes / Nutrients: Intestinal Microbiota Modulation, Fermented Foods (Kefir) and Systemic Inflammation.</span></div>
                <span style="color: #6b7280; font-style: italic; margin-top: 4px; display: block;" id="resSubMetaMicrobiota">Basado en modulación de la microbiota intestinal, integridad de la barrera epitelial y control de la endotoxemia metabólica.</span>
            </div>
        </div>

    </div>

    <script>
        function procesarEvaluacionMicrobiota(event) {
            event.preventDefault();

            const agua = parseFloat(document.getElementById("agua").value);
            const frutas = parseInt(document.getElementById("frutas").value);
            const evacuaciones = document.getElementById("evacuaciones").value;
            const distension = document.getElementById("distension").value;
            const kefir = document.getElementById("kefir").value;
            const ultra = document.getElementById("ultraprocesados").value;

            let habitosTexto = "<strong>Soporte Funcional:</strong> Modulación de la permeabilidad intestinal y aumento de la diversidad microbiana.";
            let accionesTexto = "- Incorporar kéfir de leche o agua en ayunas (200ml) para aportación de probióticos viables.<br>- Añadir cúrcuma con una pizca de pimienta negra y jengibre en las preparaciones para reducir la inflamación de bajo grado.";
            let evitarTexto = "- Evitar azúcares libres, harinas refinadas y exceso de edulcorantes artificiales que promueven bacterias proinflamatorias.";
            let directrizTexto = "💡 Directriz DEXONEFIT: La salud de la mucosa intestinal es el pilar fundamental para una correcta asimilación de nutrientes y síntesis proteica.";
            let pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/28984951/";
            let estudioTitulo = "Frontiers in Microbiology / Gut Microbes: Dietary Modulation of Gut Microbiota and Health Outcomes.";
            let subMeta = "Basado en la modulación del eje intestino-músculo y la integridad de la barrera epitelial.";

            // Lógica inteligente según la valoración del usuario
            if (evacuaciones.includes("Estreñimiento") || distension.includes("Severa") || distension.includes("Moderada")) {
                habitosTexto = "<strong>Protocolo de Corrección de Tránsito y Distensión:</strong> Alta prioridad en hidratación, ácidos grasos de cadena corta y soporte simbiótico.";
                accionesTexto = "- Aumentar gradualmente el consumo de agua por encima de los 3 litros diarios.<br>- Protocolo diario de kéfir en ayunas y digestivos a base de jengibre.<br>- Incrementar fuentes de fibra soluble (avena estabilizada, semillas de chía hidratadas).";
                evitarTexto = "- Suspender temporalmente alimentos altamente fermentables (FODMAPs en exceso) si la distensión es aguda, junto con ultraprocesados.";
                pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/32012468/";
                estudioTitulo = "Nutrients: Gut Microbiota, Fermented Foods and Clinical Management of Functional Gastrointestinal Disorders.";
            } else if (kefir === "No") {
                accionesTexto = "- Incorporar kéfir de manera progresiva (empezar con 50ml) para evitar molestias gástricas iniciales y repoblar cepas lactobacilares.<br>- Mantener consumo diario de especias antiinflamatorias (cúrcuma y jengibre).";
            }

            // Autocompletar el campo de texto del formulario
            document.getElementById("recomendaciones_manual").value = "Acciones: " + accionesTexto.replace(/<br>/g, " ");

            // Mostrar la tarjeta de resultados científicios
            document.getElementById("resHabitos").innerHTML = habitosTexto;
            document.getElementById("resAcciones").innerHTML = accionesTexto;
            document.getElementById("resEvitarMicrobiota").innerHTML = evitarTexto;
            document.getElementById("resDirectrizMicrobiota").innerHTML = directrizTexto;
            document.getElementById("resEnlacePubmedMicrobiota").href = pubmedUrl;
            document.getElementById("resEstudioTituloMicrobiota").textContent = estudioTitulo;
            document.getElementById("resSubMetaMicrobiota").textContent = subMeta;

            const tarjeta = document.getElementById("seccionResultado");
            tarjeta.style.display = "block";
            tarjeta.scrollIntoView({ behavior: 'smooth' });
        }
    </script>

</body>
</html>