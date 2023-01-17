
import processing.serial.*;
import processing.sound.*;

SoundFile file;

final int MATRIX_WIDTH  = 32;
final int MATRIX_HEIGHT = 32;
final int NUM_CHANNELS  = 3;

Serial serial;
byte[]buffer;

PGraphics led;
int size = 1;


Anim anim1, anim2;

PImage mask;
float a, b, c;
float h, m;
float red, green, blue;


void setup() {


  size(400, 300);
  mask = loadImage ("mask.png");
  noSmooth();

  //T1 START?

  t1 = createGraphics(MATRIX_WIDTH, MATRIX_HEIGHT);
  t2 = createGraphics(MATRIX_WIDTH, MATRIX_HEIGHT);

  led = createGraphics(MATRIX_WIDTH, MATRIX_HEIGHT);
  led.smooth();


  //

  //printArray(Serial.list());

  try {
    serial = new Serial(this, "COM7");
  }
  catch(Exception e) {
    println("Couldn't open the serial port...");
    println(e);
  }

  buffer = new byte[MATRIX_WIDTH * MATRIX_HEIGHT * NUM_CHANNELS];

  // Canales o lo que sea
  anim1 = new kale1();
  anim2 = new kale2();
  anim3=  new kale3();
  anim4 = new kale4();
  anim5= new kale5();
}

void draw() {


  t1.beginDraw();
  anim1.loop(t1);
  t1.endDraw();


  t2.beginDraw();
  anim2.loop(t2);
  t2.endDraw();

  //INICIO DE ANIMACIÓN
  led.beginDraw();
  led.noTint ();
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
  if (key == 's') 
    String file = System.currentTimeMillis() + ".png";
    println("Saving file: " + file);
    led.updatePixels();
    led.save("out/" + file);
     else if (key == '1') anim1 = new kale1();
  else if (key == '2') anim1 = new kale2();
  else if (key == '3') anim2 = new kale3();
  else if (key == '4') anim2 = new kale4();
  else if (key == '4') anim2 = new kale5();
  else if (key == 'r') 
    led.beginDraw();
    led.background(0);
    led.endDraw();
  }
}
