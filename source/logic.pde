

class Player
{
  int col;
  
  void placeStone(float x, float y)
  {
    int diameter = 20;
    int shadow = color(32,32,32,32);
    stroke(shadow);
    fill(shadow);
    ellipse(x+2, y+2, diameter, diameter);
    
    stroke(col);
    fill(col);
    ellipse(x, y, diameter, diameter);
  }
}

Player p0;
Player p1;