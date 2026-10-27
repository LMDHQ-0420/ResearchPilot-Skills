---
name: research[G.4]-introduction
description: >
  Asistente de investigación ResearchPilot [Fase G.4]: Redactar y revisar introducción.
version: 2.0.0
license: LICENSE
---

# Fase G.4: Introducción

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

`/research[G.4]-introduction`

> El comando admite instrucciones adicionales en lenguaje natural. La IA las tratará como restricciones o indicaciones complementarias de esta invocación.

**Requisito previo**: Resumen G.3 redactado.

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

Antes de escribir razona hacia atrás desde el informe:
1. ¿Qué problema técnico resolvemos y por qué no hay solución consolidada?
2. ¿Qué aporta el procedimiento?
3. ¿Qué ventajas y observaciones nuevas produce?
4. ¿Cómo conducen los métodos previos al desafío que resolvemos?

Estructura en cinco partes:
1. Tarea y aplicación.
2. Fallo del estado del arte y causa técnica raíz, RQ2.
3. Método propuesto, por qué funciona y observación nueva.
4. Aportaciones adicionales.
5. Resumen experimental y lista de aportaciones.

La lista contiene hechos, sin «novedoso» ni «significativo». Cada aportación corresponde a un experimento.
Consulta `references/examples/pipeline-v1.md`, `references/examples/pipeline-v2.md` y `references/examples/pipeline-v3.md`.

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

Continúa con `/research[G.5]-related`.

## Referencias

- Guía: `references/section-guide.md`
- Restricciones comunes: `references/common-writing-constraints.md`
- Flexibilidad: `references/template-flexibility.md`
