---
name: research[START]
description: >
  Asistente de investigación ResearchPilot [Entrada]: Detecta la fase actual y dirige a la habilidad correspondiente.
version: 2.0.0
license: LICENSE
---

# Enrutador de entrada de ResearchPilot

> **Prioridad de user_requirements.md**: Todas las restricciones del usuario registradas en `docs/user_requirements.md` (preferencias de investigación, requisitos de implementación, formato documental, etc.) **prevalecen sobre cualquier instrucción predeterminada de esta habilidad**. Lee ese archivo antes de generar cualquier resultado para respetar los requisitos confirmados.

Responde y redacta la documentación en español por defecto, salvo que el usuario indique otro idioma. Conserva los comandos, rutas, identificadores de código, claves de configuración y marcadores que utilice el flujo.

Detecta automáticamente la fase de investigación y dirige al usuario a la habilidad adecuada.


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

## Comandos

| Comando | Descripción |
|---|---|
| `/research[START]` | Detectar fase y mostrar la habilidad adecuada |
| `/research[START] descripción` | Lo anterior y pasar la descripción a A |
| `/research descripción` | Alias compatible de la entrada anterior |

## Detección de fase

Inspecciona `docs/` en este orden:

1. Sin `idea_report.md`: proyecto sin iniciar → A.
2. Informe sin parte 2: A en curso.
3. Parte 2 presente y parte 3 ausente: B en curso.
4. Parte 3 presente, sin `implementation.md`: C terminada, D sin iniciar.
5. Guía presente, sin `dev_log.md`: D terminada, E sin iniciar.
6. Registro presente, sin `manuscripts/`: programación E en curso.
7. Manuscrito presente, sin bloque `=== Paper Architecture ===` (reconoce también `=== 论文架构 ===`): G.0 incompleta.
8. Bloque presente sin texto de secciones: G.0 terminada → G.1.
9. Método redactado, experimentos ausentes → G.2.
10. Experimentos presentes, resumen ausente → G.3.
11. Resumen presente, introducción ausente → G.4.
12. Introducción presente, trabajos relacionados ausentes → G.5.
13. Trabajos relacionados presentes, conclusión ausente → G.6.
14. Conclusión presente, sin informe de revisión → G.7.
15. Existe `review_report.md`: fases completadas; se puede revisar con cualquier G.x.

Reconoce encabezados localizados («Parte 2», «Parte 3», «Método», «Experimentos», «Resumen», «Introducción», «Trabajos relacionados», «Conclusión») y los existentes en inglés, como `## Part 2` y `## Part 3`, sin cambiar los archivos durante la detección.

## Respuesta

```text
━━━━━━━━━━ Detección de fase ResearchPilot ━━━━━━━━━━
Estado actual: {descripción de la fase en una línea}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

→ Usa `/{nombre-de-habilidad}` para continuar.

{Si se indicó una descripción: descripción enviada a A.
Usa /research[A]-exploration {descripción} para comenzar.}
```

Para A recomienda `/research[A]-exploration descripción`; para B, B; para C completada, D; para D completada o E en curso, E; para iteración F, F; para escritura, la siguiente G.x pendiente. Tras la revisión, indica que el artículo está completo y puede seguir revisándose.

## Descarga independiente

Disponible en cualquier fase:

```text
/research[A]-exploration download-paper descripción del artículo [--to "ruta"]
```
