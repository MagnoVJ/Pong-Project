import ketai.sensors.*;

KetaiSensor sensor;

PVector player3D;
PVector enemy3D;
PVector ball3D;

float ballSpeedX3D;
float ballSpeedY3D;
float enemySpeed3D;
float ballSize3D;
float accelerometerX;
float accelerometerY;
float accelerometerZ;

int playerScore3D;
int enemyScore3D;
int level3D;
int divisor3D;
int divisorEnemSpeed3D;

void setupPong_3D(){
  
  ball3D = new PVector(width/2, height/2);
  player3D = new PVector(width, height/2);
  enemy3D = new PVector(0, height/2);
  
  ballSpeedX3D = width/100;
  ballSpeedY3D = width/100;
  ballSize3D = width/40;
  
  strokeWeight(1);
  
  playerScore3D = 0;
  enemyScore3D = 0;
  level3D = 0;
  divisor3D = 100;
  divisorEnemSpeed3D = 133;
  
  sensor =  new KetaiSensor(this);
  sensor.start();
  
}

void gameUpdate3D(){
  
  ball3D.x += ballSpeedX3D;
  ball3D.y += ballSpeedY3D;
  
  float tempOrientation = (float)((int)(-accelerometerY * 1000))/1000;
  
  camera((width/2.0 + tempOrientation * width/10) + 145, height/2.0, (height/2.0)/tan(PI*30.0/180.0), width/2.0, height/2.0, 0, 0, 1, 0);
  
  enemyAI3D();
  ballBoundary3D();
  
}


void ballBoundary3D(){
  
  //top
  if(ball3D.y < 0){
    ball3D.y = 0;
    ballSpeedY3D *= -1;
  }
  
  //bottom
  if(ball3D.y > height){
    ball3D.y = height;
    ballSpeedY3D *= -1;
  }
  
  ////left
  //if (ball3D.x < 0){
  //    ball3D.x = 0;
  //    ballSpeedX3D *= -1; 
  // }
   
   ////right 
   //if (ball3D.x > width){
   //   ball3D.x = width;
   //   ballSpeedX3D *= -1; 
   //}
   
   if(ball3D.x > width){
       ball3D.x = width/2;
       ballSpeedX3D *= -1;
       enemyScore3D ++;
    }
    
    if(ball3D.x < 0){
       ball3D.x = width/2; 
       ballSpeedX3D *= -1;
       playerScore3D ++;
    }
    
    //player
    if (ball3D.x > width - width/40 - ballSize3D && ball3D.x < width && Math.abs(ball3D.y - player3D.y) < width/10) {
       ball3D.x = width - width/40 - ballSize3D;
       ballSpeedX3D *= -1;
       mp.start();
    }
    
    //enemy
    if (ball3D.x < width/40 + ballSize3D && ball3D.x > 0 && Math.abs(ball3D.y - enemy3D.y) < width/10) {
       ball3D.x = width/40 + ballSize3D;
       ballSpeedX3D *= -1; 
       mp2.start();
    }
   
    
}

void onAccelerometerEvent(float x, float y, float z){
  accelerometerX = x;
  accelerometerY = y;
  accelerometerZ = z;
}

void drawCenterLine3D(){
  
  int numberOfLines = 20;
  
  for(int i = 0; i * width/numberOfLines < height; i++){
    strokeWeight(width/100);
    stroke(200, 162, 200);
    line(width/2, i * width/numberOfLines, width/2, (i+1) * width/numberOfLines - width/40);
    //stroke(0, 0);
    //line(width/2, (i+1) * width/numberOfLines - width/40, width/2, (i+1) * width/numberOfLines);
  }
  
}

void drawPlayer3D(){
  
  player3D.y = mouseY;
  
  pushMatrix();
  translate(player3D.x, player3D.y);
  stroke(0);
  strokeWeight(1);
  fill(0,255,0);
  box(width/20, width/5, width/50);
  popMatrix();
  
}

void drawEnemy3D(){
  
  enemy3D.y += enemySpeed3D;
  
  pushMatrix();
  translate(enemy3D.x, enemy3D.y);
  fill(255, 0, 0);
  strokeWeight(1);
  box(width/20, width/5, width/50);
  popMatrix();

}

void drawBall3D(){
  
  pushMatrix();
  translate(ball3D.x, ball3D.y, width/100);
  fill(255);
  fill(255 * (ball3D.x/width), 255 * ((width - ball3D.x)/width), 0);
  noStroke();
  sphere(ballSize3D);
  popMatrix();
  
}

void drawScoreText3D(){
  fill(200, 162, 200);
  textSize(width/20);
  text(enemyScore3D, width/10 * 3, height/5);
  text(playerScore3D, width/10 * 7, height/5);
}

void render3D(){
  
  background(255);
  drawCenterLine3D();
  drawScoreText3D();
  drawPlayer3D();
  drawEnemy3D();
  drawBall3D();
  drawLineBoundary3D();
  
  println("------------------");
  println(accelerometerX);
  println(accelerometerY);
  println(accelerometerZ);
  
}

void enemyAI3D(){
  
  if(enemy3D.y < ball3D.y)
    enemySpeed3D = width/150;
    
  if(enemy3D.y > ball3D.y)
    enemySpeed3D = (-1) * width/150;
    
  if(enemy3D.y == ball3D.y)
    enemySpeed3D = 0;
    
  if(ball3D.x > width/2)
    enemySpeed3D = 0;
    
}

void drawLineBoundary3D(){
  
  stroke(200, 162, 200);
  strokeWeight(2);
  noFill();
  rect(0, 0, width, height, 1);
  
}