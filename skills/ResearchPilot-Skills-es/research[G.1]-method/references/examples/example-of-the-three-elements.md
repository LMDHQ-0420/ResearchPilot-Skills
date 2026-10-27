# Ejemplo de los tres elementos: Neural Body

Adaptación al español. Cada anotación identifica la función del texto siguiente: diseño de estructura, motivación, ventaja técnica o proceso.

## 3.1 Códigos latentes estructurados

**Diseño, estructura.** Para que los códigos sigan la pose, se anclan al modelo humano deformable SMPL [38]. SMPL depende de forma, pose y transformación rígida, y devuelve una malla de 6890 vértices.
Se define \(Z=\{z_1,\ldots,z_{6890}\}\) sobre esos vértices. Para el fotograma \(t\), se estiman parámetros \(S_t\) desde imágenes multivista \(\{I_t^c\mid c=1,\ldots,N_c\}\) mediante [26]. Las posiciones se transforman según la pose para regresión de densidad y color. En el ejemplo, cada \(z\) tiene dimensión 16.

**Ventaja técnica.** Como en representaciones implícitas locales [25,5,18], los códigos y una red representan geometría y apariencia local. Anclarlos a un modelo deformable permite representar movimiento. El mismo conjunto de códigos produce campos de densidad y color de distintos fotogramas, integrando sus observaciones.

## 3.2 Difusión de códigos

**Motivación.** Los campos implícitos requieren consultar códigos en posiciones 3D continuas. La interpolación trilineal directa de códigos dispersos devuelve vectores nulos en muchas posiciones. Por ello se difunden los códigos de superficie al espacio cercano.

**Diseño, proceso.** Siguiendo [65,56,49], SparseConvNet [21] procesa los códigos. Se obtiene la caja 3D desde SMPL y se divide en vóxeles de \(5\,mm\times5\,mm\times5\,mm\). El código de un vóxel ocupado es la media de los códigos de sus vértices SMPL.
Convoluciones dispersas y submuestreo producen volúmenes a factores \(2,4,8,16\), difundiendo información.
Se interpolan códigos de las capas 5, 9, 13 y 17 y se concatenan. Para eliminar dependencia de ubicación/orientación global, se transforman al sistema SMPL.

Para un punto \(\mathbf{x}\), se transforma su posición a ese sistema y se interpola trilinealmente. Con pose \(S_t\), el código se denota \(\psi(\mathbf{x},Z,S_t)\) y se entrega a redes MLP para estimar densidad y color.

## 3.3 Regresión de densidad y color

**Diseño, proceso de densidad.**

\[
\sigma_t(\mathbf{x})=M_\sigma(\psi(\mathbf{x},Z,S_t)).
\]

\(M_\sigma\) es una MLP de cuatro capas; \(\sigma_t\) es densidad del punto.

**Diseño, estructura de color.** Además del código y dirección de vista \(\mathbf{d}\), se usa la posición \(\mathbf{x}\) para luz incidente dependiente de ubicación. Una incrustación \(\ell_t\) por fotograma, inspirada en auto-decodificadores [48], captura iluminación secundaria y autosombreado variables en el tiempo.

**Diseño, proceso de color.**

\[
c_t(\mathbf{x})=M_c\bigl(\psi(\mathbf{x},Z,S_t),
\gamma_d(\mathbf{d}),\gamma_x(\mathbf{x}),\ell_t\bigr).
\]

\(M_c\) tiene dos capas; \(\gamma_d\) y \(\gamma_x\) son codificaciones posicionales para dirección y posición, que facilitan funciones de alta frecuencia. \(\ell_t\) tiene dimensión 128 en el ejemplo.

## 3.4 Renderizado volumétrico

**Diseño, proceso.** Para un punto de vista se integra densidad y color a lo largo de cada rayo [27], aproximando por cuadratura [41,44]. Con parámetros de cámara, se obtiene \(\mathbf{r}\) y se muestrean \(N_k\) puntos entre límites derivados de SMPL. Neural Body predice densidad y color y acumula el color renderizado.

Los números de cita pertenecen al ejemplo original; no se transfieren como bibliografía verificada de otro proyecto.
