# Restricciones comunes de redacción

Se aplican a todas las fases de escritura G.1–G.6; se usan también cuando G.0 o G.7 remiten a este archivo.

## Preparación obligatoria

### 1. Manuscrito completo

Lee el texto actual de `docs/manuscripts/paper.md` o el archivo LaTeX elegido. Comprende estructura, argumentos y términos; conserva la continuidad con lo ya escrito.

### 2. Referencias existentes

Lee todas las entradas de la sección bibliográfica o `docs/manuscripts/references.bib`.

### 3. Arquitectura e intención de cambio

Lee el bloque de cabecera `=== Paper Architecture ===`; reconoce asimismo el marcador heredado `=== 论文架构 ===`. Identifica contenido y figuras de la sección.

Detecta en cada invocación si el usuario pide añadir, eliminar, renombrar, mover, combinar o dividir secciones o figuras, o si sus instrucciones contradicen la arquitectura. También cuentan cambios implícitos como unir dos módulos en una subsección.

Si hay intención de cambio:
1. Lista estructura anterior → nueva e impactos en secciones escritas, numeración y referencias.
2. Confirma esa lista con el usuario.
3. Actualiza el bloque de arquitectura antes de continuar.
4. En la tarjeta del plan, identifica qué pasajes existentes necesitan sincronización.

Si no la hay, continúa. Si la escritura introduce después ajustes estructurales, sincroniza el bloque.

### 4. Informe y código

Lee todo `docs/idea_report.md`, especialmente la parte relevante, y los resultados de `docs/dev_log.md`. Consulta código concreto si hace falta entender la implementación.

### 5. Ejemplos

En la primera redacción de una sección, si hay PDF o Markdown originales en `docs/manuscripts/examples/`, lee directamente la sección correspondiente del ejemplo. Extrae estructura y estilo. `style-notes.md` es complementario y no sustituye la lectura original. Crea o actualiza ese archivo con lo aprendido.

Al revisar una sección ya escrita, basta leer las notas existentes.
La estructura y estilo de los ejemplos prevalecen sobre las recomendaciones de Master-cai; las normas de rigor siguen vigentes.

### 6. Anotaciones bibliográficas

Comprueba en cada entrada «Aportación principal» y «Motivo de la cita».
En Markdown son líneas `>` bajo cada [N]; en BibTeX, comentarios `%` antes de cada entrada.
Completa lo que falte desde el contexto y el original de `docs/papers/`. Si no está, verifica mediante `web_search`; si no puede confirmarse, marca `⚠️ [confianza baja: original no leído]`.
Esto no bloquea por sí solo el flujo; incluye lo pendiente en la tarjeta siguiente.

### 7. Confirmación del plan

Presenta el plan y espera confirmación explícita antes de escribir:

```text
Preparación de {sección}.

Leído:
- Manuscrito: {N} secciones; ya escritas: {lista}.
- Referencias: {N}.
- Plan de arquitectura de esta sección.
- Informe, parte {N}: {síntesis relevante}.
- Registro experimental: {métricas clave}.
- Referencias por verificar: {lista, solo si hay pendientes}.

Arquitectura actualizada: {cambios, solo si los hubo}.
Ubicaciones que sincronizar: {solo si procede}.

Plan de la sección: {contenido de cada párrafo}.
Figuras y tablas: {las previstas en la arquitectura}.
Citas previstas: {referencias del informe y bibliografía}.
Decisiones pendientes: {1–3 preguntas, si hacen falta}.

Comenzaré tras confirmar el plan.
```

Si el usuario lo rechaza, modifica y vuelve a confirmar; no omitas este paso.

## Versiones

Antes de escribir, copia el manuscrito a `paper_{mm-dd_hh-mm}.md` o `.tex`.
Después registra en la cabecera:

```markdown
<!--
Modificado: {mm-dd_hh-mm}
Cambios: {sección y modificación}
Copia anterior: {nombre real de la copia más reciente que existía antes de esta copia; o «primera copia»}
-->
```

En LaTeX usa comentarios `%`. El nombre de la copia debe ser real; no dejes un marcador.

## Anotaciones

Busca anotaciones en todo el manuscrito antes de editar: `> %Anotación:` en Markdown y `%Anotación:` en LaTeX. Reconoce también las convenciones de anotación existentes en el documento.
Aplica las inequívocas y elimina solo las resueltas.
Si hay ambigüedad, pregunta antes de modificar.
Si afectan a otras secciones, informa y propone sincronizarlas.

## Normas globales

1. Primera aparición de un término: nombre completo y sigla; después solo sigla. No repitas definiciones.
2. Un mensaje central por párrafo; primera frase resume su contenido.
3. Todas las cifras, estadísticas e hiperparámetros provienen del informe, registro o archivos de `results/`. No inventes ni estimes.
4. Cada afirmación principal necesita resultados o bibliografía que la respalden.
5. Referencias uniformes: `Fig.N` y `Table N` en todo el manuscrito.

## Mantenimiento bibliográfico

Añade inmediatamente las referencias nuevas a Markdown o BibTeX:

```markdown
[N] {Autor}. "{Título}." *{Revista/Congreso}*, {Año}.
> Aportación principal: {qué hace el trabajo, en una frase}
> Motivo de la cita: {ubicación y razón concreta}
```

```bibtex
% [Aportación principal] {aportación en una frase}
% [Motivo de la cita] {sección}: {razón}
@article{key,
  author = {...},
  ...
}
```

Ambas anotaciones son obligatorias. Verifica la existencia de cada fuente en `docs/papers/` o mediante búsqueda web. Nunca inventes referencias.
