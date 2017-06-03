import processing.net.*; 

Client client;

void setup() { 
  size(608, 608);

  // Connect to the server’s IP address and port­
  client = new Client(this, "127.0.0.1", 12345); // Replace with your server’s IP and port
  
  frameRate(15);
  
  board.init(608);
  p0.col = 255; 
  p1.col = 0;
} 

void mouseClicked() {
  
  board.handleClick(mouseX,mouseY,p0);
  client.write(mouseX + " " + mouseY + "\n");
  
}

int[] getRemoteData() {
  
  int[] data = null;
  
  // Receive data from server
  if (client.available() > 0) { 
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