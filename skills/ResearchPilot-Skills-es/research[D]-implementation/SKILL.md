---
name: research[D]-implementation
description: >
  Asistente de investigación ResearchPilot [Fase D]: Diseño de implementación.
version: 2.0.0
license: LICENSE
---

# Fase D: Diseño de implementación

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

Genera una guía de programación precisa por funciones: firmas, parámetros, retornos y lógica. Valídala y confírmala antes de programar. Produce `docs/implementation.md`.

**Requisito previo**: parte 3 completada.

## Comando

`/research[D]-implementation`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

## Flujo

D-0: preguntar si se parte de un método de referencia sólido o desde cero.

Ruta A, proyecto existente:
- D-A1: obtenerlo mediante `git clone` o clonación del usuario.
- D-A2: analizar estructura, clases, funciones y dependencias.
- D-A3: recoger framework, funciones que conservar y requisitos.
- D-A4: generar la guía con el formato de modificación de proyecto existente.

Ruta B, desde cero:
- D-B1: recoger framework y requisitos especiales.
- D-B2: generar la guía con el formato desde cero.

D-end1: validar cobertura, coherencia e integridad.
D-end2: completar entorno, dispositivo, datos, estrategia de ejecución y ubicación del README.

Lee `references/phase-D.md`.

## Validación

Tras cada generación o revisión:
1. Cobertura: cada experimento de la parte 3 dispone de módulos o funciones.
2. Coherencia: coinciden las formas de los tensores entre módulos.
3. Integridad: cada archivo listado tiene su sección de implementación.

```text
✅ Cobertura experimental: {correcta / falta: …}
✅ Coherencia lógica: {correcta / problema: …}
✅ Integridad: {correcta / falta: …}
```

## Restricciones obligatorias

1. No avances a E sin confirmación explícita.
2. Valida inmediatamente y corrige antes de presentar la guía.
3. Excluye torch, torchvision y torchaudio de `requirements.txt`.
4. Las reglas de flexibilidad prevalecen sobre las plantillas.
5. Completa D-end2 punto por punto antes de programar.

## Al finalizar

Cuando guía y lista previa estén confirmadas, anuncia que la guía está generada y validada y remite a `/research[E]-coding`.

## Referencias

- Flujo: `references/phase-D.md`
- Formatos: `references/document-formats.md`
- Flexibilidad: `references/template-flexibility.md`
