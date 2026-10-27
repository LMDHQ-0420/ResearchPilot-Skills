---
name: research[G.5]-related
description: >
  Asistente de investigación ResearchPilot [Fase G.5]: Redactar y revisar trabajos relacionados.
version: 2.0.0
license: LICENSE
---

# Fase G.5: Trabajos relacionados

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

`/research[G.5]-related`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

**Requisito previo**: Introducción G.4 redactada.

## Antes de escribir

1. Lee el manuscrito completo para mantener la continuidad.
2. Lee todas las referencias existentes, en la sección bibliográfica o el archivo .bib.
3. Lee el bloque de arquitectura en la cabecera. Conserva el marcador `=== Paper Architecture ===` y reconoce también el marcador heredado `=== 论文架构 ===`.
4. Lee `docs/idea_report.md` y `docs/dev_log.md`; busca allí las respuestas antes de preguntar.
5. Si existe `docs/manuscripts/examples/style-notes.md`, lee el análisis de ejemplos.
6. Recorre las anotaciones del manuscrito y lista las pendientes.
7. Confirma el plan de redacción con el usuario antes de escribir.

Consulta `references/common-writing-constraints.md`.

## Requisitos de la sección

Organiza de 2 a 4 subsecciones temáticas. En cada una: frase temática → 3–5 trabajos representativos con citas → limitación → transición.

La última subsección es siempre la **laguna de investigación (Research Gap)**: sintetiza las limitaciones de las categorías y señala qué vacío cubre el artículo.
Debe concordar con la parte 2 de la introducción.
Evita listas narrativas de «XXX y colaboradores proponen…»; explica la limitación compartida de cada categoría.
Cada cita debe indicar qué categoría representa o qué limitación respalda.

## Gestión de versiones y referencias

Antes de redactar, crea una copia `paper_{mm-dd_hh-mm}.md` o `.tex`; el archivo original sigue siendo la versión vigente. Después, añade el registro de modificación a la cabecera según `references/common-writing-constraints.md`.

Añade de inmediato cada referencia nueva:

```markdown
[N] {Autor}. "{Título}." *{Revista/Congreso}*, {Año}.
> Aportación principal: {qué hace el artículo, en una frase}
> Motivo de la cita: {dónde y por qué se cita}
```

Para BibTeX:

```bibtex
% [Aportación principal] {aportación en una frase}
% [Motivo de la cita] {sección}: {motivo}
@article{key, ...}
```

Al terminar, anuncia la sección redactada o revisada. Se puede invocar `/research[G.7]-review` en cualquier momento para una revisión integral.

Continúa con `/research[G.6]-conclusion`.

## Referencias

- Guía: `references/section-guide.md`
- Restricciones comunes: `references/common-writing-constraints.md`
- Flexibilidad: `references/template-flexibility.md`
