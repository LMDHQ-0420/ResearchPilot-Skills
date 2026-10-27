# Desafío, versión 3: Tarea nueva

Si no hay métodos directos, declara el objetivo y divide los requisitos en dificultades independientes.

Ejemplo: inferir propiedades intrínsecas de objetos desde una única imagen.
1. Solo hay una imagen, con unas pocas decenas de instancias frente a miles en modelos generativos 3D; el problema queda fuertemente indeterminado.
2. Esas instancias varían en pose e iluminación desconocidas. Las variaciones de apariencia impiden aplicar directamente herramientas de estructura desde movimiento como COLMAP bajo sus supuestos habituales.
3. Las propiedades son probabilísticas: dos rosas no son idénticas. Se busca una distribución de geometría, textura y material para aprovechar la información multivista subyacente.

Consulta [Descomposición](novel-task-decomposition.md).
