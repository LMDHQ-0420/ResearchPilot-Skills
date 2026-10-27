# Flujo detallado de D: Diseño de implementación

Lee primero `docs/user_requirements.md`: framework, dispositivo, estilo y requisitos obligatorios prevalecen sobre este documento. Se entra tras confirmar C.

## D-0: Restricciones y estrategia

Si no consta ya, pregunta por framework, requisitos especiales (estilo, varias GPU, ONNX) y requisitos firmes. Registra las respuestas.
Confirma si se modifica un proyecto abierto sólido o se construye desde cero.

Para un proyecto existente: obtenerlo, analizar árbol, clases, funciones y dependencias, confirmar funciones que conservar y preparar cambios por archivo y función.
Desde cero: recoger restricciones y diseñar todos los componentes.

## D-1: Guía

Precisión obligatoria:
- cada directorio y archivo: contenido y responsabilidad;
- cada función: firma tipada, parámetros con significado y rango, retorno tipado y lógica;
- cada resultado: nombre, formato, campos, tipos, unidades y significado;
- decisiones con anotaciones `>` y fuentes cuando corresponda.

## Formato A: Proyecto existente

Abre con información original y alcance de cambios, árbol completo resultante y tabla por archivo.
Después detalla los archivos existentes y cada función que cambiará: comportamiento anterior, nuevo, motivo, interfaces y dependencias que conservar.
Incluye preparación de datos, formatos de resultados y orden de implementación. Aplica las mismas reglas de precisión del formato B.

## Formato B: Desde cero

````markdown
# Guía de implementación: {tema}
> Generado: {YYYY-MM-DD} | Estrategia: desde cero | Estado: PENDING_REVIEW
> Diseño experimental: docs/idea_report.md, parte 3

## 1 Estructura del proyecto

### 1.1 Árbol completo

```text
code/
├── src/
│   ├── models/
│   │   ├── {model_name}.py
│   │   └── baseline/
│   │       ├── {baseline1}.py
│   │       └── {baseline2}.py
│   ├── data/
│   │   ├── {dataset}_dataset.py
│   │   └── transforms.py
│   ├── utils/
│   │   ├── metrics.py
│   │   └── logger.py
│   ├── train.py
│   ├── evaluate.py
│   └── predict.py
├── scripts/
│   ├── train.sh
│   ├── evaluate.sh
│   └── ablation.sh
├── configs/
│   ├── default.yaml
│   └── ablation_{variant}.yaml
├── notebooks/
├── data/
│   ├── raw/
│   └── processed/
├── results/
├── logs/
├── README.md
└── requirements.txt
```

### 1.2 Tabla por archivo

| Archivo | Función | Entrada | Salida | Invocado por |
|---|---|---|---|---|
| {ruta} | {responsabilidad} | {formato y forma} | {formato y forma} | {llamador} |

## 2 Flujo de datos

{Archivos originales → lectura y campos → tratamiento de ausentes → preprocesamiento → partición → normalización → ventanas/muestreo → tensores x e y con significado y forma}

> {Razones de partición y normalización según parte 3}

## 3 Detalles por archivo

### 3.1 Datos

**Responsabilidad**: cargar y preparar {conjunto}.
**Clase**: {DatasetName}(Dataset).
**Inicialización**: data_path (str), split (str: train/val/test), {otros tipos, rangos}.
**Lógica**: leer formato original, dividir según estrategia confirmada, normalizar y crear ventanas si procede.
**__len__() -> int**: {cómputo de muestras}.
**__getitem__(idx) -> tuple[Tensor, Tensor]**: {extracción y formas de x e y}.

### 3.2 Modelo propuesto

**Clase**: {ModelName}(nn.Module).
**Inicialización**: input_dim (int), hidden_dim (int, predeterminado {N}), {otros}.
**forward(x: Tensor) -> Tensor**:
- Entrada: [B, L, D].
- Lógica: {módulo A y cambio de forma} → {módulo B} → {cabeza}.
- Salida: [B, {output_dim}].

### 3.3 Referencias de comparación

{Una implementación por modelo, mecanismo central, inicialización y forward con la misma interfaz que el modelo propuesto}

> La misma interfaz permite sustituir el modelo sin cambiar el entrenamiento.

### 3.4 Entrenamiento

**Trainer**: model, train_loader, val_loader y config.
- train_one_epoch() -> float: pérdida media.
- validate() -> tuple[float, dict]: pérdida y métricas.
- fit() -> None: épocas, entrenamiento, validación, parada temprana y mejor checkpoint.
{Planificador de tasa y lógica exacta}

### 3.5 Métricas

| Función | Métrica | Fórmula | Rango | Dirección |
|---|---|---|---|---|
| {metric}(pred, true) | {nombre} | {definición} | {rango} | Mayor/menor mejor |

{Funciones sin estado; matrices numpy de entrada y float de salida}

### 3.6 Configuración

{Hiperparámetros centralizados por grupos data, model, training y logging}

| Parámetro | Grupo | Valor | Justificación |
|---|---|---|---|
| data.seq_len | data | {N} | {parte 3} |
| model.hidden_dim | model | {N} | {motivo} |
| training.lr | training | {valor} | {motivo} |
| training.batch_size | training | {N} | {convención o memoria} |
| training.patience | training | {N} | {parada temprana} |

{Cada ablación usa configs/ablation_{variant}.yaml mediante --config}

### 3.7 Scripts

{Ensamblar argumentos y ejecutar con nohup. train.sh llama src/train.py; evaluate.sh llama src/evaluate.py; ablation.sh recorre configuraciones. Registros en logs/YY-MM-DD_HH-MM-SS.log, redirigiendo stdout/stderr; informar PID y ruta.}

## 4 Descarga y preparación de datos

| Datos | Tipo | Fuente | Enlace | Destino |
|---|---|---|---|---|
| {nombre} | {tipo} | {fuente} | {enlace} | {ruta} |

{Comandos exactos, requisitos de acceso y árbol tras descarga}

## 5 Formatos de resultados

### 5.1 Pesos

results/checkpoints/best.pth: state_dict de PyTorch de la mejor época de validación.
Carga: torch.load('results/checkpoints/best.pth', map_location='cpu').

### 5.2 Registros

logs/YY-MM-DD_HH-MM-SS.log: toda la salida de cada ejecución.

### 5.3 Evaluación

results/eval_{timestamp}.json:

| Campo | Tipo | Unidad | Significado | Dirección |
|---|---|---|---|---|
| {metric1} | float | {unidad} | {métrica} | {mayor/menor mejor} |
| num_samples | int | — | Tamaño de prueba | — |
| dataset | str | — | Nombre del conjunto | — |
| split | str | — | Partición evaluada | — |
| checkpoint | str | — | Ruta de pesos | — |

### 5.4 Predicciones individuales

results/predictions_{timestamp}.csv: sample_id (int, índice), {true_col} (float, valor real), {pred_col} (float, predicción), abs_error (float, valor absoluto de predicción menos realidad). Indicar unidad de cada magnitud.

### 5.5 Ablaciones

results/ablation/summary.csv: variant (corresponde a configuración), {metric1} (resultado de prueba), notes (descripción).

## 6 Orden de implementación

requirements.txt → configs/ → README inicial → datos → módulos innovadores y modelo completo → referencias → entrenamiento → métricas y registro → evaluación → inferencia opcional → scripts y README completo.
````

## Reglas del árbol y de los módulos

Un modelo propuesto va directamente en `src/models/{model_name}.py`.
Para datos, entrenamiento o evaluación, si solo hay un archivo colócalo directamente en `src/`; crea subdirectorio si hay varios.
Usa `data/raw/` y `processed/` solo cuando haya archivos intermedios; si no, guarda directamente bajo `data/`.
Modelos: solo estructura, sin bucle de entrenamiento.
Referencias: misma interfaz de entrada/salida.
Datos: sin lógica de modelo.
Utilidades: funciones sin estado.
Scripts: argumentos y nohup, sin lógica de negocio.
Calcula normalización desde entrenamiento y aplícala a las demás particiones.

## D-end1: Validar y confirmar

Inmediatamente tras generar o revisar:
1. Todos los experimentos tienen módulos o funciones.
2. Las formas de tensores coinciden.
3. Cada archivo listado tiene detalles correspondientes.

Corrige antes de presentar; muestra resultados de validación y pregunta si la guía es suficiente. Repite tras cambios.

## D-end2: Antes de programar

Confirma entorno y reutilización, requisitos de dispositivo, preparación de cada conjunto, ejecución automática/usuario/mixta, Git si procede y ubicación de README. La lista puede recogerse al finalizar D o al iniciar E, pero debe estar completa antes de programar.
Tras guía y lista confirmadas, remite a `/research[E]-coding`.

Después de cada archivo implementado, actualiza avance y añade registro; sincroniza README si cambian entorno o comandos.
Solo marca completado tras escribir y ejecutar sin errores; en estrategia de ejecución del usuario, espera su confirmación.
