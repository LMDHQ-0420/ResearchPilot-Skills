# Plantilla de visión general del método

Incluye contexto, aportación central, figura opcional y mapa de subsecciones.

```latex
% Contexto, una o dos frases.
% Ejemplo: Dado un vídeo multivista disperso de una persona, buscamos generar
% un vídeo de esa persona desde puntos de vista libres.
% Otro ejemplo: Dada una imagen, estimamos orientación y traslación de objetos en 3D.

% Aportación central, una o dos frases.
% Ejemplo: Extendemos el modelado de escenas estáticas al tiempo y estimamos
% movimiento 3D mediante campos densos de flujo hacia delante y atrás.
% Otro: Deformamos un contorno inicial hasta ajustarlo al límite del objeto.
% Otro: Detectamos puntos clave 2D con CNN y calculamos la pose 6D mediante PnP;
% aportamos una representación de puntos y una modificación de PnP.

% Si el procedimiento aporta una estructura nueva, remitir a la figura general.
% Ejemplo: La Fig.3 presenta la visión general del modelo.

% Explicar qué cubre cada subsección.
% 3.1: códigos latentes estructurados sobre una superficie humana deformable.
% 3.2: difusión de códigos para consultar posiciones cercanas.
% 3.3: redes que decodifican densidad y color.
% Finalmente: estrategias de aceleración del renderizado, si corresponden.
```
