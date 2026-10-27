# Guía de redacción de la introducción

## Lógica

Tarea y métricas objetivo → fallo de métodos actuales → causa técnica raíz → solución y procedimiento → por qué funciona → aportaciones adicionales → experimentos.

Antes de redactar razona hacia atrás:
1. Problema técnico y ausencia de solución consolidada.
2. Aportaciones: tarea, métrica, problema, técnica o diseño.
3. Ventajas, mecanismo que resuelve el desafío y nueva observación.
4. Cómo conducen los antecedentes al desafío y la observación.

Después escribe hacia delante: tarea → antecedentes y desafío → aportaciones → ventajas y observación explícita.

## A. Tarea y aplicación

- Tarea especializada: define salida desde entrada y después 2–3 aplicaciones.
- Tarea conocida: abre directamente con aplicaciones y, si procede, requisito de precisión, eficiencia o robustez.
- Contexto nuevo: aplicaciones de la tarea general → caso particular → entradas, salidas y límites.
- Cuando convenga, el primer párrafo puede incluir aplicación, funcionamiento de métodos representativos y fallo con su causa, para revelar pronto el problema. Los párrafos siguientes desarrollan los intentos de resolverlo.

Frases de apoyo: «La tarea de {X} busca estimar {salida} a partir de {entrada}»; «Este trabajo se centra en {caso}».

Ejemplo: [Tarea y aplicación](examples/task-then-application.md).

## B. Desafío técnico

Discute el desafío exacto resuelto, despierta interés por su solución y hace visible la motivación.
Para tareas existentes, identifica métodos recientes afectados, por qué surgieron y qué problema anterior buscaban resolver. Para una tarea nueva, define al menos sus desafíos esenciales.
No construyas el argumento únicamente como un parche sobre una solución ingenua; explica las dificultades reales y compara con alternativas relevantes.

### Versión 1: Tarea existente

Desafío general → métodos tradicionales y limitación → métodos recientes y causa técnica del fallo → siguiente familia y limitación restante. El último desafío debe coincidir con el resuelto.
[Ejemplo](examples/challenge-v1-existing-task.md).

### Versión 2: Observación con antecedentes tradicionales

Expón la observación y el apoyo histórico, después muestra por qué métodos modernos siguen fallando y qué capacidad falta. No confundas recuperación de una idea con una aportación ya demostrada.
[Ejemplo](examples/challenge-v2-insight-backed.md).

### Versión 3: Tarea nueva

Declara objetivo y N razones independientes de dificultad. «Primero… Segundo… Finalmente…»; cada punto contiene limitación observable y razón técnica. Termina enlazando con el procedimiento.
[Ejemplo](examples/challenge-v3-novel-task.md) y [descomposición](examples/novel-task-decomposition.md).

## C. Procedimiento propuesto

Responde: qué desafío resuelve, qué aporta, por qué funciona y, para tareas existentes, qué ventaja tiene frente a métodos previos.

### Versión 1: Una aportación, varias ventajas

Presenta marco o representación, figura de idea general, innovación central, pasos concretos y distintas ventajas.
[Ejemplo](examples/pipeline-v1.md).

### Versión 2: Dos aportaciones

Marco e idea principal → figura → aportación 1 y ventaja → dificultad restante → aportación 2 que la resuelve.
[Ejemplo](examples/pipeline-v2.md).

### Versión 3: Nuevo módulo en un procedimiento previo

Parte de la estructura anterior → módulo nuevo → observación que lo motiva → mecanismo → ventaja frente a alternativas genéricas.
[Ejemplo](examples/pipeline-v3.md).

### Versión 4: Observación central

Innovación → observación intuitiva → implementación → ventaja y ganancia experimental.
No ocultes un método sencillo tras ideas abstractas o muchos nombres nuevos: explica el mecanismo y la aportación real.

## D/E. Aportaciones y experimentos

Estructura final en cinco partes: tarea/aplicación; fallos y causa raíz; propuesta y mecanismo; aportaciones adicionales; resumen experimental y lista de aportaciones.
La lista contiene hechos, sin «novedoso» o «significativo». Cada aportación tiene experimento correspondiente.
Comprueba tema por párrafo, una idea por párrafo, desafío y razón explícitos, evidencia experimental y terminología estable.

Índice: [Ejemplos](examples/introduction-examples.md).
