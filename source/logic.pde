

class Player
{
  int col;
  
  void placeStone(float x, float y)
  {
    for(int r = -2; r <= 2; r++) {
      for( int c = -2; c <= 2; c++) {
          drawStone(x+c*Board.span,y+r*Board.span,col);
      }
    }
  }
  
}

class Board
{
  static final int size = 19;
  static final int spacing = 16;
  static final int span = size*spacing;
  
  PImage bg;
  
  Board()
  {
  }
  
  void init()
  {
     bg = loadImage("../data/bamboo2.jpg"); 
  }
}

Board board = new Board();



Player p0;
Player p1;


void drawGrid(float x, float y)
{
   stroke(0,0,0,64);
   int span = (Board.size-1)*(Board.spacing);
   
   // draw rows
   for(int r = 0; r < Board.size; r++) {
     float yr = y+r*Board.spacing;
     line(x,yr,x+span,yr);
   }
   
   // draw columns
   for(int c = 0; c < Board.size; c++) {
     float xc = x+c*Board.spacing;
     line(xc,y,xc,y+span);
   }
}

void drawStone(float x, float y, int col)
{
  int diameter = Board.spacing-2;
    int shadow = color(32,32,32,32);
    stroke(shadow);
    fill(shadow);
    ellipse(x+2, y+2, diameter, diameter);
    
    stroke(col);
    fill(col);
    ellipse(x, y, diameter, diameter);
  
}