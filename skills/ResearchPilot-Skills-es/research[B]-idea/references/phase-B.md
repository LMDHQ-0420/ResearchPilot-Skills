# Flujo detallado de B: Desarrollo de la idea

Se entra tras confirmar A. El objetivo es transformar las RQ en un método implementable mediante marco técnico → procedimiento detallado → introducción pulida.
Cada respuesta comienza con la tarjeta de consenso; añade marco y procedimiento solo cuando estén confirmados.

## Literatura primero

Antes de cada generación o ajuste de marco, procedimiento o método, incluidos retrocesos desde D/E, lee detenidamente lo pertinente de `docs/papers/`. Amplía solo si no basta: búsqueda → lista confirmada → descarga → lectura. Cada decisión clave necesita respaldo; lo no verificable se marca y registra.

## B-0: Compilar parte 1

Compila directamente el consenso de A; no lo regeneres.
- Motivación con necesidad práctica, teórica y temporal, citadas.
- RQ principal y secundarias aplicables, con laguna, novedad y posibilidad de respuesta.
- Tabla solo de trabajos clave, unos 5–8, con nombre corto, publicación, año, aportación y utilidad.
- Fichas de TODOS los descargados, sean clave o no. Cada ficha tiene cita y anotación `>` que explica por qué es o no clave.
- Si A-4.5 fue sí: problema, método y razón del diseño, rendimiento e implicaciones.
- Si fue no: una frase de aportación por artículo, manteniendo la anotación de relevancia.

Presenta la parte 1 y espera revisión confirmada antes de B-1.

## B-1: Marco técnico, nivel 1

Alinea el enfoque general sin entrar aún en detalles de implementación.
Presenta enfoque, innovación, flujo textual entrada → módulos con función → salida, y qué parte de las RQ resuelve cada módulo.
Pregunta qué ajustar e itera hasta confirmar. Actualiza requisitos y tarjeta.

## B-2: Procedimiento detallado, nivel 2

Explica en lenguaje corriente «Paso 1… Paso 2…», sin acumulación de fórmulas. En cada paso: entrada, proceso y salida. Explica la intuición y pregunta por lagunas o decisiones poco razonables.
Tras confirmarlo, actualiza requisitos y tarjeta y redacta la parte 2:
- Introducción provisional, que se pulirá en B-4.
- Trabajos relacionados: síntesis de enfoques y última subsección obligatoria de laguna.
- Método: marco confirmado; 3.2 explicación sencilla; 3.3 en adelante formulaciones teóricas correspondientes; cada fórmula explicada con `>`. Final obligatorio de referencias de comparación y métricas, todas con citas.

Usa anotaciones abundantes para razones, fuentes y decisiones. Si falta literatura, vuelve a buscar y confirmar antes de descargar.

## B-3: Verificar citas

Para cada anotación `>` con número de cita:
1. Abre el PDF o TXT correspondiente en `docs/papers/`.
2. Localiza el pasaje de respaldo y añade un fragmento breve fiel con sección, sin exceder lo necesario.
3. Si no puede verificarse, marca `⚠️ [confianza baja: PDF no disponible]` o el motivo real y añádelo a pendientes.

## B-4: Introducción, nivel 3

Con el método confirmado, redacta una introducción académica apta para revisión: importancia → limitaciones citadas → motivación → visión general → aportaciones. Sin subtítulos.
Pregunta si la lógica resulta convincente y qué reforzar: contexto, limitaciones o aportaciones. Itera hasta confirmar.

## B-5: Continuación

Cuando marco, procedimiento, método e introducción estén confirmados, pregunta si se continúa con C o quedan ajustes.
Avanza solo tras confirmación explícita: `/research[C]-experiment`.
