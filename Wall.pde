class Wall
{
  Obstacle begin;
  Obstacle end;
  boolean axis;
  boolean reseter = false;
  int time, time2;
  int fireTimer;
  int waitTime;
  
  Wall()
  {
  }
  
  Wall(Obstacle one, Obstacle two, int t, int t2, int wt)
  {
   begin = one;
   end = two; 
   time = t;
   time2 = t2;
   fireTimer = 0;
   waitTime = wt;
   //vertical
   if(begin.location.x == end.location.x)
   {
     axis = true;
   }
   //horizontal
   if(begin.location.y == end.location.y)
   {
     axis = false;
   }
  }
  
  Wall(Obstacle one, Obstacle two)
  {
    begin = one;
    end = two; 
    time = 1;
    time2 = 100;
    fireTimer = 0;
    waitTime = 0;
    //vertical
    if(begin.location.x == end.location.x)
    {
      axis = true;
    }
    //horizontal
    if(begin.location.y == end.location.y)
    {
      axis = false;
    }
  }
  
  void update()
  {
  }
  
  void draw()
  {
    if(!reseter)
    {
      fill(255,80,80);
      strokeWeight(2);
      stroke(255,0,0);
    }
    else
    {
      fill(0,127,0);
      strokeWeight(2);
      stroke(0,0,0);
    }
    
    fireTimer ++;
    if(fireTimer >= time && fireTimer <= time2)
    {
      //vertical
      if(axis)
      {
        rect(begin.location.x + begin.wid/3,begin.location.y + begin.hei/2,
          end.wid/3,end.location.y - begin.location.y);
      }
      //horizontal
      else
      {
        rect(begin.location.x + begin.wid/2, begin.location.y + begin.hei/3,
          end.location.x - begin.location.x, end.wid/3);
      }
    }
    if(fireTimer >= time2 + waitTime)
    {
      fireTimer = 0;
    }
  }
  
  int checkCollision(Ball b)
  {
    if(fireTimer >= time && fireTimer <= time2)
    {
      //vertical
      if(axis)
      {
        if (!(b.location.x > begin.location.x + end.wid*2/3
        || b.location.x + b.wid < begin.location.x + end.wid/3
        || b.location.y > end.location.y + begin.hei/2
        || b.location.y + b.hei < begin.location.y + begin.hei/2))
        {
          return 1;
        }
      }
      //horizontal
      else
      {
        if (!(b.location.x > end.location.x  + begin.wid/2 + begin.wid/3 
        || b.location.x + b.wid < begin.location.x  + begin.wid/2
        || b.location.y > end.location.y + begin.wid/3
        || b.location.y + b.hei < begin.location.y + begin.wid*2/3))
        {
          return 1;
        }
      }
  }
    return 0;
  }
}
