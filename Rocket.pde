PImage []  Rocket = new PImage [5];
PImage Die, Play, Die1;
PImage Base;
PImage [] planet = new PImage [3];
PImage [] Fuel = new PImage[4];
PImage mice;
String Name;
int baseY=495;
PFont f,f1;
int launch=-1;
int counter=0;
float rX=275;
int angle=0;
float speedX=0;
int speedY=2;
PImage left,right;
int [] Brock={0,1,2,2,1};
int[]  brockX= new int[5];
int[]  brockY= new int[5];
int spePlanet=7;
int score=0;
int ex=0;
import ddf.minim.*;
AudioPlayer BGM;
Minim bgm;


void setup()
{
  bgm= new Minim(this);
  BGM=bgm.loadFile("bgm.mp3");
  BGM.loop();
  strokeWeight(0);
  size(550, 750);
  background(#0A0729);
  for (int i=0;i<5;i++)
  {
  brockX[i]=int(random(30,520));
  brockY[i]=i*(-150)-50;
  }
  left=loadImage("left.png");
  right=loadImage("right.png");
  for (int i=1; i<=4; i++)
  {
    Name="0"+i+".png";
    Rocket[i-1]=loadImage(Name);
    imageMode(CENTER);
  }
  mice=loadImage("mice.png");
  Die=loadImage("die.png");
  Die1=loadImage("die1.png");
  Play=loadImage("play.png");
  Base=loadImage("2.png");
  imageMode(CENTER);
  for (int i=0; i<=2; i++)
  {
    imageMode(CENTER);
    Name="P"+i+".png";
    planet[i]=loadImage(Name);
    imageMode(CENTER);
  }
  for (int i=0; i<=3; i++)
  {
    Name="F"+i+".png";
    Fuel[i]=loadImage(Name);
    imageMode(CENTER);
  }
  f=createFont ("AGaramondPro-BoldItalic-48", 15);
  f1=createFont ("AGaramondPro-BoldItalic-48", 30);
}

void draw()
{
  background(#0A0729);

  if (launch==1)
  {
    Pre();
    score=0;
    if (baseY>750)
    {
      launch=2;
    }
  } else if (launch==0)
  {
    Prepre();
    if (key=='a')
    {
      launch=1;
    }
  } else if (launch==-1)
  {
    begining();
    if (mouseX>160 && mouseX<380 && mouseY>400 && mouseY<460 && mousePressed)
    {
      launch=0;
    }
  } else if (launch==2)
  {
  
    Planet();
    if(rX<0 || rX >550)
    {
    explosion();
    }
    if (ex==0)
    {
    playing();}
   collision();
  }
  else if (launch==3)
  {
  if (mouseX>160 && mouseX<380 && mouseY>400 && mouseY<460)
    {
      image(Die1,275, 375);
    }
    else{image(Die,275, 375);}
    if (mouseX>160 && mouseX<380 && mouseY>400 && mouseY<460 && mousePressed)
    {
      launch=0;
      rX=275;
      angle=0;
      speedX=0;
      baseY=495;
      ex=0;
      spePlanet=7;
  for (int i=0;i<5;i++)
  {
  brockX[i]=int(random(30,520));
  brockY[i]=i*(-150)-50;
  }
    }
     ending();
  }
  //////////////
  textFont(f1);
  fill(255, 255, 255);
  text(score, 480, 720);
  textFont(f);
  text("By Simon He", 10, 720);
  //rect(50,50,70,70);
  //rect(rX,375,27,48);
  
  
}


void Mice()
{
  image(mice, mouseX, mouseY, 15, 25);
}

void begining()
{
  image(Play, 275, 375);
  Mice();
}

void Prepre()
{
  image(Base, 275, baseY);
  image(Rocket[0], rX, 375);
  textFont(f);
  fill(255, 255, 255);
text("' A ' TO LAUNCH", 220, baseY+130);
}

void Pre()
{
  image(Base, 275, baseY);
  image(Rocket[0], rX, 375);
  textFont(f);
  fill(255, 255, 255);
  text("' A ' TO LAUNCH", 220, baseY+130);
  text("ARROW KEYS TO MOVE AND AVOID PLANETS", 100, baseY-400);
  baseY+=speedY;
}

void playing()
{

  if (key==CODED)
  {
    if (keyCode==LEFT && keyPressed)
    {
      angle-=4;
    } else if (keyCode==RIGHT && keyPressed)
    {
      angle+=4;
    }
  }
      rX+=angle/7;
  if(angle<-5)
  {

  pushMatrix();
  translate(rX, 375);
  rotate(radians(angle));
  image(left, 0, 0);
  popMatrix();
  }
  else if(angle>5)
  {
  pushMatrix();
  translate(rX, 375);
  rotate(radians(angle));
  image(right, 0, 0);
  popMatrix();
  }
  else{  pushMatrix();
  translate(rX, 375);
  rotate(radians(angle));
  image(Rocket[0], 0, 0);
  popMatrix();}
}


void ending()
{
Mice();
}


void Planet()
{
for(int i=0;i<5;i++)
{
 brockY[i]+=spePlanet;
 if(brockY[i]>770)
 {
 brockY[i]=-50;
 brockX[i]=int(random(30,520));
 Brock[i]=int(random(0,3));
 score++;
 }
 image(planet[Brock[i]], brockX[i], brockY[i]);
}
}

void collision()
{
  for(int i=0;i<5;i++)
  {
  if ((brockY[i]+26)>351 && (brockY[i]-26)<396 && (brockX[i]+26)>(rX-13) && (brockX[i]-26)<(rX+13))
  {
  explosion();
  spePlanet=0;
  speedX=0;
  }
  }
}

void explosion()
{
if(ex==0)
{
delay(30);
image(Rocket[1],rX,375);
ex=1;
}
else if(ex==1)
{
delay(30);
image(Rocket[2],rX,375);
ex=2;
}
else if(ex==2)
{
delay(30);
image(Rocket[3],rX,375);
ex=3; 
}
else if(ex==3)
{
delay(30);
launch=3;}
}

