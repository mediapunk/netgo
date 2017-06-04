import processing.net.*;

Server server; 
String clientip = "";

void setup() { 
  size(608, 608);
  
  server = new Server(this, 12345);  // Start the server
  
  frameRate(15);
  
  board.init(608);
  p0.col = 0; 
  p1.col = 255;
} 

void mouseClicked() {
  
  board.handleClick(mouseX,mouseY,p0.col);
  String msg = stringFromFloats(mouseX,mouseY,p0.col);
  println(msg);
  server.write( msg );
}

void serverEvent(Server server, Client someClient) {
  
  println("sending board state to " + someClient.ip());
  
  clientip = someClient.ip();
  
  // transmit game state:
  for( Stone stone : board.stones )
  {
    if(stone != null)
    {
       String msg = stringFromFloats( stone.x, stone.y, stone.col );
       println(msg.trim());
       server.write( msg );
    }
  } 
}

void handleRemoteData() {
  Client client = server.available();
  board.handleClientData(client);  
}

void draw() { 
  handleRemoteData();
  board.draw();
  
  textSize(20);
  fill(0, 102, 153, 51);
  text("client: " + clientip, 20, 30);
}