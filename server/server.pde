// 2A: Shared drawing canvas (Server)

import processing.net.*;

Server server; 

void setup() { 
  size(608, 608);
  server = new Server(this, 12345);  // Start the server
  frameRate(15);
  
  board.init(608);
  p0.col = 0; 
  p1.col = 255;
} 

void mouseClicked() {
  
  board.handleClick(mouseX,mouseY,p0);
  server.write(mouseX + " " + mouseY + "\n");
  
}

int[] getRemoteData() {
  
  int[] data = null;
  
  // Receive data from client
  Client client = server.available();
  
  if (client != null) {
    String input = client.readString();
    if(input.indexOf("\n") >= 0)
    {
      input = input.substring(0,input.indexOf("\n"));  // Only up to the newline
      data = int(split(input, ' '));  // Split values into an array
    }
  }
  
  return data;
}

void draw() { 
    
  int[] data = getRemoteData();
  
  if(data != null) {
    board.handleClick(data[0], data[1],p1);
  }
  
  board.draw();
}