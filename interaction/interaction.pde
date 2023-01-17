/*/**
 * This sketch sends all the pixels of the canvas to the serial port.
 * A helper function to scan all the serial ports for a configured controller is provided.
 */


import processing.serial.*;
import processing.sound.*;


SoundFile file;

final int MATRIX_WIDTH  = 32;
final int MATRIX_HEIGHT = 32;
final int NUM_CHANNELS  = 3;

Serial serial;
byte[]buffer;

int size = 1;


PImage mask;
PGraphics led;


//float music;
float a, c;
float h, m;
float red, green, blue;

float r= 250;
float g= 250;
float b= 250;

void setup() {


  //music

  file = new SoundFile (this, "tale.mp3");



  size(400, 300);
  mask = loadImage ("mask.png");
  noSmooth();

  led = createGraphics(MATRIX_WIDTH, MATRIX_HEIGHT);
  led.smooth();

  led.beginDraw();
  led.background(0);
  led.endDraw();

  printArray(Serial.list());

  try {
    serial = new Serial(this, "COM7");
  }
  catch(Exception e) {
    println("Couldn't open the serial port...");
    println(e);
  }

  buffer = new byte[MATRIX_WIDTH * MATRIX_HEIGHT * NUM_CHANNELS];
}

void draw() {



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

    //MASCARA Y APAGAR

    led.image (mask, 0, 0);
    image(led, 10, 10, MATRIX_WIDTH * 8, MATRIX_HEIGHT * 8);
  }
  led.endDraw();


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
  if (keyCode == ALT) {
    r = 0;
    g= 0;
    b = 255;
  }
  if (keyCode == DOWN) {
    r = 0;
    g= 128;
    b = 0;
  }
  if (keyCode == RIGHT) {
    r = 255;
    g= 0;
    b = 0;
  }
  if (keyCode == UP) {
    r = 255;
    g= 255;
    b = 0;
  }
  if (key == LEFT) {
    r = 0;
    g= 255;
    b = 0;
  }
}
