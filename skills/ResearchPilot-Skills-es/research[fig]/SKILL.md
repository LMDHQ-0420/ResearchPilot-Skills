---
name: research[fig]
description: >
  Genera, ajusta y valida figuras científicas de forma independiente. Puede leer código, resultados y documentos del proyecto para comprender la investigación; todas las escrituras se limitan estrictamente a code/fig/. Úsala para gráficos con datos reales, dimensiones de revista, tipografía y color uniformes, y entrega sincronizada PDF/SVG/PNG.
license: LICENSE
---

# Producción de figuras científicas

El usuario determina el contenido, alcance estadístico, expresión visual y disposición. Esta habilidad calcula dimensiones físicas, organiza directorios, implementa los gráficos, exporta y verifica el diseño confirmado.

Es independiente: no constituye una fase de ResearchPilot ni depende de otras habilidades. Usa español para la comunicación salvo indicación contraria.

## Límites de acceso

### Lecturas permitidas

Lee solo el material necesario para entender objetivo, significado de los datos, estadística y terminología: código, configuraciones, registros, resultados y datos bajo `code/`; Markdown, LaTeX y texto del proyecto; otras fuentes que el usuario indique explícitamente.

La lectura no autoriza modificaciones. Los requisitos actuales de la conversación prevalecen sobre documentación anterior.

### Única ubicación de escritura

Todos los archivos nuevos, modificados, sobrescritos, de caché o temporales deben estar en `code/fig/` en la raíz del proyecto. No modifiques código fuente, datos, documentación, dependencias ni configuración fuera de ese directorio.

- Crea `code/fig/` si no existe.
- No generes copias de seguridad, instantáneas, archivos históricos ni versiones anteriores con fecha.
- No copies datos fuente salvo petición explícita.
- No cambies dependencias ni entorno por iniciativa propia. Si faltan capacidades, informa y pide al usuario que decida.

## Especificaciones obligatorias

Antes de planificar, lee íntegramente:

- [Dimensiones predeterminadas](references/layout-defaults.yaml)
- [Biblioteca tipográfica](references/font-library.yaml)
- [Biblioteca de colores](references/color-library.yaml)

Al definir figuras, lee [Especificación](references/figure-spec.md). Al exportar y validar, lee [Protocolo de calidad](references/qa-protocol.md).

## Flujo

1. Confirma contenido, forma visual, alcance estadístico y disposición. Los materiales del proyecto no sustituyen las decisiones de diseño del usuario.
2. Localiza las fuentes reales, significado de campos, implementación estadística, disposición y requisitos. Nunca sustituyas resultados por simulaciones, estimaciones ni valores inventados.
3. Crea `code/fig/layout-plan.yaml` con cada figura, relaciones de fila, datos, alcance estadístico y origen de dimensiones.
4. Resuelve primero la fila. El ancho es la restricción principal. Asigna la misma altura a las figuras de una fila antes de dibujar; anchos y separaciones suman el ancho objetivo. No iguales alturas escalando archivos exportados.
5. Crea `code/fig/<figure-id>/`, `figure.yaml` y un script por figura, capaz de reproducirla por separado desde las fuentes declaradas.
6. Carga bibliotecas de fuentes y colores. Resuelve Arial exactamente; rechaza sustituciones silenciosas. Usa solo colores con nombre o roles semánticos. Toda excepción necesita aprobación explícita y registro en `figure.yaml`.
7. Dibuja los datos reales con el alcance confirmado. No cambies filtros, agregación, incertidumbre, significado de ejes, tipo de gráfico, codificación visual ni disposición por iniciativa propia.
8. Exporta PDF, SVG y PNG consecutivamente desde el mismo lienzo y objeto. Mismo nombre base. PNG a 500 dpi por defecto. Regenera siempre los tres formatos juntos.
9. Verifica dimensiones, tipografía, colores, espacios, recortes, solapamientos y coherencia entre formatos. Escribe `qa-report.json` dentro de cada directorio.
10. Inspecciona el PNG a tamaño final. Puedes ajustar márgenes, leyendas y colisiones. Si hace falta cambiar contenido, estadística o diseño visual, detente y solicita confirmación. Regenera y valida los tres formatos tras cada ajuste.

## Dimensiones

Precedencia:
1. Requisitos explícitos de revista o congreso.
2. Dimensiones del grupo indicadas por el usuario.
3. Dimensiones individuales indicadas por el usuario.
4. Referencias de `layout-defaults.yaml`.

Los valores predeterminados son referencias de disposición, no normas de publicación. Calcula altura según densidad, proporción y disposición. En una fila, las alturas físicas son iguales y:

```text
sum(w_i) + sum(g_i) = W
inch = mm / 25.4
```

Dibuja directamente a tamaño final. No redimensiones después de exportar.

## Directorios

```text
code/fig/
├── layout-plan.yaml
├── <figure-id>/
│   ├── figure.yaml
│   ├── plot_<figure-id>.<py|R|lenguaje-elegido>
│   ├── <figure-id>.pdf
│   ├── <figure-id>.svg
│   ├── <figure-id>.png
│   └── qa-report.json
└── ...
```

Respeta el lenguaje pedido o las herramientas de gráficos existentes; si no hay preferencia, elige según datos y entorno. La figura final proviene del script independiente; no puede depender de estado oculto de notebooks.

## Finalización

Declara completado solo si:
- se han respetado contenido, estadística, expresión y disposición confirmados;
- cada figura tiene directorio, especificación y script independiente;
- existen PDF, SVG y PNG concordantes;
- pasan dimensiones y restricciones de fila;
- pasan fuente, roles tipográficos, colores y excepciones;
- el PNG carece de recortes, colisiones o espacios desequilibrados;
- toda escritura está dentro de `code/fig/`.

Entrega rutas, tamaño físico, dimensiones del PNG en píxeles, fuente de datos, resumen estadístico y resultado de calidad de cada figura.
