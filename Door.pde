class Door extends Obstacle
{
  
  PVector col;
  
  Door(int x, int y, int w, int h, PVector c)
  {
    location = new PVector(x,y);
    wid = w;
    hei = h;
    col = c;
    collideable = true;
  }
  
  void display()
  {
    strokeWeight(2);
    fill(col.x,col.y,col.z);
    stroke(0);
    rect(location.x,location.y,wid,hei);
  }
  
}
