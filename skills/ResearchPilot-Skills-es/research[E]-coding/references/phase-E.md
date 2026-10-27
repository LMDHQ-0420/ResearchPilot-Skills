# Flujo detallado de E: Programación

Lee requisitos antes de programar; prevalecen sobre los valores predeterminados.
`dev_log.md` solo admite nuevas entradas de historial; nunca borres ni sobrescribas las existentes.
Se entra tras confirmar la guía de D.

## E-0: Lista previa

Antes de programar, presenta juntos los seis puntos; el usuario puede responder uno por uno:
1. Entorno: nombre y si existe para reutilizar; si no, creación según requisitos y herramientas autorizadas.
2. Dispositivo: CUDA, cuDNN, MPS, CPU, Python y otros requisitos.
3. Datos: por conjunto, comprobar si está descargado; descargas rápidas pueden ejecutarse; para grandes, con inicio de sesión o solicitud, proporcionar enlace oficial, comando y destino y esperar.
4. Ejecución: automática para segundos/minutos, usuario para horas/días o mixta.
5. Git: repositorio existente o inicialización, URL, alcance de publicación (todo o solo code/), nombre y correo de Git.
6. README: raíz o code/.

Registra respuestas en `docs/user_requirements.md`. No vuelvas a preguntar lo confirmado en D.
Datos con preprocesamiento van a `data/raw/{dataset}/`; sin él, `data/{dataset}/`.
Para descargas del usuario, informa de enlace, comando y destino y espera su aviso.

Si está autorizado Git, inicializa y configura la identidad confirmada. Excluye datos, pesos grandes, logs, bytecode y secretos. Ejemplo:

```gitignore
data/
results/checkpoints/
results/**/*.pth
results/**/*.pt
results/**/*.bin
results/**/*.ckpt
logs/
__pycache__/
*.pyc
.env
```

CSV/JSON de resultados se versionan por defecto. Antes de publicar, identifica archivos de más de 100 MB y confirma su exclusión.

## E-1: Crear el registro

Cabecera con tema, creación, actualización y enlace a la guía. Indica expresamente que el historial es acumulativo.
Visión general con línea, estrategia, framework, repositorio y alcance.
Tabla de avance por archivo/módulo: inicialización, datos, modelo, referencias, entrenamiento, evaluación, utilidades, scripts y README. Estados:
- ⬜ Pendiente;
- 🔄 En curso;
- ✅ Completado, con ejecución verificada;
- ❌ Bloqueado.

Cada entrada incluye fecha/hora, completado, problemas y solución.
Añade problemas conocidos cuando existan.

Mantén al final «Cómo ejecutar», el manual de ejecución:
- preparación del entorno y requisitos previos;
- cada comando completo de datos, entrenamiento, evaluación y ablación;
- cada parámetro: significado, rango y valor por defecto;
- qué lee, qué hace y qué produce;
- destinos y formatos de salida.
Completa al avanzar y evalúa su actualización después de cada cambio.

## E-2: Implementar por orden

Sigue la guía: dependencias → configuración → datos → modelo → referencias → entrenamiento → utilidades → evaluación → scripts.
Tras cada archivo:
1. actualiza la tabla; solo marca completado si está verificado;
2. añade entrada de historial;
3. actualiza «Cómo ejecutar» si cambian comandos, argumentos, salidas o formatos;
4. sincroniza README y añade notebook si corresponde.

Tras cada módulo comprueba firmas, parámetros, retornos y formas frente a la guía. Si no coinciden, sigue E-5.
Estrategia automática: ejecutar y marcar tras éxito.
Usuario: comprobación estática de importaciones, sintaxis y formas, mantener «En curso» hasta confirmación.
Mixta: ejecutar pruebas rápidas y entregar las largas.

## E-3: Dependencias

`requirements.txt`: solo nombres, sin versiones. Excluir `torch`, `torchvision` y `torchaudio`; la familia PyTorch se prepara según dispositivo y requisitos confirmados.

## E-4: Bloqueos

Detente e informa del problema concreto y opciones: corrección indicada por usuario, volver a B para idea, C para diseño experimental o D para implementación. No eludas el problema en código.

## E-5: Error de la guía

1. Detén la programación.
2. Informa de ubicación, descripción, impacto y propuesta.
3. Espera confirmación.
4. Corrige primero la guía y valídala.
5. Modifica después el código y continúa.
6. Añade registro del problema y corrección.

## E-6: Mejoras pedidas

Cada cambio añade registro de qué, por qué e impacto, y revisión de «Cómo ejecutar». Nunca cambies código sin actualizar el registro.

## E-7: Revisión proactiva

Al terminar, exige:
1. Ejecución sin errores: importaciones, cobertura de dependencias, rutas y configuraciones, scripts nohup y registros correctos.
2. Lógica correcta: módulos coherentes con método, formas de extremo a extremo, pérdida y métricas según parte 3, interruptores de ablación que alteran realmente el comportamiento.

Corrige los problemas de estas dos categorías con confirmación y registro. El estilo o ingeniería opcionales se pueden mencionar en una frase para decisión del usuario.

## E-8: README final

En la ubicación confirmada, incluye visión general desde el informe, entorno y familia PyTorch según guía oficial/dispositivo, instalación de otras dependencias mediante la herramienta elegida y comandos sincronizados con el manual.
Puede existir un borrador temprano; complétalo tras superar la revisión.

## E-9: Git

Si el usuario confirmó repositorio y publicación, prepara commit y publicación con URL, identidad y alcance confirmados. No publiques fuera de ese alcance.
Todo el proyecto: raíz. Solo code/: repositorio correspondiente a ese directorio.
Comprueba archivos grandes antes de publicar y confirma exclusiones.
Los requisitos explícitos de la sesión determinan las herramientas y permisos aplicables.

## E-10: Finalizar

Informa revisión, README y estado real de Git. No afirmes haber publicado si no ocurrió.
Si los resultados fallan, `/research[F]-iteration`; si satisfacen, `/research[G.0]-plan`.
