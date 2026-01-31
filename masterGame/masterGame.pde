String gameState;
int highscore; //the highscore the play gets
int score; //the score the player will get each game
int lives; //the live
PFont mono; //class for font
PImage imgCastle;
PImage imgBackround;
Timer countDownTimer;
int timeLeft;
int maxTime;
PrintWriter newHighscore;
int randomAmount=int(random(12,26));
enemy[] enemys = new enemy[randomAmount]; //spawns the random amount of enemys
PImage[] imageExplode = new PImage[64];
PImage[] images = new PImage[43];
PImage[] images2 = new PImage[43];
PImage[] images3 = new PImage[8];
PImage[] images4 = new PImage[16];
//PImage imageExplode;
int delay=1000;
int now;
boolean black = false;

void setup(){
  imgCastle=loadImage("../data/wall.png");
  imgBackround=loadImage("../data/grass.png");
  size(800,800);
  mono = loadFont("DeterminationSansWeb-48.vlw"); //mono is being stored as the font to be used
  gameState = "START";
  score = 0; //the score will reset each game
  String[] oldHighscore = loadStrings("highScore.txt");
  highscore=int(oldHighscore[0]);
  //highscore = lines[0]; //highscore will be read from a file, for now its 0
  lives=3; //each game will have 3 lives to the base
  countDownTimer = new Timer(1000);
  maxTime=30;
  timeLeft=maxTime;
  now = millis();
  
  for(int counter=0; counter<imageExplode.length; counter++){ //loads explode image
    imageExplode[counter] = loadImage("data/explosion/tile0"+nf(counter,2)+".png");
  }
  
  for(int i=0;i<enemys.length; i++){ //loads the enemy
    int x=int(random(840,890));
    int y=int(random(0,800));
    
    int randomNum = (int)random(1,5);
    switch(randomNum){
      case 1: // red enemy
        for(int counter=0;counter<images.length;counter++){
           images[counter] = loadImage("data/monsters/red/PNG/idle/a_0"+nf(counter,2)+".png");
        }
        enemys[i] = new Red(x,y);
        break;
      case 2: // blue enemy
        for(int counter=0;counter<images2.length;counter++){
          images2[counter] = loadImage("data/monsters/blue/PNG/idle/og_0"+nf(counter,2)+".png");
        }
        enemys[i] = new Blue(x,y);
        break;
      case 3: // fake enemy
        for(int counter=0;counter<images3.length;counter++){
          images3[counter] = loadImage("data/monsters/fake/PNG/idle/"+counter+".png");
        }
        enemys[i] = new Fake(x,y);
        break;
      case 4:
        for(int counter=0;counter<images4.length;counter++){
          images4[counter] = loadImage("data/monsters/yellow/PNG/frame-"+counter+".png");
        }
        enemys[i] = new Yellow(x,y);
        break;
    }
  }
}

void draw(){
  clearBackground();
  if(gameState == "START"){ //startGame is the main menu, playGame is when the game is actually being played, winGame is when the player wins they get that scrreen, loseGame is winGame but if player loses
    startGame();
  }else if (gameState == "PLAY"){
    playGame();
  }else if(gameState == "WIN"){
    winGame();
  }else if(gameState == "LOSE"){
    loseGame();
  }
}

void startGame(){
  textAlign(CENTER);
  background(0);
  fill(255);
  textFont(mono,36);
  text("Click Anywhere to Begin Playing!",width/2,height/2);
  textSize(25);
  fill(255,0,0);
  text("Survive for 30 seconds and stop the incoming enemies\nfrom attacking the base!\nClick on them to defeat them",width/2,height/2+50);
  textSize(60);
  fill(0,0,255);
  text("Clicking Game",width/2,height/2-50);
  
  // explanation of enemy
  //red
  fill(255,0,0);
  textSize(15);
  text("RED: A normal monster,\n does nothing but attacks your castle.", 200, 100);
  //blue
  fill(0,0,255);
  text("BLUE: A monster that goes up and down,\n quite hard to catch them.\n Also attacks the castle.", 600, 100);
  //yellow
  fill(#FFFF00);
  text("YELLOW: This monster is faster than the other monsters.\nThey will attack the castle.", 200, 180);
  //brown
  fill(#964B00);
  text("BROWN: This is a friendly monster,\nif you kill it you will lose a life.\nIt doesn't attacks the castle.", 600, 180);
  //look for the click
  if(mousePressed == true){
    gameState = "PLAY";
    countDownTimer.start();
  }
  showScore();
}


void playGame(){
  if(lives<=-1){ //just incase if the lives are stuck at below 0 (it happens for some reason)
    lives=3;
  }
  background(0);
  image(imgBackround,0,0); //loads in the castle and background
  image(imgCastle,0,50);
  for(enemy e : enemys){ //loads and moves the enemy
    e.update();
  }
  marker(); // crosshair to indicate where to click on
  //game logic
  if(lives<=0){
    //lose
    gameState="LOSE";
  }
  //countDown logic
  if(countDownTimer.complete() == true){ //countdown timer
    if(timeLeft>1){
      timeLeft--;
      countDownTimer.start();
    }else{
      
      gameState="WIN";
    }
  }
  //show countDown
  String s = "Time Left: "+timeLeft;
  textAlign(LEFT);
  textSize(18);
  fill(255,0,0);
  text(s,20,20);
  //show score
  String s2 = "Score: "+score;
  text(s2,20,40);
  //show live
  String s3 = "Lives: "+lives;
  text(s3,20,60);
}
void winGame(){ //WINNING SCREEN IF PLAYER DEFEATS AL THE ENEMIES OR PROTECTS THE BASE BEFORE TIMER RUNS OUT
  for(enemy e : enemys){
    e.update(); //resets the enemy to new coordinates
  }
  if(score>int(highscore)){
    saveScore(); //saves score as highscore
  }
  textAlign(CENTER);
  background(0);
  fill(255);
  textFont(mono,36);
  if(millis() - now > delay){ // flashes "you won" text
    black = !black;
    
    now = millis();
  }
  if(black){
    fill(0);
  }else{
    fill(255);
  }
  text("You won!",width/2,height/2);
  textSize(25);
  fill(255,0,0);
  text("Press E to start the game again.",width/2,height/2+50);
  //look for the click
  

  
  if(keyPressed){ //resets the game to play it again
    if(key =='e' || key == 'E'){
      score=0;
      lives=3;
      gameState = "PLAY";
    }
  }
  showScore();
  resetGame();
}

void loseGame(){ //LOSING SCREEN IF THE PLAYERS BASE GETS DESTROYED
  for(enemy e : enemys){
    e.update();
  } 
  if(score>highscore){
    saveScore();
  }
  textAlign(CENTER);
  background(0);
  textSize(20);
  text("Make sure to protect your base from the enemies\nto avoid losing",width/2,height/2+30);
  fill(255);
  textFont(mono,36);
  if(millis() - now > delay){
    black = !black;
    
    now = millis();
  }
  if(black){
    fill(0);
  }else{
    fill(255);
  }
  text("You lost!",width/2,height/2);
  textSize(25);
  fill(255,0,0);
  text("Press E to start the game again.",width/2,height/2+80);

  //look for press E key
  if(keyPressed){
    if(key =='e' || key == 'E'){
      score=0;
      lives=3;
      gameState = "PLAY";
    }
  }
  showScore();
  resetGame();
}
void resetGame(){
  timeLeft=maxTime; // when resetting the game, the time left rests back to 30 and the count down begins again
  countDownTimer.start();
}

void showScore(){
  textAlign(LEFT); //shows highscore
  textSize(24);
  fill(255);
  String s = "Highscore: "+highscore;
  text(s, 20,50);
}

void clearBackground(){ // clears background
  fill(255);
  rect(0,0,width,height);
}

void saveScore(){ // saves score as highscore if the score that was achieved was higher than the highscore
  newHighscore = createWriter("highScore.txt"); //recreates the highscore text and saves the new highscore in the same text file
  highscore=score;
  newHighscore.print("");
  newHighscore.println(highscore);
  newHighscore.flush();
  newHighscore.close();
}

void marker(){ //crosshair to indicate where the player will be shooting
  noFill();
  stroke(255,0,0);
  line(mouseX-20,mouseY,mouseX-10,mouseY); //lines of the crosshair
  line(mouseX,mouseY-20,mouseX,mouseY-10);
  line(mouseX+20,mouseY,mouseX+10,mouseY);
  line(mouseX,mouseY+20,mouseX,mouseY+10);
  ellipse(mouseX,mouseY,20,20); //circle of the crosshair
}
