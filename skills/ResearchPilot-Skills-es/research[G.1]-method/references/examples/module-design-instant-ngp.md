# Ejemplo de diseño: Instant-NGP

Adaptación al español del ejemplo de codificación hash multirresolución. Los comentarios indican la función de los párrafos siguientes.

## Motivación

Dada una red completamente conectada \(m(y;\Phi)\), buscamos una codificación \(y=\operatorname{enc}(x;\theta)\) que mejore aproximación y velocidad de entrenamiento en distintas aplicaciones sin un coste de ejecución notable.

## Diseño: estructura

Además de pesos \(\Phi\), entrenamos parámetros de codificación \(\theta\), organizados en \(L\) niveles de hasta \(T\) vectores de dimensión \(F\). Cada nivel almacena conceptualmente características en vértices de una rejilla, con resolución en progresión geométrica:

\[
N_l=\lfloor N_{\min}b^l\rfloor,\qquad
b=\exp\left(\frac{\ln N_{\max}-\ln N_{\min}}{L-1}\right).
\]

\(N_{\max}\) corresponde al detalle más fino de los datos; \(L\) es el número de niveles, \(N_{\min}\) la resolución mínima y \(b\) el crecimiento, en los ejemplos entre 1.26 y 2.

## Diseño: proceso

En el nivel \(l\), escala \(x\in\mathbb{R}^d\):

\[
\lfloor x_l\rfloor=\lfloor xN_l\rfloor,\qquad
\lceil x_l\rceil=\lceil xN_l\rceil.
\]

Esos extremos delimitan un vóxel con \(2^d\) vértices enteros. Cada vértice apunta a una entrada de un arreglo de hasta \(T\) características.
Si \((N_l+1)^d\le T\), la correspondencia es directa. En resoluciones finas se usa hash \(h:\mathbb{Z}^d\rightarrow\mathbb{Z}_T\), sin gestión explícita de colisiones: optimización y red posterior aprenden a resolverlas.
Los parámetros de codificación quedan acotados por \(TLF\); el ejemplo usa \(L=16\), \(F=2\).

\[
h(x)=\left(\bigoplus_{i=1}^{d}x_i\pi_i\right)\bmod T.
\]

\(\oplus\) es XOR bit a bit y \(\pi_i\) son primos grandes distintos. La combinación reduce correlaciones entre dimensiones. Se elige \(\pi_1=1\) para coherencia de caché, \(\pi_2=2{,}654{,}435{,}761\) y \(\pi_3=805{,}459{,}861\).
Interpola las características de los vértices en \(d\) dimensiones, con posición relativa \(w_l=x_l-\lfloor x_l\rfloor\).

El proceso es independiente por nivel. Concatena características interpoladas y entradas auxiliares \(\xi\in\mathbb{R}^E\), por ejemplo dirección de vista codificada, para producir \(y\in\mathbb{R}^{LF+E}\), entrada a \(m(y;\Phi)\).

## Ventaja y compromiso

El tamaño \(T\) controla memoria, calidad y rendimiento: aumentarlo mejora calidad a costa de memoria y velocidad. El ejemplo ilustra cómo definir estructura y proceso antes de discutir ese compromiso.
