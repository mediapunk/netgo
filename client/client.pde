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
  
  board.handleClick(mouseX,mouseY,p0.col);
  String msg = stringFromFloats(mouseX,mouseY,p0.col);
  println(msg);
  client.write(msg);
  
}

  
void clientEvent(Client client) {
  //println("clientEvent: " + client.available() + " bytes available");
}

void handleRemoteData() {
  board.handleClientData(client);  
}

void draw() {         
  handleRemoteData();
  board.draw();
  
  textSize(20);
  fill(0, 102, 153, 51);
  text("host: " + client.ip(), 20, 30);
}