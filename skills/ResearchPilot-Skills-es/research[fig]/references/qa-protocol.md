# Protocolo de calidad de figuras

Después de cada exportación o ajuste, ejecuta comprobaciones e inspecciona el PNG. Guarda `qa-report.json` en la carpeta de la figura. Scripts de validación, registros y cachés permanecen en `code/fig/`.

## 1. Archivos y reproducción

El script se ejecuta con comando explícito desde raíz o carpeta.
PDF, SVG y PNG existen, se abren y comparten nombre base.
PDF de una sola página.
Los tres proceden de una ejecución, un lienzo y un objeto de gráfico.
Reejecutar no modifica archivos fuera de `code/fig/`.

## 2. Dimensiones

Página PDF conforme a `figure.yaml`; dimensiones físicas y viewBox SVG coherentes.
PNG a 500 dpi por defecto:

```text
width_px  = round(width_mm  / 25.4 * dpi)
height_px = round(height_mm / 25.4 * dpi)
```

Tolera solo redondeo de metadatos, no diferencias visibles o tipográficas.
Alturas iguales en cada fila; anchos más separaciones suman el objetivo.
No aceptes escalado, estirado o rasterización posterior como corrección.

## 3. Tipografía

Comprueba Arial exacta antes de renderizar.
Fuentes ausentes o sustituidas hacen fallar la validación.
Todos los textos tienen un rol de la biblioteca.
Etiquetas de leyenda iguales a las de marcas.
Categorías entre marcas y títulos de eje en jerarquía de tamaño.
Negrita solo en roles que la definen.
Tamaños o fuentes excepcionales requieren aprobación explícita y registro en `exceptions`.

## 4. Color

Todos los colores proceden de nombres o roles de la biblioteca.
Texto, ejes, marcas, fondos y rejilla usan sus roles.
Mismo significado, mismo color en el grupo y figuras existentes.
Secuencia categórica en orden salvo asignación semántica confirmada.
No uses arcoíris categórico para variables continuas.
Cualquier hexadecimal arbitrario requiere aprobación y registro de excepción.

## 5. Datos y alcance

Fuentes reales declaradas.
Filtros, grupos, agregados, incertidumbre y semillas coinciden con lo confirmado.
Verifica filas, grupos y valores clave.
No rellenes manualmente, suavices sin declarar, quites atípicos ni ajustes límites para ocultar resultados.
Las incoherencias estadísticas bloquean la entrega; no las disimules mediante cambios visuales.

## 6. Inspección

Revisa el PNG completo y a ampliaciones útiles, a tamaño final:
- recortes en títulos, ejes, marcas, leyendas, valores y anotaciones;
- colisiones entre textos, datos y leyenda;
- alineación de letras de panel, ejes y líneas base;
- espacio desequilibrado o área de datos demasiado comprimida;
- legibilidad de líneas, puntos, incertidumbre y rellenos;
- alturas, márgenes y líneas base entre figuras de una fila;
- rangos, leyendas, texto y colores coincidentes entre formatos.

Puedes ajustar márgenes, espacio entre paneles, leyenda, colisiones, grosores y marcadores.
Si hay que cambiar contenido, estadística, tipo de gráfico, codificación o disposición, detente y confirma.
Regenera y revalida los tres formatos tras cada ajuste.

## 7. Informe

```json
{
  "figure_id": "fig01",
  "generated_formats": ["pdf", "svg", "png"],
  "dimensions_mm": {"width": 90, "height": 90},
  "png": {"dpi": 500, "width_px": 1772, "height_px": 1772},
  "checks": {
    "files": "pass",
    "dimensions": "pass",
    "font": "pass",
    "color": "pass",
    "data_scope": "pass",
    "visual_preview": "pass",
    "write_boundary": "pass"
  },
  "exceptions": []
}
```

Comprobaciones manuales: `manual-pass`; imposibles o fallidas: `blocked`.
No presentes una comprobación manual como automática.
Declara completado solo al resolver todos los bloqueos.
