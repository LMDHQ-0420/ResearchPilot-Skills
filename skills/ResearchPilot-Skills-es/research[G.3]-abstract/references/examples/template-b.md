# Plantilla B: Desafío → observación clave → aportación

## Estructura

Tarea → desafío → idea en una frase → técnica que la materializa en 1–2 frases → ventajas → resultados.

## Ejemplo 1: Difusión y profundidad

Los modelos de difusión han impulsado los modelos generativos. La guía con o sin clasificador permite equilibrar fidelidad y diversidad, pero no controla directamente la configuración geométrica, como la profundidad.
La idea es utilizar profundidad estimada desde representaciones intermedias ricas del propio modelo.
Se presenta un marco de estimación de profundidad eficiente en etiquetas y, durante muestreo, dos mecanismos de autocondicionamiento: pseudoetiquetas y un prior de difusión en profundidad.
Termina con ventajas y resultados reales del trabajo, sin añadir cifras no disponibles.

## Ejemplo 2: Neural Body

Se estudia síntesis de vistas de una persona desde muy pocas cámaras. Aprender representaciones implícitas funciona con vistas densas, pero queda mal determinado con observación escasa.
La idea central es integrar observaciones entre fotogramas.
Neural Body comparte códigos latentes anclados a una malla deformable entre los campos de distintos fotogramas.
Así se integra evidencia temporal y la malla aporta guía geométrica para aprender de forma más eficiente.
Cierra con resultados concretos.

El ejemplo distingue la idea —integrar observaciones— de la técnica —códigos compartidos sobre una malla— y de sus beneficios.
