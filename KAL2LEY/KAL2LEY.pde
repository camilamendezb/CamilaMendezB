import processing.serial.*;

final int MATRIX_WIDTH  = 32;
final int MATRIX_HEIGHT = 32;
final int NUM_CHANNELS  = 3;

Serial serial;
byte[]buffer;

PGraphics led;

PImage mask;
PImage ps;

float a, b;
float h, m;
float red, green, blue;


void setup() {


  size(400, 300);
  mask = loadImage ("mask.png");
  noSmooth();

  led = createGraphics(MATRIX_WIDTH, MATRIX_HEIGHT);
  led.smooth();

  //printArray(Serial.list());

  try {
    serial = new Serial(this, "COM7");
  }
  catch(Exception e) {
    println("Couldn't open the serial port...");
    println(e);
  }

  buffer = new byte[MATRIX_WIDTH * MATRIX_HEIGHT * NUM_CHANNELS];


  ps = loadImage ("try.png");


  frameRate (30);
}

void draw() {

  led.beginDraw();

  float w = map(sin(frameCount * 0.061), -1, 1, width*0.2, width * 5.0);
  float h = map(sin(frameCount * 0.072), -1, 1, width*0.2, width * 5.0);

  // Render some forms to the canvas


  //MEIN
  float x = map(cos(frameCount * 0.021), -1, 1, 0, 155);
  float y = map(cos(frameCount * 0.032), -1, 1, 0, 155);
  float z = map(cos(frameCount * 0.043), -1, 1, 0, 155);
  float diam = map(sin(frameCount * 0.1), -1, 1, 18, 30);
  float diam2 = map(sin(frameCount * 0.04), -1, 1, 1, 10);



  //SARA'S STUFF
  if (frameCount%100 ==0) {
    a = random(MATRIX_WIDTH);
    b = random(MATRIX_HEIGHT);
    h = random((MATRIX_WIDTH/2)+10);//
    m = random((MATRIX_HEIGHT/2)+10);


    //a = random(MATRIX_WIDTH*2/3);
    // b = random(MATRIX_HEIGHT*2/3);
    red = random(255);
    green = random(255);
    blue = random(255);
  }

  led.fill(red, green, blue);
  led.ellipse(a, b, 1, 1);

  led.fill(red, green, blue);
  led.ellipse(h, m, 3, 1);

  //IMAGEN DIBUJADA
  tint(255, 90);
  led.image(ps, MATRIX_WIDTH/2-w/2, MATRIX_HEIGHT/2-h/2, w/1.5, h/1.5);

  // CIRCLE  DOS DOS
  led.fill(random(250));
  led.ellipse(width, height, diam, diam);

  //TRIANGULO GENERAL
  led.noStroke();
  //  led.fill(255-x, 255-y, 255-z);
  //led.triangle(16, 0, 5, 22, 30, 23);


  // CIRCLE  DOS DOS
  led.fill(255/2-x, 255*2-y, 255/7-z);
  led.ellipse(width, height, diam/4, diam2/4);

  //SECOND TRIANGLE
  led.fill(x*9, y, z);
  led.triangle (8/2, 0, 5/2, 22/2, 30/2, 23/2);

  //THIRD TRIANGLE
  //led.fill(2,y+3,z+3);
  //led.triangle (8, 0, (width/2), (height/2), 10, 5);
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

  //MASCARA Y APAGAR

  led.image (mask, 0, 0);
  led.endDraw();

  image(led, 10, 10, MATRIX_WIDTH * 8, MATRIX_HEIGHT * 8);

  // Write to the serial port (if open)

  if (serial != null) {
    led.loadPixels();
    int idx = 0;
    for (int i=0; i<led.pixels.length; i++) {
      color c = led.pixels[i];
      buffer[idx++] = (byte)(c >> 16 & 0xFF); // r
      buffer[idx++] = (byte)(c >> 8  & 0xFF); // g
      buffer[idx++] = (byte)(c       & 0xFF); // b
    }
    serial.write('*');     // The 'data' command
    serial.write(buffer);  // ...and the pixel values
  }
}
void keyPressed() {
  println("Pressed key: " +key);
  if (key == 's') {
    String file = System.currentTimeMillis() + ".png";
    println("Saving file: " + file);
    led.updatePixels();
    led.save("out/" + file);
  } else if (key == 'r') {
    led.beginDraw();
    led.background(0);
    led.endDraw();
  }
}
