

class Stone
{
  float x;
  float y;
  int col;
  float diameter;
  
  Stone()
  {
    x = 0;
    y = 0;
    col = 0;
    diameter = Board.spacing-2;
  }
  
  Stone(float x_, float y_, int col_)
  {
    x = x_;
    y = y_;
    col = col_;
    diameter = Board.spacing-2;
  }
  
  void draw()
  {
    int shadow = color(32,32,32,32);
    stroke(shadow);
    fill(shadow);
    ellipse(x+2, y+2, diameter, diameter);
    
    stroke(col);
    fill(col);
    ellipse(x, y, diameter, diameter); 
  }
  
  boolean hitTest( float hitx, float hity ) {
    
    float dx = abs(hitx-x);
    float dy = abs(hity-y);
    float d2 = dx*dx+dy*dy;
    return (d2 < (diameter*diameter));
  }
  
}

String stringFromFloats( float x, float y, float z )
{
   String msg = "";
    msg += x + " ";
    msg += y + " ";
    msg += z + "\n";
    return msg;
}

float[] floatsFromString( String input )
{
  float[] data = null;
  input = input.trim();
  data = float(split(input, ' '));  // Split values into an array
  return data;
}
 
  

class Player
{
  int col;
}

class Board
{
  static final int size = 19;
  static final int spacing = 16;
  static final int span = size*spacing;
  
  int widthPx;
  int lastClickMs = -1000; // used to de-bounce clicks
  
  // I wish processing had a linked list.
  // instead we will have a large array of stones
  // (or null)
  Stone[] stones;
  
  PImage bg;
  
  Board()
  {
  }
  
  void init( int _size )
  {
     bg = loadImage("../data/bamboo2.jpg"); 
      widthPx = _size;
     int N = 4*Board.size*Board.size; // room for 4x the board size of stones
     stones = new Stone[N]; // array of N stone references (which are initially all null)
  }
  
  // adds a stone at the xy position
  void addStone( float x, float y, int col ) {
    
    // find an invisible stone
    for( int i = 0; i < stones.length; i++ ) {
      
      // keep looking if this stone is already visible
      if(stones[i] != null)
        continue;
        
      stones[i] = new Stone();
      stones[i].x = x;
      stones[i].y = y;
      stones[i].col = col;
      stones[i].draw();
      break;
    } 
  }
  
  void handleClick( float x, float y, int col )
  {
    boolean removed = maybeRemoveStone(x,y);
    
    if(!removed)
    {
      addStone(x,y,col); 
    }
  }
  
  // tries to remove a stone at the xy position.
  // returns true if a stone was there and got removed.
  // otherwise returns false
  boolean maybeRemoveStone( float x, float y ) {
    
    boolean wasRemoved = false;
    
    // iterate backwards, since that reflects the z
    // order of the stones
    for( int i = stones.length-1; i >= 0; --i ) {
    
      // we can only remove visible stones
      if(stones[i]==null)
        continue;
        
      // if it is the one the user clicked on, remove it
      if(stones[i].hitTest(x,y))
      {
        stones[i] = null;
        wasRemoved = true;
        break;
      }
    }
    
    return wasRemoved;
  }
  
  
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
  
  void draw()
  {
    image(board.bg, 0, 0, widthPx, widthPx);
    drawGrid(Board.span/2,Board.span/2);
    
    for( Stone stone : stones )
    {
       if(stone != null)
         stone.draw();
    }
    
  }
  
  void handleClientData(Client client) {
    
    if( client==null || client.available()<1 )
      return;
      
    String alldata = client.readString();
    String[] strings = split(alldata, '\n');
    
    for( String input : strings )
    {
      input = input.trim();
      if(input.length() > 0)
      {
        float[] data = floatsFromString(input);
        if( data != null && data.length>2 ) {
          handleClick( data[0], data[1], int(data[2]) );
        }
      }
    }
  }
  
}



Board board = new Board();

Player p0 = new Player();
Player p1 = new Player();