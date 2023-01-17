class kale4 extends Anim {
  
  //DRAW SCENE 
 void loop(PGraphics target) {
   
  int previewScale = 8;

  led.beginDraw();
  led.noStroke();
  led.fill(r, g, b);
  if (mousePressed) {
    led.rect(mouseX / previewScale, mouseY / previewScale, size, size);
    //MASCARA Y APAGAR

    led.image (mask, 0, 0);
    image(led, 10, 10, MATRIX_WIDTH * 8, MATRIX_HEIGHT * 8);
  }
  led.endDraw();
 image(led, 10, 10, MATRIX_WIDTH * 8, MATRIX_HEIGHT * 8);
 
   }
}
