# Especificación de figuras

Antes de dibujar, registra diseño confirmado, hallazgos de datos en lectura y dimensiones finales en `code/fig/layout-plan.yaml`. Cada `figure.yaml` contiene lo necesario para reproducir una figura independientemente.

## Disposición global

```yaml
version: 1
units: mm
publication_override: null

rows:
  - id: row-1
    target_width: 190
    target_height: 90
    horizontal_gaps: [10]
    figures: [fig01, fig02]

figures:
  - id: fig01
    directory: code/fig/fig01
    width: 90
    height: 90
    size_source: layout_default
  - id: fig02
    directory: code/fig/fig02
    width: 90
    height: 90
    size_source: layout_default
```

Se pueden ampliar campos, pero debe poder validarse ancho y alto finales, pertenencia a filas, altura común, separaciones y ancho total, así como origen de dimensiones: publicación, usuario o referencia predeterminada.
Registra el requisito original y su fuente en `publication_override` si existe. No cambies el YAML incorporado para aplicar una excepción.

## Por figura

```yaml
version: 1
figure_id: fig01

purpose: "Mensaje central de la figura"
expression: "Gráfico de líneas"
arrangement: "Figura izquierda en row-1"

data:
  sources:
    - path: code/results/example.csv
      role: primary
  fields: []
  filters: []
  grouping: []
  aggregation: null
  uncertainty: null
  statistical_notes: null

layout:
  units: mm
  width: 90
  height: 90
  size_source: layout_default
  dpi: 500

style:
  font_library: skill:references/font-library.yaml
  color_library: skill:references/color-library.yaml
  semantic_colors: {}

exceptions: []
```

El usuario confirma `purpose`, `expression`, `arrangement` y el alcance estadístico de `data`. No los cambies según lo favorables o atractivos que parezcan los resultados.

## Confirmación del diseño

Antes de la figura formal, establece:
1. qué responde o demuestra;
2. datos reales usados;
3. filtros, grupos, agregación e incertidumbre;
4. tipo y codificaciones visuales;
5. ejes, leyendas y anotaciones;
6. relaciones y disposición;
7. referencias de tamaño o requisitos de publicación.

Puedes leer código y documentos para proponer respuestas. Toda ambigüedad que cambie conclusión estadística o expresión visual necesita confirmación.

## Nombres y directorios

Identificador estable, breve y válido como archivo, por ejemplo `fig01` o `fig02-ablation`.
Una carpeta y script principal por figura. PDF, SVG y PNG comparten identificador como nombre base.
El PNG es salida y vista previa; no crees una copia adicional.
Informe: `qa-report.json`.
No crees backup/, archive/, history/ ni copias con fecha.

## Integridad

Lee directamente las fuentes declaradas, sin valores de gráfico escritos a mano.
Implementa transformaciones en el script independiente según el alcance registrado.
Registra filas antes/después de filtrar, grupos y agregados clave.
Si se confirma dispersión aleatoria, muestreo o bootstrap, fija y registra la semilla.
Detente si faltan datos, hay campos ambiguos o fuentes contradictorias; no rellenes ni adivines.
