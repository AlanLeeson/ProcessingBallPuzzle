class ResetWall extends Wall
{
  
  ResetWall(Obstacle one, Obstacle two,int t, int t2, int wt)
  {
    super(one,two,t,t2,wt);
    reseter = true;
  }
  
  ResetWall(Obstacle one, Obstacle two)
  {
    super(one,two);
    reseter = true;
  }
  
  void draw()
  {
    super.draw();
  }
  
  int checkCollision(Ball b)
  {
    int check = super.checkCollision(b);
    
    if(check == 1)
    {
      return 2;
    }
    
    return 0;
  }
  
  
  
}
