# Plantilla vacía de idea_report.md

Copia el esqueleto a `docs/idea_report.md`. Sustituye cada marcador `{...}` completo. Consulta `document-formats.md` y `template-flexibility.md` para reglas y capítulos.

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
