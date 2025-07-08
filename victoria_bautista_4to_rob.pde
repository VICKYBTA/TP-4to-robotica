// Variables de la pelota
float pelotaX = 300;
float pelotaY = 200;
float velocidadX = 3;
float velocidadY = 4;
float radio = 15;

// Variables del rectángulo (paleta)
float rectX;
float rectY;
float rectAncho = 100;
float rectAlto = 15;
float velocidadRect = 5;

// Puntuación
int puntos = 0;

void setup() {
  size(600, 400);
  ellipseMode(RADIUS);
  rectX = width / 2 - rectAncho / 2;
  rectY = height - 40; // posición vertical del rectángulo
  textAlign(LEFT, TOP);
  textSize(20);
}

void draw() {
  background(255);

  // Mover la pelota
  pelotaX += velocidadX;
  pelotaY += velocidadY;

  // Rebote con los bordes de la ventana
  if (pelotaX < radio || pelotaX > width - radio) {
    velocidadX *= -1;
  }

  if (pelotaY < radio) {
    velocidadY *= -1;
  }

  // Verificar colisión con el rectángulo
  if (pelotaY + radio >= rectY &&
      pelotaX >= rectX && pelotaX <= rectX + rectAncho &&
      velocidadY > 0) {
    velocidadY *= -1;
    pelotaY = rectY - radio; // evitar que se quede dentro
    puntos++; // Aumentar puntos al golpear la paleta
  }

  // Si la pelota cae fuera de la pantalla (pasa la paleta)
  if (pelotaY - radio > height) {
    puntos = 0; // Reiniciar puntos
    // Reiniciar posición de la pelota
    pelotaX = width / 2;
    pelotaY = height / 2;
    velocidadY = 4;
    velocidadX = 3;
  }

  // Mover el rectángulo con flechas o teclas A y D
  if (keyPressed) {
    if ((keyCode == LEFT || key == 'a' || key == 'A') && rectX > 0) {
      rectX -= velocidadRect;
    }
    if ((keyCode == RIGHT || key == 'd' || key == 'D') && rectX < width - rectAncho) {
      rectX += velocidadRect;
    }
  }

  // Dibujar la pelota
  fill(0, 100, 255);
  ellipse(pelotaX, pelotaY, radio, radio);

  // Dibujar el rectángulo
  fill(0);
  rectX = mouseX;
  rect(rectX, rectY, rectAncho, rectAlto);

  // Mostrar puntuación
  fill(0);
  text("Puntos: " + puntos, 10, 10);
}
