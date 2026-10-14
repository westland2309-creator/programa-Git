<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Evaluación Clínica y Biomecánica - DEXONEFIT</title>
    <style>
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f2f4f7;
            padding: 30px 20px;
        }
        .contenedor {
            max-width: 850px;
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
            font-size: 26px;
        }
        .card-formulario {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.05);
            padding: 30px;
            border: 1px solid #e9ecef;
            margin-bottom: 20px;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            display: block;
            font-weight: bold;
            color: #333;
            margin-bottom: 8px;
            font-size: 14px;
        }
        .form-control {
            width: 100%;
            padding: 12px 15px;
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
            font-size: 16px;
            font-weight: bold;
            border-radius: 8px;
            cursor: pointer;
            width: 100%;
            transition: background 0.2s, transform 0.1s;
            box-shadow: 0 4px 10px rgba(0,168,107,0.2);
            margin-top: 10px;
        }
        .btn-guardar:hover {
            background: #008f5a;
        }

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
        .recuperacion-habitos {
            font-size: 14px;
            color: #1f2937;
            background: #f3f4f6;
            padding: 12px;
            border-radius: 6px;
            margin-bottom: 15px;
            border-left: 4px solid #00a86b;
            line-height: 1.5;
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
            <a href="<%= request.getContextPath() %>/index.jsp" class="btn-volver">
                <span>🏠</span> Menú Principal
            </a>
        </div>

        <div class="header-seccion">
            <h2>Evaluación Clínica y Biomecánica - DEXONEFIT</h2>
        </div>

        <div class="card-formulario">
            <form id="formClinica" onsubmit="procesarEvaluacion(event)">
                
                <div class="form-group">
                    <label for="usuario">ID o Nombre del Usuario / Cliente:</label>
                    <input type="text" id="usuario" name="usuario" class="form-control" placeholder="Ej. 101 o Juan Pérez" required>
                </div>

                <div class="form-group">
                    <label for="tipo_registro">Categoría del Registro:</label>
                    <select id="tipo_registro" name="tipo_registro" class="form-control" onchange="actualizarOpciones()">
                        <option value="Patologia">Patologías y Condiciones Frecuentes</option>
                        <option value="Lesion">Lesión Musculoesquelética</option>
                        <option value="FactorRiesgo">Factores de Riesgo</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="nombre_condicion">Seleccionar o Escribir Condición / Diagnóstico:</label>
                    <select id="select_sugerencias" class="form-control" style="margin-bottom: 10px;" onchange="document.getElementById('nombre_condicion').value = this.value;">
                        <option value="">-- Seleccione una opción frecuente o escriba abajo --</option>
                    </select>
                    <input type="text" id="nombre_condicion" name="nombre_condicion" class="form-control" placeholder="Ej. Dolor lumbar / Hipertensión arterial" required>
                </div>

                <div class="form-group">
                    <label for="zona_afectada">Zona Anatómica Afectada:</label>
                    <input type="text" id="zona_afectada" name="zona_afectada" class="form-control" placeholder="Ej. Columna lumbar, Rodilla derecha, Hombro">
                </div>

                <div class="form-group">
                    <label for="tipo_lesion">Clasificación o Mecanismo (Tipo):</label>
                    <input type="text" id="tipo_lesion" name="tipo_lesion" class="form-control" placeholder="Ej. Sobrecarga mecánica / Crónico / Agudo">
                </div>

                <div class="form-group">
                    <label for="nivel_o_dolor">Nivel de Dolor o Severidad:</label>
                    <input type="text" id="nivel_o_dolor" name="nivel_o_dolor" class="form-control" placeholder="Ej. Moderado (5/10)">
                </div>

                <div class="form-group">
                    <label for="estado">Estado Actual:</label>
                    <select id="estado" name="estado" class="form-control">
                        <option value="Activo (En tratamiento / Precaución)">Activo (En tratamiento / Precaución)</option>
                        <option value="En Observación">En Observación</option>
                        <option value="Superado / Recuperado">Superado / Recuperado</option>
                    </select>
                </div>

                <div class="form-group">
                    <label for="fecha">Fecha de Evaluación:</label>
                    <input type="date" id="fecha" name="fecha" class="form-control" required>
                </div>

                <button type="submit" class="btn-guardar">Guardar Registro de Patología</button>

            </form>
        </div>

        <!-- TARJETA DE RESULTADO -->
        <div id="seccionResultado" class="card-resultado">
            <div class="titulo-principal-protocolo">
                🔴 Protocolo Clínico y Recomendaciones del Meta (DEXONEFIT)
            </div>

            <div class="recuperacion-habitos" id="resHabitos">
                <strong>Recuperación y Hábitos:</strong> Control riguroso de la relación descanso-estrés y soporte intestinal para garantizar óptima supercompensación.
            </div>

            <div class="caja-interna-protocolo">
                <div class="subtitulo-caja">
                    🔴 Recomendaciones para cada patología, lesión o factor de riesgo (Meta DEXONEFIT)
                </div>

                <div class="seccion-item">
                    <span class="titulo-seccion-item">🔴 Ejercicios a Suspender / Evitar:</span>
                    <span id="resEvitar">- Movimientos balísticos o cargas que comprometan la integridad articular o generen dolor agudo.</span>
                </div>

                <div class="seccion-item" style="margin-top: 12px;">
                    <span class="titulo-seccion-item">✅ Ejercicios Recomendados (Haz esto):</span>
                    <span id="resHacer">- Patrones fundamentales de empuje, tracción y miembros inferiores adaptados al nivel del usuario.<br>- Monitoreo constante de la percepción subjetiva del esfuerzo (RPE).</span>
                </div>

                <div class="seccion-item" style="margin-top: 12px;">
                    <span id="resDirectriz">💡 Directriz DEXONEFIT: Priorizar la técnica, la recuperación y la individualización de la carga.</span>
                </div>
            </div>

            <div class="pie-cientifico-protocolo">
                <div style="margin-bottom: 8px;">
                    <strong>Evidencia de respaldo:</strong>
                </div>
                <div style="margin-bottom: 10px;">
                    <a href="https://pubmed.ncbi.nlm.nih.gov/" target="_blank" class="badge-fuente" id="resEnlacePubmed">📖 Ver estudio en PubMed ↗️</a>
                </div>
                <div><span id="resEstudioTitulo">Exercise and Sport Sciences Reviews: Clinical Biomechanics and Tissue Adaptation.</span></div>
                <span style="color: #6b7280; font-style: italic; margin-top: 4px; display: block;" id="resSubMeta">Basado en rigor científico, control endocrino-metabólico (SOMP/Tiroides), modulación de la microbiota (kéfir) y biomecánica clínica.</span>
            </div>
        </div>

    </div>

    <script>
        const opcionesFrecuentes = {
            "Patologia": [
                "Dolor lumbar", "Hernia discal", "Protrusión discal", "Escoliosis", "Espondilosis", "Espondilolistesis",
                "Dolor patelofemoral", "Artrosis de rodilla", "Tendinopatía rotuliana", "Lesión meniscal", "Lesión del ligamento cruzado anterior (LCA)",
                "Tendinopatía del manguito rotador", "Síndrome de pinzamiento subacromial",
                "Artrosis de cadera", "Bursitis trocantérica",
                "Diabetes tipo 2", "Prediabetes", "Obesidad", "Síndrome metabólico", "Dislipidemia",
                "Hipertensión arterial", "Osteoporosis", "Fibromialgia"
            ],
            "Lesion": [
                "Tendinitis rotuliana", "Tendinitis del manguito rotador", "Esguince de tobillo grado I/II",
                "Lumbalgia mecánica crónica", "Condromalacia rotuliana", "Rotura fibrilar en Isquiotibiales", "Desgarro muscular parcial"
            ],
            "FactorRiesgo": [
                "Hipertensión arterial (Riesgo)", "Sedentarismo", "Obesidad abdominal", "Resistencia a la insulina",
                "Mala técnica de ejercicio", "Déficit de movilidad", "Desequilibrios musculares", "Entrenamiento excesivo"
            ]
        };

        function actualizarOpciones() {
            const tipo = document.getElementById("tipo_registro").value;
            const selectSugerencias = document.getElementById("select_sugerencias");
            
            selectSugerencias.innerHTML = '<option value="">-- Seleccione una opción frecuente o escriba abajo --</option>';
            
            if (opcionesFrecuentes[tipo]) {
                opcionesFrecuentes[tipo].forEach(item => {
                    let opt = document.createElement("option");
                    opt.value = item;
                    opt.textContent = item;
                    selectSugerencias.appendChild(opt);
                });
            }
        }

        function procesarEvaluacion(event) {
            event.preventDefault();

            const condicionTexto = document.getElementById("nombre_condicion").value;
            const condicion = condicionTexto.toLowerCase();
            
            let habitosTexto = "<strong>Recuperación y Hábitos:</strong> Control riguroso de la relación descanso-estrés y soporte intestinal para garantizar óptima supercompensación.";
            let evitarTexto = "- Movimientos balísticos o cargas que comprometan la integridad articular o generen dolor agudo.";
            let hacerTexto = "- Patrones fundamentales de empuje, tracción y miembros inferiores adaptados al nivel del usuario.<br>- Monitoreo constante de la percepción subjetiva del esfuerzo (RPE).";
            let directrizTexto = "💡 Directriz DEXONEFIT: Priorizar la técnica, la recuperación y la individualización de la carga.";
            let pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/?term=clinical+biomechanics+exercise+prescription";
            let estudioTitulo = "Exercise and Sport Sciences Reviews: Clinical Biomechanics and Tissue Adaptation.";
            let subMeta = "Basado en rigor científico, control endocrino-metabólico (SOMP/Tiroides), modulación de la microbiota (kéfir) y biomecánica clínica.";

            if (condicion.includes("lumbar") || condicion.includes("hernia") || condicion.includes("protrusión")) {
                evitarTexto = "- Sentadillas libres pesadas, peso muerto convencional y giros con carga axial.<br>- Compresión axial excesiva sobre el anillo fibroso.";
                hacerTexto = "- Puentes de glúteo en suelo, planchas isométricas neutras y extensiones de espalda en máquina con soporte pélvico a baja intensidad.<br>- Enfoque en la estabilidad segmentaria.";
                directrizTexto = "💡 Directriz DEXONEFIT: Mantener la neutralidad de la columna y minimizar el cizallamiento discal.";
                pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/?term=Spine+Journal+clinical+biomechanics+spinal+loading+disc+pathology";
                estudioTitulo = "Spine Journal: Clinical Biomechanics of Spinal Loading and Exercise Alternatives in Disc Pathology.";
                subMeta = "Basado en modulación de la carga mecánica sobre el anillo fibroso y estabilidad segmentaria.";
            } else if (condicion.includes("rodilla") || condicion.includes("patelar") || condicion.includes("patelofemoral") || condicion.includes("meniscal") || condicion.includes("lca")) {
                evitarTexto = "- Sentadillas profundas libres sin control y saltos pliométricos de alto impacto en fase aguda.<br>- Torsiones con carga sobre la articulación.";
                hacerTexto = "- Extensiones de rodilla en máquina con rango seguro (90°-45°), prensa a 45 grados con pies altos y curl femoral tumbado.<br>- Control estricto del plano frontal.";
                directrizTexto = "💡 Directriz DEXONEFIT: Neutralizar el valgo dinámico y asegurar rangos articulares seguros sin fricción patelar excesiva.";
                pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/?term=JOSPT+patellofemoral+joint+biomechanics+rehabilitation";
                estudioTitulo = "Journal of Orthopaedic & Sports Physical Therapy (JOSPT): Patellofemoral Joint Biomechanics and Rehabilitation Guidelines.";
                subMeta = "Basado en la biomecánica clínica articular y adaptación tisular del cartílago y tendón.";
            } else if (condicion.includes("hombro") || condicion.includes("manguito") || condicion.includes("subacromial")) {
                evitarTexto = "- Press militar por detrás de la nuca, dominadas estrictas abiertas y press de banca pesado plano sin control escapular.";
                hacerTexto = "- Press en suelo con mancuernas (limitando el rango de descenso), elevaciones laterales en plano escapular y rotaciones externas con polea baja.";
                directrizTexto = "💡 Directriz DEXONEFIT: Cuidar el espacio subacromial y priorizar la retracción escapular.";
                pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/?term=rotator+cuff+tendinopathy+biomechanical+considerations+progressive+loading";
                estudioTitulo = "Journal of Shoulder and Elbow Surgery: Rotator Cuff Tendinopathy, Biomechanical Considerations and Progressive Loading.";
                subMeta = "Basado en la biomecánica del espacio subacromial y control escapulotorácico.";
            } else if (condicion.includes("hipertensión") || condicion.includes("cardiovascular")) {
                evitarTexto = "- Levantamientos submáximos o máximos con maniobra de Valsalva prolongada (apnea sostenida).";
                hacerTexto = "- Entrenamiento concurrente (fuerza moderada con RPE 4-6 y aeróbico continuo al 60-70% del VO2 máx).";
                directrizTexto = "💡 Directriz DEXONEFIT: Control hemodinámico estricto y prevención de picos pressóricos durante el esfuerzo.";
                pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/?term=resistance+exercise+hemodynamic+response+guidelines";
                estudioTitulo = "European Journal of Preventive Cardiology / AHA: Resistance Exercise and Hemodynamic Response Guidelines.";
                subMeta = "Basado en el control endocrino-metabólico y la regulación de la presión arterial por esfuerzo.";
            } else if (condicion.includes("diabetes") || condicion.includes("insulina") || condicion.includes("metabólico")) {
                evitarTexto = "- Sesiones largas de ejercicio sin carbohidratos de bajo índice glucémico previos o picos de sedentarismo postprandial.";
                hacerTexto = "- Hipertrofia funcional en máquinas guiadas y caminatas ligeras post-ingesta para captación inmediata de glucosa.";
                directrizTexto = "💡 Directriz DEXONEFIT: Optimización de la sensibilidad insulínica mediante masa muscular activa y soporte intestinal con kéfir.";
                habitosTexto = "<strong>Recuperación y Hábitos:</strong> Modulación mediante kéfir y especias antiinflamatorias (cúrcuma, jengibre) para reducir endotoxemia.";
                pubmedUrl = "https://pubmed.ncbi.nlm.nih.gov/?term=exercise+physical+activity+type+2+diabetes+position+statement";
                estudioTitulo = "Diabetes Care: Exercise and Physical Activity for Type 2 Diabetes, Position Statement.";
                subMeta = "Basado en la modulación de la microbiota (kéfir) y el consumo periférico de glucosa (GLUT-4).";
            }

            document.getElementById("resHabitos").innerHTML = habitosTexto;
            document.getElementById("resEvitar").innerHTML = evitarTexto;
            document.getElementById("resHacer").innerHTML = hacerTexto;
            document.getElementById("resDirectriz").innerHTML = directrizTexto;
            document.getElementById("resEnlacePubmed").href = pubmedUrl;
            document.getElementById("resEstudioTitulo").textContent = estudioTitulo;
            document.getElementById("resSubMeta").textContent = subMeta;

            const tarjeta = document.getElementById("seccionResultado");
            tarjeta.style.display = "block";
            tarjeta.scrollIntoView({ behavior: 'smooth' });
        }

        window.onload = function() {
            actualizarOpciones();
            const hoy = new Date().toISOString().split('T')[0];
            document.getElementById("fecha").value = hoy;
        };
    </script>

</body>
</html>