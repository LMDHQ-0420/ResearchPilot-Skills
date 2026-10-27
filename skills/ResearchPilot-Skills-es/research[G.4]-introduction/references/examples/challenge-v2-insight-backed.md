# Desafío, versión 2: Observación respaldada por métodos tradicionales

Para una tarea existente cuya idea tiene antecedentes, presenta ese apoyo conceptual y después la dificultad que aún queda.

## Deep Snake

Muchos segmentadores trabajan píxel a píxel dentro de una caja de detección. Son sensibles a la caja y requieren posprocesamiento costoso.
Una alternativa es un contorno, conjunto de vértices del borde, con menos parámetros y sin quedar limitado por la caja.
Los contornos activos tienen una larga historia desde Kass y colaboradores, pero sus objetivos manuales, habitualmente no convexos, favorecen óptimos locales.

## ManhattanSDF

Los métodos multivista estiman mapas de profundidad y los fusionan en 3D. En paredes o suelos con poca textura fallan las correspondencias.
El prior de planos en escenas construidas, incluida la hipótesis Manhattan de tres direcciones dominantes, aporta apoyo histórico a la idea.
Sin embargo, optimizar mapas por vista puede producir inconsistencia de profundidad y segmentación entre vistas.
Los campos de distancia con signo aprendidos mediante renderizado diferenciable recuperan geometría de calidad, pero siguen dependiendo de consistencia fotométrica; en regiones planas de poca textura muchas soluciones la satisfacen.

## Esqueleto

Métodos y logro → limitación con causa → idea tradicional pertinente → qué permite → límite pendiente → métodos modernos → obstáculo concreto que resuelve nuestra propuesta.
