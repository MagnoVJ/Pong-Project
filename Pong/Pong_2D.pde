PVector ball;
PVector player;
PVector enemy;

float ballSpeedX;
float ballSpeedY;
float enemySpeed;
float ballSize;
float movYtransl;

int playerScore;
int enemyScore;
int level, divisor;//variaveis para aumentar o nível
int divisorEnemSpeed;

void setupPong_2D(){
 
  ball = new PVector(width/2, height/2);
  player = new PVector(width, height/2);
  enemy = new PVector(0, height/2);
  
  ballSpeedX = width/100;
  ballSpeedY = width/100;
  ballSize = width/20;

  strokeWeight(1);
  
  playerScore = 0;
  enemyScore = 0;
  level = 0;
  divisor = 100;
  divisorEnemSpeed = 133;
  
}

void gameUpdate(){
  
  ball.x +=ballSpeedX;
  ball.y +=ballSpeedY;
  
  enemyAI();
  
  ballBoundary();
  verificLevel();
  
}

void verificLevel(){
  
  if(level == 10){
    level = 0;
    
    divisor = divisor - 15;
    divisorEnemSpeed -= 17; 
    
    if(divisor < 0)
      divisor = 15;
      
  }
  
  if(ballSpeedX < 0)
    ballSpeedX = -1 * (width/divisor);
  else if(ballSpeedX > 0)
    ballSpeedX = width/divisor;
    
  if(ballSpeedY < 0)
    ballSpeedY = -1 * (width/divisor);
  else if(ballSpeedY > 0) 
    ballSpeedY = width/divisor;
  
  //println("-----------------------------");
  //println("level " + level);
  //println("ballSpeedX " + ballSpeedX);
  //println("ballSpeedY " + ballSpeedY);
  //println("divisor " + divisor);
  //println("width/divisor " + width/divisor);
  //println("divisorEnemSpeed " + divisorEnemSpeed);
  //println("-----------------------------");
  
}

void enemyAI(){
 
  if(enemy.y < ball.y)
    enemySpeed = width/divisorEnemSpeed;
  if(enemy.y > ball.y)
    enemySpeed = -1 * (width/divisorEnemSpeed);
  if(enemy.y == ball.y)
    enemySpeed = 0;
  if(ball.x > width/2)
    enemySpeed = 0;

}

void ballBoundary(){
  
  //top
  if(ball.y < (width/20))
    ballSpeedY *= -1;
  
  //bottom
  if(ball.y > height - (width/20))
    ballSpeedY *= -1;  
  
  ////left
  //if(ball.x < (width/20))
  //  ballSpeedX *= -1;
  
  ////right
  //if(ball.x > width - (width/20))
  //  ballSpeedX *= -1;
  
  if(ball.x > width - (width/20)){
    ball.x = width/2;
    ball.y = height/2;
    ballSpeedX *= (random(-1,1)<0?-1:1);
    ballSpeedY *= (random(-1,1)<0?-1:1);
    level = 0;
    divisor = 100;
    divisorEnemSpeed = 133;
    enemyScore++;
    
  }
  
  if(ball.x < (width/20)){
    ball.x = width/2;
    ball.y = height/2;
    ballSpeedX *= (random(-1,1)<0?-1:1);
    ballSpeedY *= (random(-1,1)<0?-1:1);
    level = 0;
    divisor = 100;
    divisorEnemSpeed = 133;
    playerScore++;
    
  }
  
  //Player collison
  if(player.y < width/10)
    player.y = width/10;
  if(player.y>height-(width/10))
    player.y = height-(width/10);
  
  if(ball.x > (width - (width/20)) - ballSize && ball.x < (width - (width/20)) && Math.abs(ball.y - player.y) < width/10){
    ball.x = (width - (width/20)) - ballSize;
    ballSpeedX *= -1;
    level++;
    mp.start();
  }
  
  //Enemy collison
  if(enemy.y < width/10)
    enemy.y = width/10;
  if(enemy.y>height-(width/10))
    enemy.y = height-(width/10);
    
  if(ball.x < (width/20) + ballSize && ball.x > (width/20) && Math.abs(ball.y - enemy.y) < width/10){
    ball.x = width/20 + ballSize;
    ballSpeedX *= -1;
    level++;
    mp2.start();
  }
 
}

void drawCenterLine(){
  
  int numberOfLines = 20;
  
  for(int i = 0; i < numberOfLines; i++){ 
    strokeWeight(width/100);
    stroke(200, 162, 200); //Define a cor
    line(width/2,i*width/numberOfLines, width/2,(i+1)*width/numberOfLines-width/40);//desenha linhas pontilhadas brancas
    //stroke(0, 0);
    //line(width/2, (i+1)*width/numberOfLines-width/40,width/2,(i+1)*width/numberOfLines);//desenha linhas pontilhadas pretas por entre as brancas
  }
  
}

void drawScoreText(){
  
  fill(200, 162, 200);
  textSize(width/20);
  text(enemyScore, width/10 * 3, height/5);
  text(playerScore, width/10 * 7, height/5);
  
}

void drawBall(){
  
  pushMatrix();
  translate(ball.x, ball.y);
  fill(255 * (ball.x/width), 255 * ((width - ball.x)/width), 0);
  noStroke();
  ellipse(0,0,width/20,width/20);
  popMatrix();
  
}

void drawPlayer(){
  
  player.y = mouseY;

  pushMatrix();
  
  movYtransl = player.y - (width/5)/2;
  
  if(movYtransl < 0)
    movYtransl = 0;
  else if(player.y + (width/5)/2 > height)
    movYtransl = (height - (width/5)/2) - (width/5)/2;
    
  translate((player.x - width/20)-20, movYtransl);
  
  //stroke(0);
  fill(0, 255, 0);
  rect(0, 0, width/20, width/5);
  popMatrix(); 
}

void drawEnemy(){
  
  enemy.y += enemySpeed;
  
  pushMatrix();
  
  float movYtransl = enemy.y - (width/5)/2;
  
  if(movYtransl < 0)
    movYtransl = 0;
  else if(enemy.y + (width/5)/2 > height)
    movYtransl = (height - (width/5)/2) - (width/5)/2;
   
  translate((enemy.x)+20, movYtransl);
  
  fill(255, 0, 0);
  rect(0, 0, width/20, width/5);
  popMatrix();
}

void render(){
  
  background(255);
  drawCenterLine();
  drawScoreText();
  drawBall();
  drawPlayer();
  drawEnemy();
  drawLineBoundary();
  
}

void drawLineBoundary(){
  
  stroke(200, 162, 200);
  strokeWeight(4);
  noFill();
  rect(4, 4, width - 8, height - 8, 1);
  
}