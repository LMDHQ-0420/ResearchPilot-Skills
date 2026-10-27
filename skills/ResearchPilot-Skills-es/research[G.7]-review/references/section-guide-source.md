# Guía de revisión integral

Lee como un revisor escéptico para detectar riesgos de rechazo y corregir antes del envío.
Cada afirmación principal, sobre todo en resumen e introducción, debe ser técnicamente correcta y estar respaldada explícitamente por evidencia. Si no, añade pruebas o limita/elimina la afirmación.

## Dimensiones

| Dimensión | Señales de riesgo |
|---|---|
| Aportación insuficiente | Caso trivial; técnica ya explorada; mejora predecible sin conocimiento nuevo |
| Escritura confusa | Detalles insuficientes para reproducir; motivación ausente |
| Efecto empírico débil | Mejoras marginales o rendimiento absoluto insuficiente |
| Evaluación incompleta | Faltan ablaciones, referencias fuertes, métricas o datos exigentes |
| Diseño problemático | Contexto irreal, defectos, supuestos débiles, reajuste por caso, coste mayor que beneficio |

## Preguntas

Aportación: ¿qué conocimiento nuevo obtiene el lector? ¿El fallo es relevante? ¿La técnica va más allá de práctica conocida? ¿La mejora aporta una observación? ¿Existe aportación clara de tarea, procedimiento, módulo, diseño, hallazgo o explicación?

Claridad: ¿un lector experto puede reproducirlo? ¿Detalles de cada módulo suficientes? ¿Motivación ligada al desafío? ¿Términos y símbolos consistentes? ¿Un mensaje y transición clara por párrafo?

Solidez: ¿mejora relevante frente a referencias fuertes? ¿Nivel absoluto suficiente? ¿Consistencia entre datos, contextos y métricas? ¿Fortalezas y fallos honestos?

Evaluación: ¿cada decisión tiene ablación? ¿Referencias actuales en comparación justa? ¿Métricas estándar suficientes? ¿Escenarios exigentes? ¿Protocolos explícitos?

Diseño: ¿uso práctico realista? ¿Defectos o supuestos ocultos? ¿Robusto sin ajustes intensos por caso? ¿Beneficios superiores a complejidad y límites añadidos? ¿Podría argumentarse valor neto negativo?

## Ejecución

Responde cada pregunta con evidencia y estado: correcto / requiere revisión / requiere nuevo experimento.
Revisa afirmaciones, texto, pruebas o alcance y repite hasta resolver riesgos principales.
Entrega una tabla afirmación/evidencia/estado para resumen e introducción.
Ordena problemas: alta (validez y cadena lógica), media (lectura o respaldo local), baja (estilo).
Resuelve los de prioridad alta antes del envío.
Usa además [Continuidad del texto](writing-flow-source.md) para el esquema inverso.
