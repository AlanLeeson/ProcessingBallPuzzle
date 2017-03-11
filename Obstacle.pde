class Obstacle
{
  
  PVector location = new PVector(0,0,0);
  PVector startLoc;
  int wid = 0;
  int hei = 0;
  boolean dirx;
  boolean diry;
  boolean mover;
  boolean direction;
  boolean collideable;
  int start, stop;
  int reseter;
  float speed;
  
  Obstacle()
  {
  }
  
  Obstacle(int x, int y, int w, int h, boolean c)
  {
    location.x = x;
    location.y = y;
    wid = w;
    hei = h;
    mover = false;
    reseter = 0;
    collideable = c;
  }
  
  Obstacle(int x, int y, int w, int h, boolean d, boolean c, int str, int stp, float sp)
  {
    location.x = x;
    location.y = y;
    startLoc = location;
    wid = w;
    hei = h;
    mover = true;
    start = str;
    stop = stp;
    direction = d;
    speed = sp;
    dirx = true;
    diry = true;
    reseter = 0;
    collideable = c;
  }
  
  Obstacle(int x, int y, int w, int h, boolean d, boolean c, int str, int stp, float sp, boolean dir)
  {
    location.x = x;
    location.y = y;
    startLoc = location;
    wid = w;
    hei = h;
    mover = true;
    start = str;
    stop = stp;
    direction = d;
    speed = sp;
    dirx = dir;
    diry = dir;
    reseter = 0;
    collideable = c;
  }
  
  void update()
  {
    if(mover)
    {
      if(direction)
      {
        if(location.x > stop - wid)
        {
          dirx = false;
        }  
        else if(location.x < start)
        {
          dirx = true;
        }
        if(dirx)
        {
          location.x += speed;
        }
        else
        {
          location.x -= speed;
        }
      }
      else
      {
        if(diry)
        {
          location.y += speed;
        }
        else
        {
          location.y -= speed;
        }
        if(location.y > stop - hei)
        {
          diry = false;
        }
        else if(location.y < start)
        {
          diry = true;
        }
      }
    }
  }
  
  void draw()
  {
    if(mover)
    {
      strokeWeight(1);
      stroke(0,50);
      fill(80,200);
      if(direction)
      {
        rect(start,startLoc.y+hei/2-2,stop-start,4);
      }
      else
      {
        rect(startLoc.x+wid/2-2,start,4,stop-start);
      }
    }
    strokeWeight(2);
    fill(80,80,250);
    stroke(0);
    rect(location.x,location.y,wid,hei);
  }
  
   int checkCollision(Ball b)
  {
    reseter ++;
    if(b.location.x < location.x + wid && b.location.x + b.wid > location.x
      && b.location.y < location.y + hei && b.location.y + b.hei > location.y)
    {
      //left
      if(b.location.x < location.x)
      {
        //print("left\n");
        return 1;
      }
      //right
      else if(b.location.x + b.wid> location.x + wid)
      {
        //print("right\n");
        return 2;
      }
      //top
      if(b.location.y - b.hei/2 < location.y)
      {
        //print("top\n");
        return 3;
      }
      //bottom
      else if(b.location.y > location.y + hei/2 )
      {
        //print("down\n");
        return 4;
      }
        
    }
    else
    {
      reseter = 0;
    }
    return 0;
  }
}
