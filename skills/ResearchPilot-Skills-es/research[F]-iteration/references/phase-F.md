# Flujo detallado de F: Iteración del código

Los requisitos del usuario prevalecen. El historial de `dev_log.md` solo admite adiciones.
Se activa con `/research[F]-iteration` tras E cuando los resultados no satisfacen. Repite F-1 → F-5 → F-1 hasta que lo hagan.

## F-1: Diagnóstico

Lee antes de diagnosticar:
- todo el registro y el historial de iteración;
- JSON de evaluación, CSV de ablaciones y otros resultados reales;
- parte 2, método, y parte 3, diseño.

Entrega un informe con métricas actuales frente a referencias y tres perspectivas:
1. Datos: procesamiento, particiones y normalización, con observaciones de respaldo.
2. Modelo: módulos que limitan el rendimiento y evidencia de ablaciones, con cifras.
3. Entrenamiento: hiperparámetros, convergencia, sobreajuste o infraajuste, con curvas.

Propón mejoras vinculadas a problemas concretos. Pide confirmar diagnóstico y dirección antes de F-2.

## F-2: Alcance

Criterios:
- métricas bajas pero todos los módulos aportan en ablación: priorizar hiperparámetros o entrenamiento;
- quitar un módulo no empeora, o solo uno concentra la mejora: revisar arquitectura;
- referencias inadecuadas, distribución de datos, métricas ajenas a RQ o pruebas que no responden a las preguntas: revisar diseño experimental.

Presenta para confirmar:
- Solo hiperparámetros: configs/ y registro; no hace falta tocar diseño si no cambia.
- Arquitectura: parte 2, posibles ablaciones de parte 3 y guía.
- Experimentos: parte 3 y guía.

El usuario confirma el alcance. Actualiza documentos antes de código cuando corresponda; nunca apliques parches sin sincronizar el diseño afectado.

## F-3: Documentos

Solo hiperparámetros: cambia YAML y añade registro.
Arquitectura: actualiza marco, procedimiento y modelo de parte 2; revisa parte 3; actualiza funciones afectadas en la guía.
Experimentos: actualiza parte 3 y guía.
Valida cobertura, coherencia e integridad de la guía.
Muestra resumen por documento, módulos y validación, y confirma antes de modificar código.

## F-4: Código

Implementa según documentos actualizados y añade tras cada archivo:

```markdown
### {YYYY-MM-DD HH:MM}: Iteración #{N}, {resumen}

**Motivo**: {problema del diagnóstico}
**Cambios**:
- `{archivo}`: {modificación}
**Efecto esperado**: {métrica y motivo}
**Sincronización documental**: idea_report.md {sí/no} | implementation.md {sí/no} | configs/ {sí/no}
```

Si cambia un comando o argumento, actualiza «Cómo ejecutar». No alteres código silenciosamente.

## F-5: Validación

Respeta E-0: ejecutar directamente si es automático; si ejecuta el usuario, proporcionar comando y esperar resultados.
Después añade, sin sobrescribir:

| Métrica | Antes | Después | Cambio |
|---|---|---|---|
| {métrica} | {real} | {real} | {dirección y magnitud} |

Incluye fecha, número de iteración y conclusión sobre eficacia y razones.

## F-6: Decidir

Resume mejor resultado, relación con la referencia (supera/iguala/inferior) y alternativas:
- satisfactorio → `/research[G.0]-plan`;
- mejorar más → F-1;
- cambio de idea → `/research[B]-idea`;
- rediseño experimental → `/research[C]-experiment`.

Al terminar informa del número de rondas y registro de resultados finales.
