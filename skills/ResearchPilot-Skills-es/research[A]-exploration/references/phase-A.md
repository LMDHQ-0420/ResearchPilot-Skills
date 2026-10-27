# Flujo detallado de A: Exploración de líneas de investigación

## Descarga de artículos

El mismo procedimiento se aplica a descargas del flujo y al comando independiente `/research[A]-exploration download-paper descripción [--to "ruta"]`.

Entrada: título, identificador arXiv/OpenReview o URL. Destino predeterminado: `docs/papers/`; `--to` permite el destino autorizado indicado.

1. Detecta arXiv: ID de formato `^[0-9]{4}\.[0-9]{4,5}(v[0-9]+)?$` o URL `arxiv.org/abs/` o `/pdf/`. Si solo hay título, busca en `https://export.arxiv.org/api/query?search_query=ti:{título-codificado}&max_results=1`.
2. Obtén el título oficial mediante `https://export.arxiv.org/api/query?id_list={id}`. Normaliza saltos y espacios, y decodifica entidades. PDF: `https://arxiv.org/pdf/{id}`.
3. Si no se encuentra, prueba OpenReview: extrae `id=` de la URL o usa el ID de foro. Para título, consulta `https://api2.openreview.net/notes?content.title={título-codificado}&limit=1`, con alternativa API v1 `https://api.openreview.net/notes`. Obtén el foro y título oficial con `?forum={id}&limit=1`. El título puede ser cadena o campo `value`.
4. PDF: `https://openreview.net/pdf?id={id}`.
5. Guarda con el título oficial completo y extensión `.pdf`, eliminando caracteres de nombre de archivo inválidos: barras, dos puntos, asterisco, interrogación, comillas, menor/mayor y barra vertical. Si falta título, usa la entrada.
6. Informa éxito o causa concreta del fallo. Tras éxito, entrega la ruta completa.

El comando independiente funciona en cualquier fase y no depende del estado del flujo.

Si falla dentro del flujo:
- indica qué artículos faltan y si puedes acceder al resumen;
- pide al usuario que coloque el PDF en `docs/papers/` con el título completo;
- si no proporciona PDF y tienes resumen, guarda `{título completo}.txt`;
- si tampoco hay resumen, marca la cita `⚠️ [confianza baja: PDF y resumen no disponibles]`.

## Principio de lectura

Antes de generar o revisar cualquier idea, incluida una vuelta desde D/E:
- lee primero con detenimiento los artículos pertinentes ya descargados;
- busca más solo si no respaldan la decisión actual o no responden a una pregunta nueva;
- para ampliar: buscar → confirmar lista → descargar → leer;
- cada decisión clave necesita fuente mediante `>` y número de cita; lo no respaldado va a pendientes o se marca con confianza baja.

## Activación

Entrada `/research descripción`, `/research --papers ...` o el comando A.
Sin contenido, solicita la línea de interés con un ejemplo: «Quiero trabajar en predicción del SOH de baterías; los Transformer actuales no aprovechan rasgos locales».

## Tarjeta compartida de A/B

```text
━━━━━━━━━━ Contenido confirmado ━━━━━━━━━━
Línea de investigación: {confirmada}
RQ principal: {confirmada}
RQ secundarias: {confirmadas}
Restricciones de la línea: {confirmadas}
Restricciones de las RQ: {confirmadas}
Artículos de referencia: {exigidos por el usuario}
Marco técnico: {solo B, confirmado}
Procedimiento: {solo B, confirmado}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

Solo campos confirmados y no vacíos; omite líneas completas sin contenido. No escribas «pendiente» ni «ninguno». Si todavía no hay consenso, omite toda la tarjeta. Texto simple, sin negrita, entre líneas de `━`.
No incluyas candidatos no confirmados ni la lista de búsqueda; los artículos son solo los exigidos por el usuario.
Mantén sincronización con la sección A de requisitos. Primero actualiza el archivo, después la tarjeta.

## A-1: Interpretar y recopilar

Extrae línea, ideas, artículos y restricciones.
Si falta detalle, reúne en una intervención:
1. Problema central de los métodos existentes.
2. Perspectiva desde la que abordarlo.
3. Artículos preferidos.
4. Otras restricciones, por ejemplo una GPU.
Registra separadamente restricciones de línea y de RQ.

## A-2: Búsqueda inicial

Prioriza publicaciones de referencia: NeurIPS, ICML, ICLR, CVPR, ECCV, ICCV, ACL, EMNLP, KDD, IEEE TII, IEEE TNNLS, etc.
Puedes descargar arXiv, pero cita los datos de publicación formal.
Objetivo: ≥15 referencias válidas. Cada laguna necesita ≥2 artículos; revisa la cobertura y amplía hasta 3 rondas.
Si quedan menos de 15, informa del número y causa (campo emergente, intersección, cobertura limitada) y confirma si continuar con lo encontrado o cambiar estrategia.

## A-3: Confirmar lista

Presenta:

| Nº | Título | Publicación y año | Versión arXiv | Resumen | Relevancia |
|---|---|---|---|---|---|
| {n} | {título} | {datos} | {ID o N/A} | {qué hace, una frase} | {relación con la línea, una frase} |

El usuario puede añadir o eliminar artículos. Espera confirmación antes de descargar.

## A-4: Descargar e informar

Ejecuta las descargas confirmadas y presenta éxitos y fallos por título, disponibilidad del resumen y ubicación para completar manualmente. Si hay fallos, pregunta si se completarán manualmente y continúa según la respuesta.

## A-4.5: Explicaciones detalladas

Una vez completadas las descargas, incluidas las aportadas manualmente, ofrece explicar cada artículo en cuatro puntos:
- problema;
- método y motivo del diseño;
- rendimiento;
- relevancia para nuestra investigación.

Registra sí/no en requisitos. Independientemente de la elección, las fichas de trabajos incluyen todos los descargados y marcan si son clave.

## A-5: Delimitar el problema

No presentes cinco líneas de golpe para elegir.
1. Informa del problema y objetivo del campo, familias de métodos y 2–3 sublíneas activas en los últimos dos años. Pregunta cuál interesa.
2. Discute 1–2 candidatas cada vez: idea, base bibliográfica, innovación, dificultades y evaluación de novedad.
3. Cuando el usuario elija una, regístrala y actualiza la tarjeta.

## A-6: Confirmar RQ por niveles

| Nivel | Pregunta | Función | Validación |
|---|---|---|---|
| RQ1 | Central | Problema general del campo | Experimento principal |
| RQ2 | Mecanismo | Obstáculo de los métodos actuales | Ablaciones |
| RQ3 | Límites, opcional | Condiciones, alcance y generalización | Experimentos complementarios |

Confirma cada nivel antes del siguiente; no presentes todos simultáneamente.

RQ1: pregunta general completa, por ejemplo «¿Cómo mejorar la precisión del SOH?». Expón laguna con [n], búsqueda de novedad y experimento previsto. Ajusta hasta confirmar.

RQ2: pregunta mecanística, por ejemplo «¿Son los rasgos temporales locales el obstáculo central?». Explica relación con RQ1, investigación previa [n] y ablación que lo prueba. Ajusta hasta confirmar. La respuesta fundamenta el método que resolverá RQ1.

RQ3: ofrece una pregunta de alcance, por ejemplo generalización entre químicas de baterías o dominios de RAG. Explica relación con RQ1/RQ2 y experimento complementario. Confirma si incluirla; puede omitirse cuando el alcance ya esté bien delimitado.

Registra cada confirmación y refresca tarjeta.
Después, elabora y confirma el argumento de necesidad práctica, teórica y temporal, con citas en los tres puntos.

## A-7: Compilar y revisar parte 1

- Motivación: contexto y fuentes; termina con los tres argumentos de necesidad.
- RQ: introducción, RQ1, RQ2 y RQ3 si procede; laguna, novedad o mecanismo y experimento.
- Trabajos clave: tabla de unos 5–8 y fichas de todos los descargados según A-4.5.

Muestra la parte 1 completa, resume motivación, RQ y total de artículos/claves, y pregunta si es correcta y completa.
Solo tras confirmación remite a `/research[B]-idea`; no regeneres lo ya confirmado al compilar en B-0.
