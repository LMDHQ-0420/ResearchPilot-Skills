---
name: research[G.7]-review
description: >
  Asistente de investigación ResearchPilot [Fase G.7]: Redactar y revisar revisión integral.
version: 2.0.0
license: LICENSE
---

# Fase G.7: Revisión integral

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

`/research[G.7]-review`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

**Requisito previo**: Una o varias secciones redactadas.

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

Revisa las cinco dimensiones de Master-cai:
1. Aportaciones: ¿cada afirmación tiene respaldo experimental?
2. Claridad: ¿un mensaje por párrafo, frase temática adecuada y terminología consistente?
3. Solidez experimental: ¿experimentos principales, ablaciones y análisis cubren todas las RQ? ¿Faltan referencias sólidas?
4. Integridad de la evaluación: ¿comparación justa y métricas justificadas?
5. Fundamento del método: ¿cada decisión está motivada y verificada con ablaciones?

Para cada afirmación importante de resumen e introducción, entrega:

| Afirmación | Evidencia | Estado |
|---|---|---|
| {afirmación} | {experimento o fuente} | respaldada / necesita evidencia / ausente |

No omitas afirmaciones sin respaldo.

Ordena los problemas por prioridad:
- Alta: afecta la validez de la aportación principal o rompe la cadena lógica; corregir antes del envío.
- Media: perjudica la lectura o un argumento local carece de respaldo suficiente; se recomienda corregir.
- Baja: estilo, expresión o formato; opcional.

Extrae las frases temáticas de todos los párrafos y comprueba que forman un relato coherente.
Consulta también `references/section-guide-source.md` y `references/writing-flow-source.md`.

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

Al resolver los problemas de prioridad alta, informa de que la redacción del artículo está completa.

## Referencias

- Guía: `references/section-guide.md`
- Restricciones comunes: `references/common-writing-constraints.md`
- Flexibilidad: `references/template-flexibility.md`
