# Plantilla de user_requirements.md

Claude crea y mantiene este archivo a partir de la conversación. El usuario no necesita editarlo.
Al iniciar una fase, pregunta solo por detalles que falten; si la entrada ya es suficiente, extrae los requisitos directamente.
Nunca copies los requisitos originales a los documentos principales: estos muestran resultados de ejecución, mientras este archivo conserva las restricciones recopiladas.
El usuario puede indicar preferencias documentales en cualquier momento; actualiza el campo correspondiente.

## Formato

```markdown
# Requisitos del usuario: {tema}
> Creado: {YYYY-MM-DD} | Proyecto: {nombre}
> Completado automáticamente por Claude a partir de la conversación.

## Fase A: Restricciones de la línea y las RQ

### Restricciones de la línea

**Líneas preferidas**
{Ligereza, interpretabilidad, generalización entre dominios u otras preferencias}

**Líneas que evitar**
{Exclusiones}

**Línea confirmada**
{Una frase; pendiente si no está confirmada}

### Restricciones de las preguntas de investigación

**Requisitos de las RQ**
{Por ejemplo, verificables con una GPU o centradas en análisis teórico}

**RQ confirmadas**
{Principal obligatoria; secundarias según corresponda; pendiente si no están confirmadas}

### Artículos de referencia explícitos

{Solo los exigidos por el usuario; ninguno si no hay. No incluir aquí toda la búsqueda propia}

### Explicación detallada por artículo

{Elección sí/no de A-4.5. En ambos casos, las fichas incluyen todos los artículos descargados}

### Preferencias documentales

{Idioma, detalle, estructura. Predeterminado: español completo}

## Fase D: Restricciones de implementación

### Proyecto de partida
{Ruta, URL o desde cero}

### Framework
{Confirmado por el usuario; PyTorch por defecto}

### Entorno de ejecución
{Nombre y si existe para reutilizarlo o debe crearse}

### Requisitos del dispositivo
{CUDA, cuDNN, Apple MPS, solo CPU, versión de Python}

### Preparación de datos
{Por conjunto: existente / descarga rápida de Claude / descarga lenta del usuario}

### Estrategia de ejecución
{Automática / usuario / mixta}

### Ubicación de README
{Raíz del proyecto o code/}

### Otros requisitos obligatorios
{Por ejemplo DDP u ONNX; solo requisitos firmes, no preferencias}
```

## Recopilación

A: si faltan datos, pregunta en una sola intervención por preferencias, exclusiones, requisitos de RQ y artículos de referencia. Confirma línea y RQ una por una. Tras cada confirmación actualiza primero el campo correspondiente y después la tarjeta de la siguiente respuesta. Distingue restricciones de línea y de RQ; tarjeta en `phase-A.md`.

C: no recopila límites de GPU ni tiempo de entrenamiento. Estima recursos al final del diseño y escribe la estimación en la parte 3, solo como referencia.

D: antes de generar la guía, pregunta por framework, proyecto abierto de partida y requisitos firmes. Antes de programar, confirma entorno, dispositivo, preparación de datos, estrategia de ejecución y ubicación del README, según la lista de la habilidad D/E. Registra las respuestas en la sección correspondiente. Los detalles de Git confirmados en E pueden añadirse allí.
