// 2A: Shared drawing canvas (Server)

import processing.net.*;

Server s; 
Client c;
String input;
int data[];

static final int N = Board.size * Board.spacing;


void setup() { 
  
  
  size(608, 608);
  background(170,140,100);
  frameRate(15); // Slow it down a little
  
  p0 = new Player();
  p1 = new Player();
  
  p0.col = 0; 
  p1.col = 255;
  
  
  s = new Server(this, 12345);  // Start a simple server on a port
  
  board.init();
  image(board.bg, 0, 0, 608, 608);
  
  
  drawGrid(Board.span/2,Board.span/2);
} 

void draw() { 
  if (mousePressed == true) {

    p0.placeStone(mouseX, mouseY);
   
    s.write(mouseX + " " + mouseY + "\n");
  }
  
  // Receive data from client
  c = s.available();
  if (c != null) {
    input = c.readString(); 
    input = input.substring(0, input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array

    p1.placeStone(data[0], data[1]);
  }
}