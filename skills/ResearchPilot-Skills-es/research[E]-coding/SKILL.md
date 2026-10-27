---
name: research[E]-coding
description: >
  Asistente de investigación ResearchPilot [Fase E]: Programación.
version: 2.0.0
license: LICENSE
---

# Fase E: Programación

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

Implementa archivo por archivo según `docs/implementation.md`, mantén el registro y revisa proactivamente la ejecución y la coherencia lógica al terminar.

**Requisito previo**: guía existente y lista previa de D completada.

## Comando

`/research[E]-coding`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

## Flujo

E-0: crear README y `notebooks/`.
E-1: crear `dev_log.md`, con tabla de avance y capítulo «Cómo ejecutar».
E-2: implementar en el orden de la guía. Tras cada archivo, actualizar registro y, si corresponde, README y notebook. Tras cada módulo, comprobar coherencia con la guía.
E-3: `requirements.txt` contiene solo nombres de bibliotecas, sin versiones ni familia torch.
E-4: si el diseño es inviable, detenerse e informar; no eludir el problema.
E-5: corregir primero los errores de la guía y después el código.
E-6: sincronizar README y «Cómo ejecutar» tras cada archivo.
E-7: revisión proactiva al terminar todos los archivos.
E-8: con resultados deficientes, volver a B/C/D; no limitarse a parches.

Lee `references/phase-E.md`.

## Reglas del registro y restricciones obligatorias

1. Excluir torch, torchvision y torchaudio de `requirements.txt`.
2. Actualizar `dev_log.md` con cada archivo, sin acumular actualizaciones.
3. Marcar `✅ Completado` solo tras escribir y ejecutar sin errores.
4. Mantener «Cómo ejecutar» al final y evaluar su actualización después de cada cambio de código.
5. Si el diseño falla, confirmar el alcance del retroceso y repetir B/C/D.
6. Las reglas de flexibilidad prevalecen sobre las plantillas.

## Al finalizar

Tras superar la revisión, anuncia que el código se ejecuta y concuerda con el diseño. Si los resultados no satisfacen lo esperado, remite a `/research[F]-iteration`; si son satisfactorios, a `/research[G.0]-plan`.

## Referencias

- Flujo: `references/phase-E.md`
- Flexibilidad: `references/template-flexibility.md`
