import processing.net.*; 

Client c; 
String input;
int data[]; 



void setup() { 
  size(608, 608);
  background(170,140,100);
  frameRate(15); // Slow it down a little
  
  p0 = new Player();
  p1 = new Player();
  
  p0.col = 255; 
  p1.col = 0;
  
  // Connect to the server’s IP address and port­
  c = new Client(this, "127.0.0.1", 12345); // Replace with your server’s IP and port
  
  board.init();
  image(board.bg, 0, 0, 608, 608);
  drawGrid(Board.span/2,Board.span/2);
} 

void draw() {         
  if (mousePressed == true) {
    
     p0.placeStone(mouseX, mouseY);
    
    c.write(mouseX + " " + mouseY + "\n");
  }

  // Receive data from server
  if (c.available() > 0) { 
    input = c.readString(); 
    input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
    data = int(split(input, ' '));  // Split values into an array
    
    p1.placeStone(data[0], data[1]);
  } 
}