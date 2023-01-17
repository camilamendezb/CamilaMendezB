class kale2 extends Anim {

 void loop(PGraphics target) {
   
   
  // RAINBOW
    PImage[] sprite;
  ps = loadImage ("try.png");
    frameRate (30);


  // VARIABLES DIBUJO

  float w = map(sin(frameCount * 0.061), -1, 1, width*0.2, width * 5.0);
  float h = map(sin(frameCount * 0.072), -1, 1, width*0.2, width * 5.0);

  // DRAWS AND LINES

  float x = map(cos(frameCount * 0.021), -1, 1, 0, 155);
  float y = map(cos(frameCount * 0.032), -1, 1, 0, 155);
  float z = map(cos(frameCount * 0.043), -1, 1, 0, 155);
  float diam = map(sin(frameCount * 0.1), -1, 1, 18, 30);
  float diam2 = map(sin(frameCount * 0.04), -1, 1, 1, 10);

  // RANDOM CIRCLES

  //SARA'S STUFF
  if (frameCount%100 ==0) {
    a = random(MATRIX_WIDTH);
    b = random(MATRIX_HEIGHT);
    h = random((MATRIX_WIDTH/2)+10);//
    m = random((MATRIX_HEIGHT/2)+10);
//Colores creo 
    red = random(255);
    green = random(255);
    blue = random(255);
    
 // OTHER FORMS
  led.fill(red, green, blue);
  led.ellipse(a, b, 1, 1);

  led.fill(red, green, blue);
  led.ellipse(h, m, 3, 1);

  // IMAGE
  tint(255, 90);
  led.image(ps, MATRIX_WIDTH/2-w/2, MATRIX_HEIGHT/2-h/2, w/1.5, h/1.5);

  // CIRCLE 
  led.fill(random(250));
  led.ellipse(width, height, diam, diam);

  //TRIANGLE
  led.noStroke();
  //  led.fill(255-x, 255-y, 255-z);
  //led.triangle(16, 0, 5, 22, 30, 23);


  // OTHER CIRCLE 
  led.fill(255/2-x, 255*2-y, 255/7-z);
  led.ellipse(width, height, diam/4, diam2/4);

  //SECOND TRIANGLE
  led.fill(x*9, y, z);
  led.triangle (8/2, 0, 5/2, 22/2, 30/2, 23/2);

  //OTHER CIRCLES
  led.fill(z, y, x);
  led.circle (29, 22, diam/4);
  led.fill(34, 96, 255);
  led.circle (5, 22, diam/4);
  led.fill(random(255));
  led.fill(2, y+3, z+3+4);

  //LINEAS HORIZONTALES
  led.rect (0, 13, 16, 1);
  led.rect (16, 13, 16, 1);
  led.fill(255-x, 100+y, 100*2);
  led.rect (10, 0, 0.5, 30);
  led.fill(89-x, 100+y, 100*2);
  led.rect (13, 0, 0.5, 30);
  led.fill(0, 0, 0);
  led.rect (16, 0, 0.5, 30);
  led.fill(0, 0, 0);
  led.rect (19, 0, 0.5, 30);
  led.fill(0, 0, 0);
  led.rect (22, 0, 0.5, 30);
  led.fill(0, 0, 0);
  led.rect (26, 0, 0.5, 30);

//MASK
  led.image (mask, 0, 0);
  led.endDraw();

  // I DONT KNOW IF I'LL USE IT

  image(led, 10, 10, MATRIX_WIDTH * 8, MATRIX_HEIGHT * 8);
}
}
