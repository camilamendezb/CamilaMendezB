class kale3 extends Anim {
//INTERACTION SCENE 

 void loop(PGraphics target) {
  file = new SoundFile (this, "tale.mp3");

  a = random(MATRIX_WIDTH);
  c = random(MATRIX_HEIGHT);
  h = random((MATRIX_WIDTH/2)+10);
  m = random((MATRIX_HEIGHT/2)+10);

  int previewScale = 8;

  led.beginDraw();

  led.background (0);
  led.noStroke();
  led.fill(r, g, b);

  if (mousePressed) {

    file.play();
    file.amp(.9);

    //led.music= new SoundFile (this,"data/

    r=250;
    g= 0;
    b= 55;
    led.fill(random(250), 250, random(250));
    led.rect(mouseX / previewScale, mouseY / previewScale, mouseX, 1);
    led.fill(random(250), 250, 250);
    led.rect(mouseX*0.5 / previewScale, mouseY*0.5 / previewScale, mouseX*0.5, 1);
    led.rect(mouseX*0.5 / previewScale, mouseY*0.5 / previewScale, 0, 1);
    led.fill(30, 144, 255);
    led.ellipse(mouseX/ previewScale, mouseY/ previewScale, 2, 2);
    led.fill(255, 160, 122);
    led.ellipse(mouseX/ previewScale, mouseY/ previewScale, 2, 2);
    led.fill(255, 255, 0);
    led.ellipse(mouseX/2/previewScale, mouseY/ previewScale, 7, 5);
    led.fill(0, 255, 0);
    led.ellipse (mouseX/2/previewScale, mouseY/4/previewScale, 15, 2);
    led.fill(0, 250, random(250));

    if (frameCount%80 ==0) {
      a = random(MATRIX_WIDTH);
      b = random(MATRIX_HEIGHT);
      h = random((MATRIX_WIDTH/2)+10);
      m = random((MATRIX_HEIGHT/2)+10);

      red = 255;
      green = random(255);
      blue = 0;
    }

    led.fill(red, green, blue);
    led.ellipse(a, b, 3, 3);
    led.fill(red, green, blue);

    //MASK
    led.image (mask, 0, 0);
    image(led, 10, 10, MATRIX_WIDTH * 8, MATRIX_HEIGHT * 8);
    led.endDraw();

    // I DONT KNOW IF I'LL USE IT

    image(led, 10, 10, MATRIX_WIDTH * 8, MATRIX_HEIGHT * 8);
  }
}
