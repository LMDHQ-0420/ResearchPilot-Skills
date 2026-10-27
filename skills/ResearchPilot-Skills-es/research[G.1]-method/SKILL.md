---
name: research[G.1]-method
description: >
  Asistente de investigación ResearchPilot [Fase G.1]: Redactar y revisar método.
version: 2.0.0
license: LICENSE
---

# Fase G.1: Método

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

`/research[G.1]-method`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

**Requisito previo**: Bloque de arquitectura completo en la cabecera, con contenido y figuras de todas las secciones.

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

Para cada módulo responde antes de redactar:
1. ¿Cómo funciona? Compruébalo en el código.
2. ¿Por qué se necesita? Relaciónalo con el obstáculo de RQ2 en el informe.
3. ¿Por qué funciona? Expón la intuición teórica o evidencia previa.

Orden de los tres elementos de Master-cai: **diseño del módulo → motivación → ventaja técnica**.
Después de cada fórmula, explica todas las variables.
Orden de escritura: visión general → módulos → objetivo de entrenamiento.

Ejemplos: `references/examples/example-of-the-three-elements.md`, `references/examples/module-motivation-patterns.md` y `references/examples/section-skeleton.md`.

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

Continúa con `/research[G.2]-experiments`.

## Referencias

- Guía: `references/section-guide.md`
- Restricciones comunes: `references/common-writing-constraints.md`
- Flexibilidad: `references/template-flexibility.md`
