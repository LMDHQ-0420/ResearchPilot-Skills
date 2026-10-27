# Guía de redacción de experimentos

Convence mediante evidencia de eficacia, causalidad y valor práctico.

## Tres preguntas

1. ¿Supera a referencias sólidas y recientes? Usa métricas estándar, SOTA o métodos públicos fuertes y el mismo protocolo de datos, preprocesamiento y evaluación.
2. ¿Qué decisiones causan la mejora? Quita, sustituye o desactiva componentes y cuantifica el cambio frente al modelo completo. Si están acoplados, prueba interacciones.
3. ¿Hasta dónde generaliza? Evalúa casos difíciles o fuera de distribución: escenas complejas, casos raros, ruido o restricciones mayores. Muestra mejoras y fallos para delimitar el alcance.

Planifica desde dos fuentes: cada aportación exige una prueba; cada módulo y parámetro central del procedimiento exige ablación.

## Estructura

Configuración experimental → pruebas de validación → ablaciones → análisis adicionales.
Todo resultado cuantitativo procede de archivos reales.
El texto indica métrica, referencia y diferencia exacta, seguida de interpretación.

## Tablas y figuras

Las leyendas son parte de la calidad argumentativa.
- Leyenda de tabla arriba; caption antes de label.
- Sin líneas verticales, líneas dobles ni acumulación de hline.
- Usa booktabs: top/mid/bottomrule y pocas líneas para separar grupos.
- Destaca mejor en negrita y segundo subrayado; usa color con moderación si corresponde.
- Indica dirección, por ejemplo PSNR ↑ y LPIPS ↓, y unidades.
- Texto a la izquierda; números con alineación y precisión consistentes.
- Agrupa conjuntos con multicolumn y cmidrule.
- Una tabla transmite un mensaje; variantes y atributos identificados en filas/columnas.
- Leyendas concisas sobre configuración, protocolo y notación; no discusiones largas.
- En artículos a dos columnas, una figura de una columna puede ir a la derecha si mejora la lectura desde el texto superior izquierdo.

LaTeX: booktabs; colortbl/xcolor si hacen falta; siunitx opcional para decimales. Evita colorear muchas celdas.

## Paquete de ablaciones

Tabla central de todas las aportaciones, pequeñas pruebas de decisiones concretas y resultados cualitativos de las ablaciones importantes.

## Revisión

¿Referencias relevantes y recientes? ¿Métricas suficientes? ¿Cada decisión está probada? ¿Resumen e introducción respaldados por cifras? ¿Alcance y limitaciones explícitos?
