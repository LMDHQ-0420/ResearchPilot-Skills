# Procedimiento, versión 1: Una aportación y varias ventajas

Presenta marco/representación, figura general, idea central, pasos y ventajas.

Ejemplo adaptado de Neural Body:
- Se introduce una representación implícita de humanos dinámicos para sintetizar vistas desde observación escasa.
- La figura general muestra la idea.
- Los campos de distintos fotogramas se generan desde el mismo conjunto de códigos, en vez de aprenderse por separado.
- Los códigos se anclan a vértices SMPL y sus posiciones cambian con la pose estimada desde cámaras escasas. Una red predice densidad y color en 3D. Red y códigos se aprenden conjuntamente con todos los fotogramas.
- La representación integra observaciones temporales.
- La malla deformable aporta un prior geométrico de superficie que facilita el aprendizaje.

Esqueleto: «Proponemos {método} para {tarea}. La Fig.{N} muestra {idea}. La aportación es {una frase}. En concreto, {pasos}. Esto permite {ventaja 1}. Además, {ventaja 2}».
