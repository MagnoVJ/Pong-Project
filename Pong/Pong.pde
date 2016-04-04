import android.media.MediaPlayer;
import android.content.res.AssetFileDescriptor;
import android.content.Context;
import android.app.Activity;

PFont fonteTituloInicial;
PFont fonteMenu;
PFont fontVoltar3D;

enum MODE{PONG2D, PONG3D, NENHUM};
enum MENU{JOGAR2D, JOGAR3D};

MODE modo;
MENU menuSelec;

MediaPlayer mp, mp2;
Context context; 
Activity act;
AssetFileDescriptor afd;

int posicX;
int posicY;
int sizeX;
int sizeY;
int sndbola;

void setup(){
  
  modo = MODE.NENHUM;
 
  size(displayWidth, displayHeight, P3D);
  //size(480, 320, P2D);
  orientation(LANDSCAPE);
  
  fonteTituloInicial = createFont("Bauhausb.ttf", 78, true);
  fonteMenu = createFont("Bauhausb.ttf", 50, true);
  fontVoltar3D = createFont("Bauhausb.ttf", 30, true); 
  
  act = this.getActivity();
  context = act.getApplicationContext();
  
  try{
    mp = new MediaPlayer();
    mp2 = new MediaPlayer();
    afd = context.getAssets().openFd("misc_menu.mp3");
    mp.setDataSource(afd.getFileDescriptor());
    mp2.setDataSource(afd.getFileDescriptor());
    mp.prepare();
    mp2.prepare();
  }catch(IOException e) {
    println("file did not load");
  }
  
  setupPong_2D();
  setupPong_3D();
}

void draw(){
  
  if(modo == MODE.NENHUM){
    renderTitle();
  }
  else if(modo == MODE.PONG2D){
    gameUpdate();
    render();  
  }
  else if(modo == MODE.PONG3D){
    gameUpdate3D();
    render3D();
  }
  
}

void renderTitle(){
  
    background(0);
    pushMatrix();
    textFont(fonteTituloInicial);
    textSize(78);
    text("Pong", (width/2) - 80, height - (width/2));
    textFont(fonteMenu);
    textSize(50);
    text("Jogar Versão 2D", (width/2) - 180, height - (width/2) + 160);
    textFont(fonteMenu);
    textSize(50);
    text("Jogar Versão 3D", (width/2) - 180, height - (width/2) + 280);
    
    posicX = (width/2) - 200;
    posicY = height - (width/2) + 110;
    sizeX = 403;
    sizeY = 72;
    
    stroke(255);
    strokeWeight(2);
    noFill();
    rect(posicX, posicY, sizeX, sizeY, 7);
    
    rect(posicX, posicY + 120, sizeX, sizeY, 7);
    
    popMatrix();
    
}

void mousePressed(){
  
  if(modo == MODE.NENHUM){
    if(mouseX >= posicX && mouseY >= posicY && mouseX <= (width/2) - 200 + sizeX && mouseY <= height - (width/2) + 110 + sizeY)
      modo = MODE.PONG2D;
    else if(mouseX >= posicX && mouseY >= posicY + 120 && mouseX <= (width/2) - 200 + sizeX && mouseY <= posicY + 120 + sizeY)
      modo = MODE.PONG3D;
  }
 
}