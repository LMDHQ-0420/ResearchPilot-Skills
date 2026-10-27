---
name: research[C]-experiment
description: >
  Asistente de investigación ResearchPilot [Fase C]: Diseño experimental.
version: 2.0.0
license: LICENSE
---

# Fase C: Diseño experimental

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

Lee artículos y código de los métodos de referencia, sintetiza las prácticas del campo y diseña experimentos principales, de ablación y complementarios. Añade la parte 3 de `docs/idea_report.md`.

**Requisito previo**: parte 2 completada.

**Principio**: cada experimento demuestra rigurosamente la eficacia de la idea. Los límites de recursos no son entradas del diseño; solo se ofrece una estimación posterior.

## Comando

`/research[C]-experiment`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

## Flujo

C-1: presentar y confirmar el plan de lectura; leer artículos y código.
C-2: investigar convenciones experimentales del campo en artículos de los últimos 3 años.
C-3: verificar disponibilidad de datos y código.
C-4: proponer y confirmar el esquema: primero estructura y después detalles.
C-5: generar toda la parte 3.
C-6: añadir una estimación orientativa de recursos.
C-7: preguntar si se desea continuar con D.
C-8: refinar hasta la confirmación.

Lee `references/phase-C.md`.

## Restricciones obligatorias

1. No avances a D sin confirmación explícita.
2. Obtén confirmación del esquema C-4 antes de escribir toda la parte 3.
3. No recopiles límites de GPU o tiempo de entrenamiento antes del diseño.
4. Explica cada modelo de las tablas: diferencia respecto al propuesto, motivo de inclusión y artículo fuente.
5. Nunca inventes citas; marca lo no verificable con `⚠️ [confianza baja: motivo]`.
6. Las reglas de flexibilidad prevalecen sobre las plantillas.

## Al finalizar

Tras confirmar la parte 3, anuncia la finalización y remite a `/research[D]-implementation`.

## Referencias

- Flujo: `references/phase-C.md`
- Formatos: `references/document-formats.md`
- Flexibilidad: `references/template-flexibility.md`
