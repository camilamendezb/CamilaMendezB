/**
 * This sketch sends all the pixels of the canvas to the serial port.
 * A helper function to scan all the serial ports for a configured controller is provided.
 */


import processing.serial.*;

final int MATRIX_WIDTH  = 32;
final int MATRIX_HEIGHT = 32;
final int NUM_CHANNELS  = 3;

Serial serial;
byte[]buffer;

int size = 1;


PImage mask;
PGraphics led;

float r= 250;
float g= 250;
float b= 250;

void setup() {
  
  size(400, 300);
  mask = loadImage ("mask.png");
  noSmooth();
 
  led = createGraphics(MATRIX_WIDTH, MATRIX_HEIGHT);
  led.smooth();

  led.beginDraw();
//  led.background(0);
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


  int previewScale = 8;

  led.beginDraw();
  led.noStroke();
  led.fill(r, g, b);
  if (mousePressed) {
    led.rect(mouseX / previewScale, mouseY / previewScale, size, size);
    
     //MASCARA Y APAGAR

  led.image (mask,0,0);
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
   g= 129;
    b = 0;
  } if (keyCode == RIGHT){
 r = 255;
   g= 0;
    b = 0;
  }
    if (keyCode == UP){
 r = 255;
   g= 255;
    b = 0;
  }
 if (key == LEFT){
 r = 0;
 g= 255;
  b = 0;
  }
}
