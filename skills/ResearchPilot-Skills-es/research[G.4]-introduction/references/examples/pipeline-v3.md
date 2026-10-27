# Procedimiento, versión 3: Nuevo módulo sobre estructura existente

Ejemplo adaptado de Deep Snake:
se parte de contorno inicial y se regresa un desplazamiento por vértice.
La aportación es una convolución circular para aprender características del contorno; la figura muestra su función.
El contorno forma un grafo de ciclo: cada vértice tiene dos vecinos. Esto permite convolución 1D.
La periodicidad motiva aplicar un núcleo aperiódico a características periódicas.
El núcleo aprende tanto características del vértice como relaciones con vecinos. Frente a una agregación genérica de GCN, constituye una función de agregación aprendible más expresiva; la evidencia experimental debe demostrar la ventaja.

Orden: procedimiento previo → módulo nuevo → observación → mecanismo → comparación técnica y respaldo.
