# Reglas de flexibilidad de las plantillas

Estas reglas prevalecen sobre todas las instrucciones concretas de otras plantillas. Lee este archivo antes de generar documentos.

## Tipos de capítulos

| Tipo | Definición | Tratamiento |
|---|---|---|
| REQUIRED, obligatorio | Debe aparecer en todos los proyectos; admite N/A, pero no omisión | Generarlo siempre; extensión según complejidad |
| OPTIONAL, opcional | Solo tiene sentido para determinados estudios | Incluir si corresponde. Si se omite, anotar `> Omitted: {capítulo} — {motivo}` en la cabecera |
| EXTENSIBLE, ampliable | Necesario para la investigación, aunque no esté definido | Añadir libremente y anotar `> Extended: {capítulo}` |

## Extensión y subsecciones

Las cantidades «3–5 frases», «5–8 artículos» o «≤3 elementos» son orientativas, no límites estrictos. Escribe lo necesario para transmitir toda la información.

Un contexto sencillo puede necesitar 1–2 frases; un campo amplio, más de 10 referencias; un método con 6 componentes, 6 subsecciones.
El número de subsecciones sigue al contenido:
- una por componente innovador en el método;
- una por archivo Python en los detalles de implementación;
- tantas entradas de desarrollo como módulos se completen.

Usa títulos semánticos, nunca marcadores como `{Module Name}` o `{Core Component}`.

## Clasificación por documento

### idea_report.md, partes 1 y 2

Obligatorios: motivación; necesidad práctica, teórica y temporal; preguntas de investigación; tabla de trabajos clave; fichas individuales; introducción; trabajos relacionados; método; referencias.
La necesidad no puede omitirse por falta de evidencia: se marca confianza baja.
Debe existir al menos una RQ principal; las secundarias son opcionales.
La lista de verificación pendiente es opcional si todo está verificado y no hay contenidos de confianza baja.

### idea_report.md, parte 3

Obligatorios:
- estudio experimental de cada método de referencia;
- síntesis de convenciones del campo;
- disponibilidad de datos y código;
- conjuntos de datos;
- experimentos principales;
- ablaciones;
- experimentos complementarios habituales del campo; pueden omitirse solo si no existe ningún tipo recurrente;
- extensiones elegidas por el usuario; pueden omitirse si decide no realizar ninguna;
- estimación de recursos orientativa.

### implementation.md

Consulta la [guía de implementación de D](../../research[D]-implementation/references/phase-D.md) para el formato completo.

Formato A, modificación de un proyecto sólido: información del proyecto original, alcance de cambios, árbol completo resultante, tabla por archivo, explicación de archivos y funciones que cambian, preparación de datos, formatos de resultados y orden de implementación. Todo obligatorio.

Formato B, desde cero: árbol completo con `notebooks/`, tabla por archivo, detalles de cada función (firma, parámetros, retorno y lógica), preparación de datos, formatos de resultados y orden de implementación. Todo obligatorio. La descripción de formatos de datos es opcional en trabajos puramente algorítmicos sin formato propio.

El árbol y la tabla por archivo son los dos elementos clave al comienzo; no basta una tabla por directorio.

### dev_log.md

Obligatorios: visión general, arquitectura del proyecto, lógica del proyecto, avance y entradas de desarrollo.
La arquitectura del modelo es opcional si no hay modelo propio, por ejemplo en un flujo de datos.
Los problemas conocidos pueden omitirse inicialmente y añadirse cuando aparezcan.
Mantén «Cómo ejecutar» al final según la fase E.

### code_guide.md

Formato obsoleto: la lógica está en `docs/implementation.md`; instalación y ejecución, en `code/README.md` o la ubicación confirmada.

## Preferencias documentales

Antes de generar documentos, lee el campo «Preferencias documentales» de `user_requirements.md`, reconociendo también `### Document Preferences`.
- Idioma: español por defecto; respeta cualquier otro idioma confirmado.
- Detalle de introducción: borrador provisional por defecto o versión detallada apta para publicación.
- Formato de datos: generar por defecto u omitir.
- Tabla de ablaciones: una tabla por defecto o separada por dimensión.
- Formato libre: respeta cualquier otra preferencia estructural o de contenido del usuario.
