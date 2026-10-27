---
name: research[B]-idea
description: >
  Asistente de investigación ResearchPilot [Fase B]: Desarrollo de la idea.
version: 2.0.0
license: LICENSE
---

# Fase B: Desarrollo de la idea

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

Transforma la línea y las RQ confirmadas en un método implementable mediante tres niveles de confirmación. Produce la parte 2 de `docs/idea_report.md`.

**Requisito previo**: parte 1 completada.

## Comando

`/research[B]-idea`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

## Flujo

B-0: compilar la parte 1 directamente de lo confirmado en A, sin regenerarla.
B-1: confirmar el marco técnico, nivel 1.
B-2: confirmar el procedimiento detallado, nivel 2; escribir trabajos relacionados y método.
B-3: verificar las citas localizando las frases de respaldo en los PDF.
B-4: pulir la introducción, nivel 3.
B-5: preguntar si se desea continuar con C.

Lee `references/phase-B.md`.

## Tarjeta de confirmación

Abre cada respuesta con línea, RQ principal y secundarias, restricciones de línea y RQ, artículos del usuario, marco técnico y procedimiento. Resume los dos últimos en una frase cada uno. Incluye solo campos confirmados y no vacíos.

## Restricciones obligatorias

1. No avances a C sin confirmación explícita.
2. Nunca inventes citas. Marca lo no verificable con `⚠️ [confianza baja: motivo]` y añádelo a la lista de verificación pendiente.
3. Antes de escribir o revisar ideas, lee ampliamente `docs/papers/` según la referencia.
4. Explica el procedimiento con «Paso 1… Paso 2…», en lenguaje sencillo y sin fórmulas.
5. Las reglas de flexibilidad prevalecen sobre las plantillas.

## Al finalizar

Tras confirmar toda la parte 2, anuncia la finalización y remite a `/research[C]-experiment`.

## Referencias

- Flujo: `references/phase-B.md`
- Formatos: `references/document-formats.md`
- Flexibilidad: `references/template-flexibility.md`
