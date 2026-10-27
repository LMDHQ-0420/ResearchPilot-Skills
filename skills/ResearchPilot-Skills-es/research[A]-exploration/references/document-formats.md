# Formatos de documentos

Especificaciones para `idea_report.md`, `implementation.md` y `dev_log.md`. Presencia de capítulos y extensión: `template-flexibility.md`.

`code_guide.md` está obsoleto: diseño en `implementation.md`; entorno y ejecución en README.

## Semántica de Markdown

| Símbolo | Uso y restricciones |
|---|---|
| `#` | Título único |
| `## Parte 1`, `## Parte 2`, `## Parte 3` | Tres partes fijas; reconocer también los encabezados heredados `## Part 1`, `## Part 2`, `## Part 3` |
| `### 1`, `### 2`, `### 3` | Secciones principales; numeración reiniciada por parte |
| `#### 1.1`, `#### 1.2` | Subsecciones semánticas, ampliables |
| `##### 1.1.1` | Solo cuando haga falta |
| `>` | Explicación sencilla de fórmulas, decisiones, fuentes o conceptos difíciles; usar abundantemente tras el texto |
| `⚠️ [confianza baja: …]` | Al final de afirmaciones sin evidencia suficiente; registrar en pendientes |
| Código en línea | Archivos, funciones, variables y comandos |
| Bloque text | Flujo de datos o estructura |
| Bloque python | Pseudocódigo |
| `$$...$$`, `$...$` | Ecuaciones de bloque y en línea |
| Negrita | Primera aparición de términos clave y fila del método en tablas; máximo 5 palabras |
| Lista numerada | Reservada a las referencias en el informe final |
| `---` | Entre partes y antes de puntos de revisión |

Los encabezados se redactan en español por defecto, incluida «Referencias». Elimina los comentarios HTML de instrucciones de las plantillas en el informe final.

## Contenido del informe

### Parte 1

Motivación con contexto, limitaciones y relevancia, en párrafos académicos con fuentes. Termina con necesidad práctica, teórica y temporal; las tres necesitan respaldo, o marca confianza baja.

Introduce las RQ en 2–3 frases, unas 100 palabras orientativas. RQ1 define la meta y se prueba en el experimento principal; RQ2 explica el obstáculo y motiva el método, validado con ablaciones; RQ3 prueba límites con experimentos adicionales y es opcional. Las preguntas deben ser concretas y comprobables; si omites RQ3, explica por qué.

Trabajos clave: explica la selección. La tabla recoge unos 5–8 trabajos clave; las fichas incluyen TODOS los descargados. Nombres cortos consistentes, aportación y utilidad de unas 15 palabras en la tabla. Cada ficha indica por qué es o no clave. Respeta la elección de explicación detallada de A-4.5.

### Parte 2

Introducción académica sin subtítulos, unas 600–1000 palabras orientativas: importancia → limitaciones citadas → motivación → método → aportaciones. La aportación experimental queda provisional hasta disponer de cifras reales.

Trabajos relacionados: sintetiza familias, no enumeres artículos. La última subsección es siempre la laguna de investigación.

Método: marco general, intuición y flujo. La explicación sencilla 3.2 tiene un paso por módulo teórico posterior; no fórmulas ni jerga. Los módulos precisan entradas, salidas, operaciones y ecuaciones, con variables e intuición explicadas mediante `>`. Indica inspiración, extensión frente a la fuente y un fragmento breve verificable con sección. Termina siempre con métodos de referencia y métricas; cada selección tiene cita y justificación de equidad y relevancia.

### Parte 3

Sección 0: resultados directos de la lectura C-1 por método: datos, escala, particiones, experimentos, comparaciones, métricas, hiperparámetros y notas de código.
Después sintetiza convenciones de datos, métricas, ablaciones y resultados.
Verifica disponibilidad de datos/código; no suficiencia de GPU.
Datos: principales, reserva y herramienta estándar de preprocesamiento con enlace, o procedimiento estándar.

Carga experimental orientativa de publicaciones exigentes:
- al menos 2 conjuntos; recomendado 3–5, con distintas escalas o dominios;
- al menos 4 referencias; recomendado 5–8, con SOTA reciente y clásicos;
- una ablación por innovación; recomendado 3–6 variantes que cubran todo el diseño;
- todos los análisis habituales, más 1–3 extensiones elegidas;
- varias ejecuciones, con al menos 3 semillas y media ± desviación.

Cada experimento corresponde a una innovación o hipótesis. Las ablaciones aíslan todos los módulos. Los complementarios prueban propiedades diferentes al experimento principal. Usa el mismo conjunto de semillas.
Explica en el propósito cualquier imposibilidad de alcanzar estas orientaciones, sin convertir recursos en criterio previo de diseño.

Todos los experimentos siguen el formato común de la plantilla. «Por qué se diseña así» es obligatorio. Explica cada modelo individualmente, su diferencia y motivo de inclusión; identifica la referencia principal. La columna de artículo fuente solo informa y no determina la selección.
Los resultados previstos son hipótesis o casillas vacías; no datos obtenidos.

Separa análisis habituales obligatorios y extensiones del usuario. Estima recursos solo al final; son orientativos.

### Plantilla completa

````markdown
# Informe de idea: {línea de investigación}
> Generado: {YYYY-MM-DD} | Estado: PENDING_REVIEW

---

## Parte 1: Visión general

### 1 Motivación

{Contexto y motivación, con citas de trabajos clave}

> {Explicación complementaria en lenguaje sencillo}

**Por qué es necesaria esta investigación:**
- **Necesidad práctica**: {impacto concreto en aplicaciones} [n]
- **Necesidad teórica**: {laguna de conocimiento} [n]
- **Oportunidad temporal**: {por qué estudiarlo ahora} [n]

### 2 Preguntas de investigación

{De qué lagunas proceden las RQ y cómo se relacionan}

#### RQ1: Pregunta central

**RQ1: {pregunta completa}?**
- Laguna correspondiente: {limitación} [n]
- Novedad: {qué falta por responder}
- Experimento correspondiente: {validación principal}

#### RQ2: Pregunta de mecanismo

**RQ2: {pregunta completa sobre el obstáculo técnico}?**
- Relación con RQ1: {cómo fundamenta el diseño}
- Laguna correspondiente: {análisis previo} [n]
- Experimento correspondiente: {ablación}

#### RQ3: Pregunta de límites, opcional

**RQ3: {pregunta de alcance o generalización}?**
- Relación con RQ1/RQ2: {alcance de las conclusiones}
- Experimento correspondiente: {análisis adicional}

### 3 Trabajos clave

{Lógica de selección y categorías cubiertas}

| Nombre abreviado | Publicación | Año | Aportación principal | Utilidad para esta investigación |
|---|---|---|---|---|
| {nombre} | {revista/congreso} | {año} | {aportación} | {qué aprovechar} |

#### {Nombre abreviado} ({Publicación} {Año}) [n]

{Si se eligió explicación detallada: problema; método y motivo del diseño; rendimiento; relevancia para esta investigación. Si no, aportación en una frase. Repetir para TODOS los artículos descargados.}

> Utilidad: {aportación aprovechable} [n]
> Trabajo clave: {sí/no}, porque {motivo}

---

## Parte 2: Diseño de la idea

### 1 Introducción

{Texto académico sin subsecciones: importancia → limitaciones con citas → motivación → método → aportaciones}

Las aportaciones principales son:
- {Aportación del método}
- {Aportación técnica}
- {Aportación experimental; provisional hasta disponer de resultados reales}

### 2 Trabajos relacionados

#### 2.1 {Línea relacionada}

{Síntesis de enfoques y limitaciones comunes}

> {Fuente de la síntesis, si procede} [n]

#### 2.2 {Otra línea relacionada}

{Síntesis}

#### 2.x Laguna de investigación

{Limitaciones compartidas y vacío concreto que cubre el artículo}

> {Dónde se atascan los métodos existentes y qué aporta este trabajo}

### 3 Método

#### 3.1 Marco general

{Qué hace y cómo lo hace}

> {Intuición en lenguaje cotidiano}

```text
Entrada → [Módulo A: función] → [Módulo B: función] → Salida
```

> Flujo de datos: {significado de las conexiones}

#### 3.2 Explicación paso a paso

{Paso 1… Paso 2… Sin fórmulas ni jerga; un paso por módulo teórico posterior}

> {Por qué este orden}

#### 3.3 {Nombre del módulo principal}

{Entradas, salidas, operaciones y formulación teórica}

$$
{fórmula}
$$

> Fórmula: {variables, intuición y justificación}
> Inspiración: {relación con la fuente} [n]
> Texto fuente: "{fragmento breve que respalda la decisión}" (sección {X.X})

#### 3.x Métodos de referencia y métricas

| Método de referencia | Fuente [n] | Motivo de selección |
|---|---|---|
| {nombre} | {autor, publicación, año} | {motivo} |

> {Por qué la comparación es justa y representativa}

| Métrica | Definición | Justificación [n] |
|---|---|---|
| {nombre} | {cálculo} | {fuente} |

> {Por qué refleja la aportación del método}

---

## Parte 3: Diseño experimental

### 0 Estudio experimental de los métodos de referencia

#### 0.x {Método} ({Publicación} {Año}) [n]

**Artículo**: {título completo} | **Código**: {repositorio o código no disponible}
**Idea central**: {método y relación con esta investigación}

| Conjunto de datos | Escala | Estrategia de partición | Proporción y notas |
|---|---|---|---|
| {nombre} | {muestras/tamaño} | {aleatoria/oficial/temporal/validación cruzada} | {detalle} |

| Experimento | Propósito | Modelos comparados | Métricas |
|---|---|---|---|
| {principal/ablación/complementario} | {qué valida} | {modelos} | {métricas} |

**Hiperparámetros**: batch size = {N}, lr = {valor}, epochs = {N}, {otros}

> {Detalles útiles observados en el artículo y el código}

### 0.x+1 Síntesis de convenciones del campo

**Bancos de prueba habituales**: {datos compartidos}
**Métricas habituales**: {cálculo y dirección}
**Convenciones de ablación**: {componentes y nombres}
**Normas de resultados**: {media ± desviación, semillas, resultados por conjunto}

### Disponibilidad de datos y código

| Elemento | Estado | Notas |
|---|---|---|
| Datos {nombre} | ✅/⚠️/❌ | {acceso y requisitos} |
| Código {método} | ✅/⚠️/❌ | {repositorio y compatibilidad} |

### 1 Conjuntos de datos

#### 1.1 Datos disponibles

| Conjunto | Tipo | Escala | Descarga | Uso |
|---|---|---|---|---|
| {nombre} | {tipo} | {tamaño} | {enlace oficial} | Principal / Reserva |

> {Motivo de elección} [n]

#### 1.2 Datos de reserva

| Conjunto | Tipo | Escala | Descarga | Motivo |
|---|---|---|---|---|
| {nombre} | {tipo} | {tamaño} | {enlace} | {motivo} |

#### 1.3 Preprocesamiento

{Herramienta estándar y enlace, o procedimiento estándar si no existe una herramienta}

> {Justificación y fuentes} [n]

### 2 Diseño experimental

#### {Número} {Nombre del experimento}

**Propósito**: {innovación o hipótesis que valida}
**Por qué se diseña así**: {cómo la configuración respalda el método central}

| Conjunto | Entrenamiento | Validación | Prueba | Partición | Justificación |
|---|---|---|---|---|---|
| {nombre} | {cantidad/proporción} | {cantidad/proporción} | {cantidad/proporción} | {método} | {motivo} [n] |

| Métrica | Significado | Cálculo | Justificación |
|---|---|---|---|
| {nombre} | {qué mide} | {fórmula/pasos} | {fuente} [n] |

> {Por qué las métricas responden al propósito}

**Resultado esperado**: {hipótesis y motivo; no resultados medidos}

| Modelo | Diferencia respecto al propuesto | Motivo de inclusión | Tipo | Artículo fuente, solo informativo | Código |
|---|---|---|---|---|---|
| **Propuesto** | — | Método propuesto | Propuesto | — | — |
| {referencia} | {módulo ausente u otra técnica} | {qué ventaja permite comprobar} | Clásico / SOTA / Ablación | {autor} [n] ({publicación, año}) | {repositorio o N/A} |

> {Selección global, categorías y equidad}

**Referencia principal**: {modelo y motivo}

**Resultados esperados, plantilla provisional**:

| Modelo | {Conjunto} | {Métrica 1} | {Métrica 2} | {Métrica 3} |
|---|---|---|---|---|
| {referencia} | — | — | — | — |
| **Propuesto** | — | **?** | **?** | **?** |

#### 2.1 Experimento principal: rendimiento global

{Completar el formato anterior}

#### 2.2 Ablaciones: eficacia de {módulo}

{Completar el formato anterior para cada componente. Nombres: w/o {módulo}, replaced by {alternativa}}

#### 2.3 Experimentos complementarios

**A. Habituales del campo, obligatorios**
{Tipos que se repiten en varias fuentes; indicar [n], [n] y la propiedad validada}

**B. Extensiones elegidas por el usuario**
{Interpretabilidad, generalización, robustez, eficiencia, escalabilidad o sensibilidad; especificar la propiedad que no cubren otros experimentos}

### 3 Estimación orientativa de recursos

| Experimento | VRAM estimada | Tiempo por ejecución | Grupos |
|---|---|---|---|
| Principal | ~{N} GB | ~{N} h/conjunto | {N} |
| Ablación | ~{N} GB | ~{N} h/variante | {N} |
| Complementario | ~{N} GB | ~{N} h | {N} |

> Estimaciones aproximadas; dependen de implementación y hardware. Si faltan recursos, priorizar pruebas centrales y ejecutar por lotes sin debilitar la demostración.

---

## Referencias

{Formato MLA. Verificar todas las fuentes; marcar las no verificables. Unificar las referencias de todas las partes.}

[1] {Apellido, Nombre}. "{Título completo}." *{Revista/Congreso completo}*, vol. {v}, núm. {n}, {año}, pp. {inicio–fin}.

> Aportación principal: {una frase}
> Motivo de la cita: {una frase}
> PDF: `docs/papers/{título completo}.pdf` / [PDF no disponible]

---

## Verificación pendiente

- [ ] {afirmación} (Ubicación: {sección}; motivo: {PDF ausente / texto no localizado / fuente secundaria})

---

> ⚠️ Punto de revisión de B: revisar partes 1 y 2 y confirmar si se continúa con C o se necesitan cambios.

````

## implementation.md

La guía de D especifica todos los directorios y archivos, cada función con firma tipada, parámetros, retorno y lógica, y cada archivo de resultados con nombres, tipos, unidades y significado. El árbol completo y la tabla individual por archivo abren el documento. Usa anotaciones `>` para justificar decisiones y fuentes. Respeta los formatos A/B definidos en la habilidad D.

## dev_log.md

````markdown
# Registro de desarrollo: {tema}
> Creado: {YYYY-MM-DD} | Actualizado: {YYYY-MM-DD}
> Diseño: docs/idea_report.md, parte 3, {fecha}

## Visión general

| Elemento | Valor |
|---|---|
| Línea | {tema} |
| Estrategia | Desde cero / Basado en {proyecto} |
| Código | code/ |
| Versión del diseño | {fecha} |
| Lenguaje | Python |
| Framework | {PyTorch / TF / JAX} |
| Requisitos de programación | {confirmados en conversación} |

## Arquitectura del proyecto

{Árbol idéntico a la estructura confirmada}

| Archivo/directorio | Responsabilidad | Entrada | Salida | Dependencias |
|---|---|---|---|---|
| {ruta} | {función} | {entrada} | {salida} | {dependencias} |

## Arquitectura del modelo, opcional

{Entrada → módulos → salida y pseudocódigo de los módulos centrales}

## Lógica del proyecto

- Datos: archivos → Dataset → DataLoader → transformaciones → entrada.
- Entrenamiento: configuración → inicialización → épocas → parada temprana → checkpoint.
- Inferencia: checkpoint → prueba → predicción → posprocesamiento → métricas → resultados.

## Avance

| Módulo | Archivo | Estado | Finalización | Notas |
|---|---|---|---|---|
| Inicialización | README.md, requirements.txt, configs/ | ⬜ Pendiente | — | |
| Datos | src/data/ | ⬜ Pendiente | — | |
| Modelo | src/models/{model}.py | ⬜ Pendiente | — | |
| Referencias | src/models/baseline/ | ⬜ Pendiente | — | |
| Entrenamiento | src/train.py | ⬜ Pendiente | — | |
| Evaluación | src/evaluate.py | ⬜ Pendiente | — | |
| Utilidades | src/utils/ | ⬜ Pendiente | — | |
| Scripts | scripts/ | ⬜ Pendiente | — | |

Estados: ⬜ Pendiente / 🔄 En curso / ✅ Completado y ejecutado / ❌ Bloqueado.

## Entradas de desarrollo

### {YYYY-MM-DD HH:MM}: {acción}
- Completado: {detalle}
- Problemas: {detalle o ninguno}
- Soluciones: {detalle o ninguna}

## Problemas conocidos, opcional

- [ ] {problema}

## Cómo ejecutar

{Al final; incluir entorno y todos los comandos, parámetros, comportamiento y archivos de salida. Revisar después de cada cambio.}
````

Conserva siempre el historial. Si cambia el diseño experimental, añade una nota de archivo o transición; no borres entradas anteriores.
