
 final int PLAYING = 0;
 final int MAIN_MENU = 1;
 final int PAUSE = 2;
 final int TEST = 3;

 //for game
 Ball b;
 ArrayList<Obstacle> obs;
 ArrayList<Wall> walls;
 ArrayList<Dialogue> logs;
 ArrayList<Kid> kids;
 int levelLoad;
 int logNum = 0;
 PVector dir;
 boolean w,a,s,d;
 boolean collided;
 boolean showDialogue;
 int kidsInLevel = 0;
 
 //for menu
 boolean overBox = false;
 float xOffset = 0.0;
 float yOffset = 0.0;
 
 //for test
 Level level;

 int gameState;
 
 void setup()
 {
   size(1000, 600);
   gameState = MAIN_MENU;
   obs = new ArrayList<Obstacle>();
   walls = new ArrayList<Wall>();
   logs = new ArrayList<Dialogue>();
   kids = new ArrayList<Kid>();
   
   b = new Ball(width/4-25,height/2-25,25,25);
   dir = new PVector(0,-1.5f,0);
   levelLoad = 0;
   w = false;
   a = false;
   s = false;
   d = false;
   
   smooth();
   ellipseMode(CORNER);
   background(255);
 }
 
 void draw()
 {
   switch(gameState)
   {
     
     case(PLAYING):
      background(255);
      b.update();
      b.draw();
      
      if(b.nextLevel)
      {
        for(int i = 0; i < kids.size(); i ++)
        {
          Kid kid = kids.get(i);
          kid.location.x = 0;
        }
        removePrev();
        levelLoad ++;
        loadLevel(levelLoad);
        b.nextLevel = false;
      }
      
     for(int i = 0; i < walls.size(); i++)
       {
        Wall wall = walls.get(i);
        int check = wall.checkCollision(b);
        if(check == 1 )
        {
          b.die();
          for(int j = 0; j < kids.size(); j++)
          {
            Kid kid = kids.get(j);
            if(kid.follow)
            {
              kid.location = b.location.get();
            }
          }
        }
        else if(check == 2)
        {
          b.die();
          for(int k = 0; k < kidsInLevel; k++) 
          {
            kids.remove(kids.size()-1);
          }
          removePrev();
          loadLevel(levelLoad);
        }
        wall.draw();
      }
      
      collided = false;       
      
      for(int i = 0; i < obs.size(); i++)
      {
        Obstacle ob = obs.get(i);
        if(ob.collideable)
        {
          collisionChecker(ob.checkCollision(b),ob);
        }
        ob.update();
        ob.draw();
      }
     
      for(int i = 0; i < kids.size(); i++)
      {
        Kid kid = kids.get(i);
        if(!kid.follow)
        {
          kid.collision(b);
          collisionChecker(kid.door.checkCollision(b),kid.door);
        }
        else
        {
          if(i == 0)
          {
            PVector loc = new PVector(b.center.x-10,b.center.y-10);
            kid.arrive(loc);
          }
          else
          {
            Kid k = kids.get(i-1);
            PVector loc = new PVector(k.location.x-2,k.location.y);
            kid.arrive(loc);
          }
        }
        kid.draw();
      }
      
      if(showDialogue)
      {
        b.reset();
        Dialogue log = logs.get(logNum);
        log.draw();
      }
      
      break;
      
      case(MAIN_MENU):
      mainMenu();
      break;
   } 
 }
 
 void loadLevel(int i)
 {
   switch(i)
   {
     case 0:
     prolog();
     break;
     case 1:
     intro();
     break;
     case 2:
     levelOne();
     break;
     case 3:
     levelTwo();
     break;
     case 4:
     levelThree();
     break;
     case 5:
     levelFour();
     break;
     case 6:
     levelFive();
     break;
     case 7:
     levelSix();
     break;
     case 8:
     levelSeven();
     break;
     case 9:
     levelEight();
     break;
     case 10:
     levelNine();
     break;
     case 11:
     levelTen();
     break;
     case 12:
     levelEleven();
     break;
     case 13:
     levelTwelve();
     break;
     default:
     gameState = MAIN_MENU;
     kids = new ArrayList<Kid>();
     b.location.x = width/4-25;
     b.location.y = height/2-25;
     b.reset();
   }
 }
 
 void prolog()
 {
   Dialogue d = new Dialogue(width/4-110,height/2-120,new PVector(0,0,0),"Use 'W', 'A', 'S', 'D' To Move.");
   Dialogue d1 = new Dialogue(width/4-110,height/2-120,new PVector(0,0,0),"Get To The Far Right To Advance.");
   logs.add(d);
   logs.add(d1);
   showDialogue = true;
   
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   Obstacle left = new Obstacle(0,0,25,height,true);
   obs.add(bottom);
   obs.add(top);
   obs.add(left);
   
   Obstacle ob = new Obstacle(width-26,height/4,25,height-height/4-2,true);
   Obstacle ob2 = new Obstacle(width/2,0,25,height*3/4,true);
   obs.add(ob);
   obs.add(ob2);
 }
 
 void intro()
 {
   Dialogue d = new Dialogue(width/2+5,height-280,new PVector(0,0,0),"Collect Me To Remove The Wall.");
   Dialogue d1 = new Dialogue(width/2+5,height-280,new PVector(0,0,0),"I Remove The Wall That Corresponds");
   Dialogue d2 = new Dialogue(width/2+5,height-280,new PVector(0,255,200),"To My Color.");
   showDialogue = true;
   logs.add(d);
   logs.add(d1);
   logs.add(d2);
   
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   Obstacle left = new Obstacle(0,height/4,25,height-height/4,true);
   obs.add(bottom);
   obs.add(top);
   obs.add(left);
   
   Obstacle ob = new Obstacle(0,height/4,200,25,true);
   obs.add(ob);
   
   Door door = new Door(width-20,25,20,height-50,new PVector(0,255,200));
   
   Kid tKid = new Kid(width/2-5,height-200,new PVector(0,255,200),10,door);
   kids.add(tKid);
   
   kidsInLevel = 1;
 }
 
 void levelOne()
 {
   Dialogue d = new Dialogue(width/2-100,height/2-50,new PVector(0,0,0),"See Those Red Lasers?");
   Dialogue d2 = new Dialogue(width/2-100,height/2-50,new PVector(0,0,0),"Try Your Best To Avoid Them.");
   showDialogue = true;
   logs.add(d);
   logs.add(d2);
   
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle ob = new Obstacle(width*3/4,0,25,25,false);
   Obstacle ob2 = new Obstacle(width*3/4,100,25,25,true);
   Obstacle ob3 = new Obstacle(width*3/4,height-120,25,25,true);
   Obstacle ob4 = new Obstacle(width*3/4,height-25,25,25,false);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   
   Wall w = new Wall(ob,ob2,100,150,0);
   Wall w2 = new Wall(ob2,ob3,50,100,0);
   Wall w3 = new Wall(ob3,ob4,100,150,0);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
 }
 
 void levelTwo()
 {
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle ob = new Obstacle(width/5,0,25,25,false);
   Obstacle ob2 = new Obstacle(width/5,height-25,25,25,false);
   Obstacle ob3 = new Obstacle(width/2,0,25,25,false);
   Obstacle ob4 = new Obstacle(width/2,height-25,25,25,false);
   Obstacle ob5 = new Obstacle(width*4/5,0,25,25,false);
   Obstacle ob6 = new Obstacle(width*4/5,height-25,25,25,false);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);
   
   Wall w = new Wall(ob,ob2,75,100,0);
   Wall w2 = new Wall(ob3,ob4,75,100,0);
   Wall w3 = new Wall(ob5,ob6,75,100,0);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
   
 }
 
 void levelThree()
 {
   Door door = new Door(width-20,25,20,height-50,new PVector(80,120,255));
   
   Kid kid = new Kid(width/4+100,80,new PVector(80,120,255),10,door);
   kids.add(kid);
   
   kidsInLevel = 1;
   
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   Obstacle middle = new Obstacle(width/8,150,width-width/4,height-300,true);
   obs.add(bottom);
   obs.add(top);
   obs.add(middle);
   
   Obstacle ob = new Obstacle(width/4,0,25,25,false);
   Obstacle ob2 = new Obstacle(width/4,150,25,25,false);
   Obstacle ob3 = new Obstacle(width/4-30,height-175,60,25,false);
   Obstacle ob4 = new Obstacle(width/4-30,height-25,60,25,false);
   Obstacle ob5 = new Obstacle(width*3/4-30,height-175,60,25,false);
   Obstacle ob6 = new Obstacle(width*3/4-30,height-25,60,25,false);
   Obstacle ob7 = new Obstacle(width/2-30,height-175,60,25,false);
   Obstacle ob8 = new Obstacle(width/2-30,height-25,60,25,false);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);
   obs.add(ob7);
   obs.add(ob8);
   
   Wall w = new Wall(ob,ob2);
   Wall w2 = new Wall(ob3,ob4,20,50,40);
   Wall w3 = new Wall(ob5,ob6,40,70,20);
   Wall w4 = new Wall(ob7,ob8,30,60,30);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
   walls.add(w4);
   
 }
 
 void levelFour()
 {
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle ob = new Obstacle(0,height/2,200,height/2,true);
   Obstacle ob2 = new Obstacle(width/2-100,0,200,height/2+25,true);
   Obstacle ob3 = new Obstacle(width-200,height/2,200,height/2,true);
   Obstacle ob4 = new Obstacle(180,height/2,20,25,false);
   Obstacle ob5 = new Obstacle(width/2-100,height/2,20,25,false);
   Obstacle ob6 = new Obstacle(width/2+80,height/2,20,25,false);
   Obstacle ob7 = new Obstacle(width-200,height/2,20,25,false);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);
   obs.add(ob7);
   
   Wall w = new Wall(ob4,ob5,50,100,0);
   Wall w2 = new Wall(ob6,ob7,50,100,0);
   walls.add(w);
   walls.add(w2);
 }
 
 void levelFive()
 {
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle oby = new Obstacle(width/2,25,width/2,height/8,true);
   Obstacle oby2 = new Obstacle(width/2,height-height/8-25,width/2,75,true);
   Obstacle oby3 = new Obstacle(width*3/4,height/4-height/8+25,width/4,75,true);
   Obstacle oby4 = new Obstacle(width*3/4,height-height/4-25,width/4,75,true);
   Obstacle oby5 = new Obstacle(width-25,height/2,25,125,true);
   Obstacle oby6 = new Obstacle(50,height/2-30,50,25,true);
   obs.add(oby);
   obs.add(oby2);
   obs.add(oby3);
   obs.add(oby4);
   obs.add(oby5);
   obs.add(oby6);
   
   Obstacle ob = new Obstacle(width/4,0,25,25,false);
   Obstacle ob2 = new Obstacle(width/4,height-25,25,25,false);
   Obstacle ob3 = new Obstacle(width/2,height/8,25,25,false);
   Obstacle ob4 = new Obstacle(width/2,height-height/8-25,25,25,false);
   Obstacle ob5 = new Obstacle(width*3/4,height/4,25,25,false);
   Obstacle ob6 = new Obstacle(width*3/4,height-height/4-25,25,25,false);
   Obstacle ob7 = new Obstacle(width-25,height/2-125,25,25,false);
   Obstacle ob8 = new Obstacle(width-25,height/2,25,25,false);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);
   obs.add(ob7);
   obs.add(ob8);
   
   Wall w = new Wall(ob,ob2,50,150,0);
   Wall w2 = new Wall(ob3,ob4,80,150,0);
   Wall w3 = new Wall(ob5,ob6,105,150,0);
   Wall w4 = new Wall(ob7,ob8,135,150,0);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
   walls.add(w4);
 }
 
 void levelSix()
 {
   Obstacle right = new Obstacle(width-75,height/4,75,height,true);
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(right);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle oby = new Obstacle(width/4-25,25,width/4-20,height/4-50,true);
   Obstacle oby2 = new Obstacle(width/4+height/4+25,25,width/4-50,width/2-50,true);
   Obstacle oby3 = new Obstacle(0,height/2-25,width/4,25,true);
   Obstacle oby4 = new Obstacle(width/4,height*3/4,width/4-55,25,true);
   obs.add(oby);
   obs.add(oby4);
   obs.add(oby2);
   obs.add(oby3);
   
   Obstacle move = new Obstacle(width*3/4-75,height/2+100,75,25,true,true,width*3/4-125,width-75,2.0f);
   Obstacle move2 = new Obstacle(width*3/4,height/2,75,25,true,true,width*3/4-125,width-75,2.0f);
   Obstacle move3 = new Obstacle(width*3/4+75,height/2-100,75,25,true,true,width*3/4-125,width-75,2.0f);
   obs.add(move);
   obs.add(move2);
   obs.add(move3);
   
   Obstacle ob = new Obstacle(width/4-25,height/2-25,25,25,false);
   Obstacle ob2 = new Obstacle(width/4-25,height/4-50,25,25,false);
   Obstacle ob3 = new Obstacle(width/4-25,height*3/4,25,25,false);
   Obstacle ob4 = new Obstacle(width/2-75,height/2-25,25,25,false);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   
   Wall w = new Wall(ob2,ob,100,150,0);
   Wall w2 = new Wall(ob,ob3,100,150,0);
   Wall w3 = new Wall(ob,ob4,50,100,0); 
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
 }
 
 void levelSeven()
 {
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle mover = new Obstacle(50,0,25,25,true,false,50,width,1.5f);
   Obstacle mover2 = new Obstacle(50,height-25,25,25,true,false,50,width,1.5f);
   Obstacle mover3 = new Obstacle(width-25,0,25,25,true,false,50,width,1.5f);
   Obstacle mover4 = new Obstacle(width-25,height-25,25,25,true,false,50,width,1.5f);
   obs.add(mover);
   obs.add(mover2);
   obs.add(mover3);
   obs.add(mover4);
   
   Obstacle mov = new Obstacle(width/5,25,10,150,false,true,25,height-25,1.7f);
   Obstacle mov2 = new Obstacle(width*2/5,height/2-75,10,150,false,true,25,height-25,1.7f);
   Obstacle mov3 = new Obstacle(width*3/5,height-175,10,150,false,true,25,height-25,1.7f);
   Obstacle mov4 = new Obstacle(width*4/5,height/2-75,10,150,false,true,25,height-25,1.7f,false);
   obs.add(mov);
   obs.add(mov2);
   obs.add(mov3);
   obs.add(mov4);
   
   Wall w = new Wall(mover,mover2,110,150,10);
   Wall w2 = new Wall(mover3,mover4,110,150,10);
   walls.add(w);
   walls.add(w2);
 }
 
 void levelEight()
 {
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle ob = new Obstacle(width/5,height/2-100,15,15,true);
   Obstacle ob2 = new Obstacle(width*3/5,height/2-100,15,15,true);
   Obstacle ob3 = new Obstacle(width/5,height/2+100,15,15,true);
   Obstacle ob4 = new Obstacle(width*3/5,height/2+100,15,15,true);
   Obstacle ob5 = new Obstacle(width/5,25,15,15,true);
   Obstacle ob6 = new Obstacle(width/5,height-40,15,15,true);
   Obstacle ob7 = new Obstacle(width-200,height/2-100,15,15,true);
   Obstacle ob8 = new Obstacle(width-200,height/2+100,15,15,true);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);
   obs.add(ob7);
   obs.add(ob8);
   
   Wall w = new Wall(ob,ob2);
   Wall w2 = new Wall(ob3,ob4);
   Wall w3 = new Wall(ob5,ob);
   Wall w4 = new Wall(ob3,ob6);
   Wall w5 = new Wall(ob7,ob8);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
   walls.add(w4);
   walls.add(w5);
 }
 
 void levelNine()
 {
   
   Door door2 = new Door(width/4+130,height*3/5-2,235,19,new PVector(20,100,20));
   Kid kid2 = new Kid(width-150,125,new PVector(20,100,20),10,door2);
   kids.add(kid2);
   
   Door door = new Door(width-25,height*3/5+15,25,height-height*3/5-40,new PVector(80,200,20));
   Kid kid = new Kid(width/2,125,new PVector(80,200,20),10,door);
   kids.add(kid);
   
   kidsInLevel = 2;
   
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   Obstacle right = new Obstacle(width-25,25,25,height*3/5-10,true);
   obs.add(bottom);
   obs.add(top);
   obs.add(right);
   
   Obstacle oby = new Obstacle(width/4+65,height*3/5,100,15,true);
   Obstacle oby2 = new Obstacle(width/2+100,height*3/5,100,15,true);
   Obstacle oby3 = new Obstacle(width/4+65,25,15,height*3/5-25,true);
   Obstacle oby4 = new Obstacle(width/2+185,25,15,height*3/5-25,true);
   obs.add(oby);
   obs.add(oby2);
   obs.add(oby3);
   obs.add(oby4);
   
   
   Obstacle ob = new Obstacle(width/2-100,25,15,15,true);
   Obstacle ob2 = new Obstacle(width/2-100,width/5,15,15,true);
   Obstacle ob3 = new Obstacle(width/2+100,25,15,15,true);
   Obstacle ob4 = new Obstacle(width/2+100,width/5,15,15,true);
   Obstacle ob5 = new Obstacle(width/4+150,height*3/5,15,15,false);
   Obstacle ob6 = new Obstacle(width/2+100,height*3/5,15,15,false);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);

   Obstacle mov = new Obstacle(width/4+65,height-25,15,15,false,true,height*3/5+15,height-25,1.0f,false);
   Obstacle mov2 = new Obstacle(width/2,height-25,15,15,false,true,height*3/5+15,height-25,1.0f,false);
   Obstacle mov3 = new Obstacle(width/2,height*3/5+15,15,15,false,true,height*3/5+15,height-25,1.0f);
   Obstacle mov4 = new Obstacle(width/2+185,height*3/5+15,15,15,false,true,height*3/5+15,height-25,1.0f);
   obs.add(mov);
   obs.add(mov2);
   obs.add(mov3);
   obs.add(mov4);
   
   Wall w = new Wall(ob,ob2);
   Wall w2 = new Wall(ob3,ob4);
   Wall w3 = new Wall(ob5,ob6,0,50,50);
   Wall mw = new Wall(mov,mov2);
   Wall mw2 = new Wall(mov3,mov4);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
   walls.add(mw);
   walls.add(mw2);
   
 }
 
 void levelTen()
 {
   
   Door door = new Door(width-25,height*3/4+15,25,height/4-40,new PVector(220,220,0));
   
   Kid kid = new Kid(width*3/4+32,height/2-10,new PVector(220,220,0),10,door);
   kids.add(kid);
   
   kidsInLevel = 1;
   
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle oby = new Obstacle(width-25,25,25,height*3/4-10,true);
   obs.add(oby);
   
   Obstacle ob = new Obstacle(width/4,10,15,15,false);
   Obstacle ob2 = new Obstacle(width/4,height*3/4,15,15,true);
   Obstacle ob3 = new Obstacle(width/2-100,height*3/4,15,15,true);
   Obstacle ob4 = new Obstacle(width/2+100,height*3/4,15,15,true);
   Obstacle ob5 = new Obstacle(width/2+100,height-25,15,15,false);
   Obstacle ob6 = new Obstacle(width/2-100,height/5,15,15,true);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);
   
   Obstacle mov = new Obstacle(width/2+100,120,15,15,false,true,120,285,1.0f);
   Obstacle mov2 = new Obstacle(width-40,120,15,15,false,true,120,285,1.0f);
   Obstacle mov3 = new Obstacle(width/2+100,450,15,15,false,true,300,465,1.0f);
   Obstacle mov4 = new Obstacle(width-40,450,15,15,false,true,300,465,1.0f);
   Obstacle movx = new Obstacle(width/2+100,120,15,15,true,true,width/2+100,765,1.0f);
   Obstacle movx2 = new Obstacle(width/2+100,450,15,15,true,true,width/2+100,765,1.0f);
   Obstacle movx3 = new Obstacle(width-40,120,15,15,true,true,810,width-25,1.0f);
   Obstacle movx4 = new Obstacle(width-40,450,15,15,true,true,810,width-25,1.0f);
   obs.add(mov);
   obs.add(mov2);
   obs.add(mov3);
   obs.add(mov4);
   obs.add(movx);
   obs.add(movx2);
   obs.add(movx3);
   obs.add(movx4);
   
   Wall w = new Wall(ob,ob2);
   Wall w2 = new Wall(ob3,ob4);
   Wall w3 = new Wall(ob4,ob5);
   Wall w4 = new Wall(ob6,ob3);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
   walls.add(w4);
   
   Wall mw = new Wall(mov,mov2,30,70,20);
   Wall mw2 = new Wall(mov3,mov4,30,70,20);
   Wall mwx = new Wall(movx,movx2,30,70,20);
   Wall mwx2 = new Wall(movx3,movx4,30,70,20);
   walls.add(mw);
   walls.add(mw2);
   walls.add(mwx);
   walls.add(mwx2);
 }
 
 void levelEleven()
 {
   Dialogue d = new Dialogue(150,height-120,new PVector(0,20,0),"Green Lasers Don't Only Kill You");
   Dialogue d2 = new Dialogue(150,height-120,new PVector(0,20,0),"They Will Reset The Whole Level");
   showDialogue = true;
   logs.add(d);
   logs.add(d2);
   
   Door door = new Door(width/2-10,25,25,height/4-30,new PVector(220,0,100));
   
   Kid kid = new Kid(width/8,height/2,new PVector(220,0,100),10,door);
   kids.add(kid);
   
   kidsInLevel = 1;
   
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle mov = new Obstacle(width/4,height/4,15,15,true,true,0,width/4,1.0f);
   Obstacle mov2 = new Obstacle(width/4,height*3/4,15,15,true,true,0,width/4,1.0f);
   Obstacle mov3 = new Obstacle(width/4-15,height/4,15,15,true,false,width/4,width/2,1.0f);
   Obstacle mov4 = new Obstacle(width/4-15,height*3/4,15,15,true,true,width/4,width/2,1.0f);
   Obstacle mov5 = new Obstacle(width*3/4,height/4,15,15,true,true,width/2,width*3/4,1.0f);
   Obstacle mov6 = new Obstacle(width*3/4,height*3/4,15,15,true,false,width/2,width*3/4,1.0f);
   Obstacle mov7 = new Obstacle(width*3/4-15,height/4,15,15,true,true,width*3/4,width,1.0f);
   Obstacle mov8 = new Obstacle(width*3/4-15,height*3/4,15,15,true,true,width*3/4,width,1.0f);
   obs.add(mov);
   obs.add(mov2);
   obs.add(mov3);
   obs.add(mov4);
   obs.add(mov5);
   obs.add(mov6);
   obs.add(mov7);
   obs.add(mov8);
   
   Obstacle ob = new Obstacle(width-15,25,15,15,true);
   Obstacle ob2 = new Obstacle(width-15,height/2-90,15,15,true);
   Obstacle ob3 = new Obstacle(width-15,height/2+75,15,15,true);
   Obstacle ob4 = new Obstacle(width-15,height-40,15,15,true);
   Obstacle ob5 = new Obstacle(0,height/4,15,15,true);
   Obstacle ob6 = new Obstacle(width/4-15,height/4,15,15,true);
   Obstacle ob7 = new Obstacle(0,height*3/4,15,15,true);
   Obstacle ob8 = new Obstacle(width/4-15,height*3/4,15,15,true);
   Obstacle ob9 = new Obstacle(width*2/5,height*3/4,15,15,true);
   Obstacle ob10 = new Obstacle(width-15,height*3/4,15,15,true);
   Obstacle ob11 = new Obstacle(width*2/5,height/4,15,15,true);
   Obstacle ob12 = new Obstacle(width*3/5,height/4,15,15,true);
   Obstacle ob13 = new Obstacle(width*3/4,25,15,15,true);
   Obstacle ob14 = new Obstacle(width*3/4,height/4,15,15,true);
   Obstacle ob15 = new Obstacle(width*3/5,height*3/4,15,15,true);
   obs.add(ob);
   obs.add(ob2);
   obs.add(ob3);
   obs.add(ob4);
   obs.add(ob5);
   obs.add(ob6);
   obs.add(ob7);
   obs.add(ob8);
   obs.add(ob9);
   obs.add(ob10);
   obs.add(ob11);
   obs.add(ob12);
   obs.add(ob13);
   obs.add(ob14);
   obs.add(ob15);
   
   Wall w = new Wall(ob,ob2);
   Wall w2 = new Wall(ob3,ob4);
   Wall w3 = new Wall(ob5,ob6);
   Wall w4 = new Wall(ob7,ob8);
   Wall w5 = new Wall(ob9,ob10);
   Wall w6 = new Wall(ob11,ob12);
   Wall w7 = new Wall(ob13,ob14);
   Wall w8 = new Wall(ob12,ob15);
   Wall rw = new ResetWall(mov,mov2);
   Wall rw2 = new ResetWall(mov3,mov4);
   Wall rw3 = new ResetWall(mov5,mov6);
   Wall rw4 = new ResetWall(mov7,mov8);
   walls.add(w);
   walls.add(w2);
   walls.add(w3);
   walls.add(w4);
   walls.add(w5);
   walls.add(w6);
   walls.add(w7);
   walls.add(w8);
   walls.add(rw);
   walls.add(rw2);
   walls.add(rw3);
   walls.add(rw4);
 }
 
 void levelTwelve()
 {
   Door door = new Door(width/2+100,25,25,height/4-25,new PVector(250,0,0));
   Door door2 = new Door(width/2-125,25,25,height/4-25,new PVector(250,127,0));
   Door door3 = new Door(width/2+300,25,25,height/4-25,new PVector(250,250,0));
   Door door4 = new Door(width/2-325,25,25,height/4-25,new PVector(127,250,0));
   Door door5 = new Door(width-25,25,25,height/4-25,new PVector(0,250,0));
   
   Kid kid = new Kid(width/2,90,new PVector(250,0,0),10,door);
   Kid kid2 = new Kid(width/2+200,50,new PVector(250,127,0),10,door2);
   Kid kid3 = new Kid(width/2-220,120,new PVector(250,250,0),10,door3);
   Kid kid4 = new Kid(width/2+400,120,new PVector(127,250,0),10,door4);
   Kid kid5 = new Kid(100,50,new PVector(0,250,0),10,door5);
   kids.add(kid);
   kids.add(kid2);
   kids.add(kid3);
   kids.add(kid4);
   kids.add(kid5);
   
   kidsInLevel = 5;
    
   Obstacle bottom = new Obstacle(0,height-25,width,25,true);
   Obstacle top = new Obstacle(0,0,width,25,true);
   obs.add(bottom);
   obs.add(top);
   
   Obstacle oby = new Obstacle(0,height/4,width/2-100,25,true);
   Obstacle oby2 = new Obstacle(width/2+100,height/4,width/2-100,25,true);
   Obstacle oby3 = new Obstacle(width-25,height/4+25,25,height-height/4-50,true);
   Obstacle oby4 = new Obstacle(0,25,25,height/4-25,true);
   obs.add(oby);
   obs.add(oby2);
   obs.add(oby3);
   obs.add(oby4);
   
   Obstacle mov = new Obstacle(0,height-25,25,25,false,true,0,height,0.35f);
   Obstacle mov2 = new Obstacle(width-25,height-25,25,25,false,true,0,height,0.35f);
   obs.add(mov);
   obs.add(mov2);
   
   Wall rw = new ResetWall(mov,mov2);
   walls.add(rw);
   
 }
 
 void removePrev()
 {
   for(int i = obs.size() -1; i >= 0; i--)
   {
     obs.remove(i);
   }
   for(int i = walls.size() - 1; i >= 0; i--)
   {
     walls.remove(i);
   }
 }
 
 void collisionChecker(int i, Obstacle o)
 {
   if(i > 0)
   {
      collided = true;
      if(o.reseter == 1)
      {
        b.reset();
      }
      switch(i)
      {
        //left
        case 1:
        d = true;
        break;
        //right
        case 2:
        a = true;
        break;
        //top
        case 3:
        s = true;
        break;
        //bottom
        case 4:
        w = true;
        break;
        default:
      }
   }
   if(!collided)
   {
     w = false;
     a = false;
     s = false;
     d = false;
     o.reseter = 0;
   }
 }
 
 void mainMenu()
 { 
   fill(80,80,200);
   rect(0,0,width-2,height-2);
   
   fill(255);
   textSize(100);
   text("Ball Puzzle",200,150);
   textSize(25);
   text("'The Demo'",width/2+220,150);
   
   if(mouseX > width/2-width/8 && mouseX < width/2 - width/8 + width/4
     && mouseY > height/2-height/8 && mouseY < height/2 - height/8 + 54)
   {
     overBox = true;
     fill(200,80,80);
   }
   else
   {
     overBox = false;
     fill(250,80,80);
   }
   rect(width/2-100,height/2-height/8,200,54);
   fill(255);
   textSize(60);
   text("START",width/2-100,height/2- height/16 + 12);
 }
 
 void keyTyped()
 {
   if(!showDialogue)
   {
   if(key == 'w' || key == 'W')
   {
     if(!w)
     {
       b.setSpeedY(false);
     }
   }
   if(key == 's')
   {
     if(!s)
     {
       b.setSpeedY(true);
     }
   }
   if(key == 'd')
   {
     if(!d)
     {
       b.setSpeedX(true);
     }
   }
   if(key == 'a')
   {
     if(!a)
     {
       b.setSpeedX(false);
     }
   }
   }
 }
 
 void keyPressed()
 {
   if((keyCode == RETURN || keyCode == ENTER) && showDialogue == true)
   {
     logNum ++;
     if(logNum == logs.size())
     {
       showDialogue = false;
     }
   }
   if(keyCode == UP)
   {
     if(!w)
     {
       b.setSpeedY(false);
     }
   }
   if(keyCode == DOWN)
   {
     if(!s)
     {
       b.setSpeedY(true);
     }
   }
   if(keyCode == LEFT)
   {
     if(!a)
     {
       b.setSpeedX(false);
     }
   }
   if(keyCode == RIGHT)
   {
     if(!d)
     {
       b.setSpeedX(true);
     }
   }
 }
 
 void mousePressed()
 {
   if(overBox && gameState == MAIN_MENU)
   {
     level = new Level();
     gameState = PLAYING;
     levelLoad = 0;
     //b.die();
     loadLevel(levelLoad);
   }
 }
