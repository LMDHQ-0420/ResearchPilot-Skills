# Flujo detallado de C: Diseño experimental

Se entra tras confirmar B. El propósito es demostrar rigurosamente la idea; no recortes el diseño para ajustarlo a recursos. No recopiles límites de GPU o entrenamiento antes de diseñar. Estima después, solo como orientación.

## C-1: Leer artículos y código de referencia

Extrae las referencias de comparación de la parte 2. Presenta una tabla con modelo, artículo [n], repositorio y motivo de lectura; el usuario puede modificarla. Espera confirmación.

Para cada método, reutiliza el PDF descargado o sigue la descarga confirmada; lee README y scripts centrales si son accesibles.
Extrae:
- datos, escala y particiones: proporciones, división oficial o validación cruzada;
- experimentos principales, ablaciones y complementarios, con propósito;
- modelos comparados y lógica de selección;
- métricas y cálculo;
- batch size, tasa de aprendizaje, épocas y otros hiperparámetros.

Presenta la síntesis y confirma antes de C-2.

## C-2: Convenciones del campo

Busca estudios del mismo campo de los últimos 3 años. Combina con C-1 para identificar bancos de prueba, métricas, patrones de ablación y normas de tablas: desviación, número de ejecuciones, semillas y promedios.

## C-3: Disponibilidad

Comprueba viabilidad de obtener datos y código, no suficiencia de VRAM.
- Datos: enlace accesible, disponibilidad pública y proceso de solicitud si existe.
- Código: repositorio accesible, compatibilidad; si no existe, indica «requiere implementación propia».

Si no pueden obtenerse, detente e informa al usuario.
Al final de la sección 0, tabla elemento / estado ✅⚠️❌ / notas.

## C-4: Confirmar esquema

Antes de redactar detalles, presenta datos previstos para pruebas principales y complementarias y sus motivos.
Tabla: experimento, tipo, intención de diseño y punto del método que respalda, número de modelos, referencia principal y motivo.
Incluye ablaciones y todos los análisis habituales del campo.
Ofrece extensiones desde diversos ángulos y explica la propiedad validada. El usuario elige cuáles.
Itera hasta confirmar el esquema completo, incluidas esas elecciones.

## C-5: Redactar parte 3

Usa `document-formats.md` y añade al informe:
- sección 0 directamente de C-1;
- convenciones de C-2;
- datos y diseño conforme al esquema C-4;
- campo obligatorio «Por qué se diseña así» por experimento;
- explicación individual de cada modelo: diferencia, utilidad y artículo fuente, este último solo informativo;
- referencia principal y su motivo;
- análisis habituales obligatorios separados de extensiones elegidas.

Justifica las decisiones con `>` y citas cuando haya respaldo bibliográfico.

## C-6: Estimar recursos después

Según escala del modelo, datos y número de grupos, añade una tabla de experimento / VRAM estimada / tiempo por ejecución / grupos.
Aclara que son estimaciones aproximadas dependientes de hardware e implementación, no límites del diseño.
Si faltan recursos, se pueden priorizar pruebas centrales y ejecutar por lotes manteniendo el rigor.

## C-7 y C-8: Confirmar y refinar

Tras cada salida pregunta si el plan está completo o necesita ajustes.
Actualiza la parte 3 y vuelve a confirmar tantas veces como sea necesario.
Solo con confirmación explícita continúa con `/research[D]-implementation`.
