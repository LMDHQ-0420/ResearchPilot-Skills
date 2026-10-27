---
name: research[G.0]-plan
description: >
  Asistente de investigación ResearchPilot [Fase G.0]: Planificación del artículo.
version: 2.0.0
license: LICENSE
---

# Fase G.0: Planificación del artículo

> **Prioridad de user_requirements.md**: Todas las restricciones del usuario registradas en `docs/user_requirements.md` (preferencias de investigación, requisitos de implementación, formato documental, etc.) **prevalecen sobre cualquier instrucción predeterminada de esta habilidad**. Lee ese archivo antes de generar cualquier resultado para respetar los requisitos confirmados.

Responde y redacta la documentación en español por defecto, salvo que el usuario indique otro idioma. Conserva los comandos, rutas, identificadores de código, claves de configuración y marcadores que utilice el flujo.

## Cadena de redacción

| Habilidad | Responsabilidad |
|---|---|
| `/research[G.0]-plan` | Actualizar informe, planificar estructura y figuras, seleccionar formato |
| `/research[G.1]-method` | Redactar o revisar el método |
| `/research[G.2]-experiments` | Redactar o revisar los experimentos |
| `/research[G.3]-abstract` | Redactar o revisar el resumen |
| `/research[G.4]-introduction` | Redactar o revisar la introducción |
| `/research[G.5]-related` | Redactar o revisar los trabajos relacionados |
| `/research[G.6]-conclusion` | Redactar o revisar conclusión y referencias |
| `/research[G.7]-review` | Revisión integral en cinco dimensiones y correspondencia entre afirmaciones y evidencia |

## Comando

`/research[G.0]-plan`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

## Flujo

1. Actualiza `idea_report.md`: compáralo con el código, enumera diferencias, pide confirmación y edita en el mismo archivo.
2. Planifica estructura y figuras: esquema, detalle por sección y plan de tablas y figuras.
3. Solicita ejemplos de escritura y colócalos en `docs/manuscripts/examples/`. Este paso ocurre **antes de confirmar** la estructura del paso 2.
4. Selecciona formato: Markdown o LaTeX.
5. Escribe comentarios detallados de arquitectura en la cabecera del manuscrito: cada subsección, contenido y ubicación de tablas y figuras.
6. Genera las celdas de figuras y tablas en `notebooks/figures.ipynb`.

Lee `references/phase-G0.md`. Sigue el orden del flujo y confirma cada paso antes de avanzar, con la excepción temporal indicada para los ejemplos.

## Versiones

Edita `idea_report.md` en el mismo archivo, sin copia de seguridad; añade el registro de cambios al principio.
Antes de editar el manuscrito, guarda `paper_{mm-dd_hh-mm}.md` o `.tex`; conserva el original como versión más reciente. Registra fecha, cambios y ruta de la copia en la cabecera.

Las reglas de `references/template-flexibility.md` prevalecen sobre las plantillas.

## Al finalizar

Informa de que el informe está actualizado, los comentarios de arquitectura están escritos, el formato elegido y las {N} celdas creadas.
Orden recomendado de Master-cai: método → experimentos → resumen → introducción → trabajos relacionados → conclusión.
Continúa con `/research[G.1]-method`.

## Referencias

- Flujo: `references/phase-G0.md`
- Restricciones comunes: `references/common-writing-constraints.md`
- Flexibilidad: `references/template-flexibility.md`
