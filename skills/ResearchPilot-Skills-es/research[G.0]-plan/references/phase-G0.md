# Flujo detallado de G.0: Planificación del artículo

## Paso 1: Actualizar el informe

Lee completos:
- `docs/idea_report.md`, partes 1/2/3;
- todos los modelos y referencias de `src/models/` en la raíz de código;
- configuración predeterminada y todas las ablaciones;
- `docs/dev_log.md`, especialmente iteraciones;
- todos los resultados de evaluación.

Compara método, arquitectura, módulos, hiperparámetros y fórmulas con el código; datos, referencias, variantes y métricas con resultados; RQ con la dirección final tras iterar.

Presenta diferencias por parte, apartados sin cambios y magnitud del trabajo (pequeño, medio, grande). Confirma el alcance.
Después modifica el informe en el mismo archivo, sin copia de seguridad; añade al principio un registro con fecha/hora, cambios por parte y resumen del estado anterior, conservando registros previos.
Muestra el resumen y confirma antes de continuar.

## Paso 2: Estructura y figuras

Discute título, revista/congreso (determina páginas y formato), encabezados principales y secundarios, nombres de módulos, 2–4 puntos por sección y 3–5 aportaciones verificables vinculadas a experimentos.
Antes de cerrar esta estructura, ejecuta el paso 3.

Enumera todas las figuras/tablas en orden de aparición:
- número, título y sección;
- tipo;
- producción manual del usuario, código o combinación;
- contenido central;
- cómo leerla: ejes, colores y comparaciones;
- conclusión;
- RQ correspondiente.

Tablas: comparación cuantitativa, generación de LaTeX desde notebook, booktabs, mejor en negrita y segundo subrayado.

## Paso 3: Ejemplos antes de confirmar estructura

Pregunta si hay ejemplos, como artículos aceptados de la publicación objetivo. Solicita colocarlos en `docs/manuscripts/examples/`.
Con ejemplos, estructura y estilo de G.1–G.6 siguen esos documentos: secciones, longitud de párrafos y proporción de figuras, sin alterar las normas de rigor.
Lee los originales completos y escribe `style-notes.md` con:
- archivos y fecha de análisis;
- número de secciones y subsecciones;
- estructura de introducción, método y experimentos;
- número, tipo y densidad de figuras/tablas;
- longitud de frases, voz pasiva, densidad de términos y rasgos particulares;
- diferencias con la plantilla y cuál se aplica.

## Paso 4: Formato e idioma

Confirma Markdown o LaTeX y respeta el idioma del usuario; español por defecto. Registra la elección en la sección G de requisitos.
Markdown: `docs/manuscripts/paper.md` o nombre de idioma confirmado.
Anotaciones: `> %Anotación: {comentario}`.
LaTeX: pide plantilla en `docs/manuscripts/templates/` o la publicación para localizar la apropiada. Copia a `paper.tex` sin modificar el original de plantilla; crea `references.bib` si falta.
Anotaciones: `%Anotación: {comentario}`.
No añadas la fase G.8 de traducción chino-inglés: pertenece solo a la edición china.

## Paso 5: Arquitectura detallada

En la cabecera del manuscrito, usa comentario HTML para Markdown o líneas `%` para LaTeX:

```text
=== Paper Architecture ===
Título: {confirmado}
Publicación objetivo: {nombre}
Idioma: {confirmado}
Ejemplos: {ruta o ninguno}

1. Introducción
   Contexto y motivación; fuentes fundamentales.
   Limitaciones y causa raíz, vinculadas a RQ2.
   Enfoque propuesto y procedimiento.
   Aportaciones verificables y figura general.
2. Trabajos relacionados
   Categorías con trabajos y limitaciones.
   Última subsección: laguna de investigación.
3. Método
   Visión general y figura.
   Por módulo: diseño → motivación RQ2 → ventaja técnica.
   Fórmulas previstas y objetivo de entrenamiento.
4. Experimentos
   Datos, estadísticas, referencias, métricas e implementación.
   Resultados principales con tabla y análisis cuantitativo.
   Ablaciones por componente con figuras.
   Análisis adicionales: sensibilidad, eficiencia, visualización.
5. Conclusión
   Problema → evidencia → impacto → limitaciones y futuro.
Referencias
   Formato y anotaciones de aportación/motivo.
Resumen de figuras/tablas
   {números, títulos y ubicaciones en orden}
===
```

La arquitectura real precisa cada título de subsección, contenido y figuras, no solo el esquema genérico. Registra inicialización y fecha.
Antes de editar un manuscrito existente, copia con marca temporal y mantén el original como vigente.

## Paso 6: Notebook de figuras y tablas

Crea `notebooks/figures.ipynb` en la raíz de código según el proyecto, con celdas en orden de aparición.
Una figura de varios paneles se genera completa en una misma celda.
Cada celda de figura incluye número, título, sección, leyenda completa, contenido, cómo leer y conclusión; lee datos reales de `results/`, produce la figura y muestra `plt.show()`.
Cada celda de tabla incluye contenido, significado/unidades de columnas, significado de filas y formato; lee datos reales, muestra DataFrame y genera LaTeX, por ejemplo `df.to_latex(index=True, bold_rows=False, escape=False)`. Comprueba reglas booktabs, negrita y subrayado en el resultado.

No elimines silenciosamente referencias sin datos: marca N/A o T/O.
Usa la misma definición de barras de error en todo el artículo (media ± std o ± SEM) y explícala en configuración experimental.
Una figura transmite una conclusión; la primera frase de su leyenda la expresa. Leyenda autosuficiente.

## Finalización

Confirma los pasos, informe actualizado, arquitectura escrita, número de celdas y formato. Continúa con método, experimentos, resumen, introducción, trabajos relacionados y conclusión.
