---
name: research[F]-iteration
description: >
  Asistente de investigación ResearchPilot [Fase F]: Iteración del código y mejora del modelo.
version: 2.0.0
license: LICENSE
---

# Fase F: Iteración del código y mejora del modelo

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

En esta fase `docs/dev_log.md` es acumulativo: añade entradas y nunca borres ni sobrescribas el historial.

## Comando

`/research[F]-iteration`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

## Flujo

F-1: diagnosticar leyendo `dev_log.md`, datos de `results/` e `idea_report.md`; producir un informe.
F-2: confirmar si el retroceso afecta a hiperparámetros, arquitectura o diseño experimental.
F-3: actualizar primero los documentos de diseño.
F-4: modificar código; añadir una entrada tras cada archivo.
F-5: ejecutar experimentos y añadir resultados al registro.
F-6: decidir si repetir desde F-1 o avanzar.

Lee `references/phase-F.md`.

## Restricciones obligatorias

1. El registro solo admite adiciones. Cada cambio requiere una nueva entrada.
2. Leer registro, resultados e informe antes de diagnosticar; no adivinar.
3. Confirmar el alcance con el usuario y actualizar documentos antes del código.
4. Si cambia la arquitectura o el método, revisar las ablaciones y actualizar la parte 3 si está afectada.
5. Las reglas de flexibilidad prevalecen sobre las plantillas.

## Al finalizar

Con resultados satisfactorios, informa de las {N} rondas y del registro de resultados finales, y remite a `/research[G.0]-plan`.

## Referencias

- Flujo: `references/phase-F.md`
- Flexibilidad: `references/template-flexibility.md`
