---
name: research[A]-exploration
description: >
  Asistente de investigación ResearchPilot [Fase A]: Exploración de líneas de investigación.
version: 2.0.0
license: LICENSE
---

# Fase A: Exploración de líneas de investigación

> **Prioridad de user_requirements.md**: Todas las restricciones del usuario registradas en `docs/user_requirements.md` (preferencias de investigación, requisitos de implementación, formato documental, etc.) **prevalecen sobre cualquier instrucción predeterminada de esta habilidad**. Lee ese archivo antes de generar cualquier resultado para respetar los requisitos confirmados.

Responde y redacta la documentación en español por defecto, salvo que el usuario indique otro idioma. Conserva los comandos, rutas, identificadores de código, claves de configuración y marcadores que utilice el flujo.


## Flujo de trabajo y entregables

ResearchPilot divide un proyecto de investigación en etapas independientes. Esta habilidad forma parte de esa cadena.

| Habilidad | Etapa | Entregable principal |
|---|---|---|
| `/research[A]-exploration` | Exploración de líneas de investigación | `docs/idea_report.md`, parte 1 |
| `/research[B]-idea` | Desarrollo de la idea | `docs/idea_report.md`, parte 2 |
| `/research[C]-experiment` | Diseño experimental | `docs/idea_report.md`, parte 3 |
| `/research[D]-implementation` | Diseño de implementación | `docs/implementation.md` |
| `/research[E]-coding` | Programación | `code/` y `docs/dev_log.md` |
| `/research[F]-iteration` | Iteración del código | Registros de iteración en `dev_log.md` |
| `/research[G.0]-plan` | Planificación del artículo | Arquitectura del manuscrito y `notebooks/figures.ipynb` |
| `/research[G.1]-method` | Método | Sección de método del manuscrito |
| `/research[G.2]-experiments` | Experimentos | Sección de experimentos |
| `/research[G.3]-abstract` | Resumen | Resumen del manuscrito |
| `/research[G.4]-introduction` | Introducción | Introducción del manuscrito |
| `/research[G.5]-related` | Trabajos relacionados | Sección de trabajos relacionados |
| `/research[G.6]-conclusion` | Conclusión y referencias | Conclusión del manuscrito |
| `/research[G.7]-review` | Revisión integral | Informe de revisión |

### Estructura del proyecto

```text
docs/
  idea_report.md        # Parte 1: motivación, preguntas de investigación y trabajos clave (A)
                        # Parte 2: introducción, trabajos relacionados y método (B)
                        # Parte 3: datos, diseño experimental y estimación de recursos (C)
  implementation.md     # Plan de implementación por archivos y funciones (D)
  dev_log.md            # Avances, decisiones y sección «Cómo ejecutar» (E)
  user_requirements.md  # Restricciones del usuario, recopiladas por Claude
  papers/               # Artículos descargados en PDF o resúmenes TXT
  manuscripts/          # Borradores; cada revisión se archiva por separado
                        # Ej.: v1.0-initial-draft.md, v1.1-revision.md
code/
  src/                  # Modelo principal y entrenamiento
  scripts/              # train.sh, evaluate.sh, ablation.sh
  configs/              # Configuración de hiperparámetros
  src/models/baseline/  # Métodos de referencia con la misma interfaz que el modelo principal
  notebooks/            # Visualizaciones y generación de figuras/tablas del artículo
  data/                 # Conjuntos de datos, excluidos de Git
  results/              # Resultados, excluidos de Git
  logs/                 # Registros de entrenamiento, excluidos de Git
  README.md             # Preparación del entorno y comandos de ejecución
  requirements.txt      # Solo nombres de bibliotecas; sin la familia torch
```

Partiendo de un interés impreciso, concreta mediante varias interacciones una línea fundamentada y preguntas de investigación (RQ). Produce la parte 1 de `docs/idea_report.md`.

## Comandos y activación

- `/research[A]-exploration descripción de investigación`: iniciar la exploración.
- `/research[A]-exploration --papers <pdf/nombre/descripción>`: comenzar con artículos de referencia.
- `/research[A]-exploration download-paper descripción [--to "ruta"]`: descarga independiente, disponible en cualquier momento; omite el flujo de exploración.
- Sin descripción, solicita una. Ejemplo: «/research[A]-exploration Quiero mejorar la predicción del SOH de baterías; los métodos Transformer no aprovechan las características temporales locales».

## Flujo

A-1: interpretar entrada y recopilar requisitos en `user_requirements.md`.
A-2: búsqueda inicial: ≥15 artículos, ≥2 por laguna, hasta 3 rondas.
A-3: presentar lista de descargas y esperar confirmación.
A-4: descargar e informar.
A-4.5: preguntar si se desean explicaciones detalladas por artículo.
A-5: delimitar el problema y confirmar la línea paso a paso.
A-6: concretar y confirmar RQ principal y secundarias, una por una.
A-7: compilar la parte 1.

Lee `references/phase-A.md`, incluida la descarga arXiv → OpenReview → resumen TXT.

## Tarjeta de confirmación

Cada respuesta comienza, cuando haya contenido confirmado, con una tarjeta que indique línea, RQ principal, RQ secundarias, restricciones de la línea, restricciones de las RQ y artículos indicados por el usuario. Omite campos vacíos o sin confirmar.

## Restricciones obligatorias

1. No avances a B sin confirmación explícita.
2. Nunca inventes citas. Verifica mediante `web_search`; marca lo no verificable con `[pendiente de verificación]`.
3. Expresa la incertidumbre: `⚠️ [confianza baja: motivo]`.
4. Tras `download-paper`, entrega siempre la ruta completa.
5. Claude mantiene los requisitos exclusivamente a partir de la conversación.
6. `references/template-flexibility.md` prevalece sobre las plantillas.
7. Antes de generar o modificar ideas, lee ampliamente la literatura según el principio de lectura de la referencia.

## Al finalizar

Tras compilar y confirmar la parte 1, anuncia la finalización y remite a `/research[B]-idea`.

## Referencias

- Flujo: `references/phase-A.md`
- Formatos: `references/document-formats.md`
- Plantilla del informe: `references/idea_report-template.md`
- Flexibilidad: `references/template-flexibility.md`
- Requisitos: `references/user-requirements-template.md`
