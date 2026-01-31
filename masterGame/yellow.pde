class Yellow extends enemy{
  
  int currentFrame3;
  
  Yellow(int x, int y){
    super(x,y);
    vx=-2;
  }
  
  @Override
  void move(){
    if(gameState=="LOSE" || gameState=="WIN"){
    x=int(random(840,890));
    }
    //enemyImage = loadImage("data/monsters/yellow/PNG/frame-1.png");
    //image(enemyImage,x4,y4); //x = 160 is for castle touch 
    
    image(images4[currentFrame3],x,y);
       
    currentFrame3++;
    
    if(currentFrame3==8){ // resets the animation so its a loop
      currentFrame3=0;      
    }
    
    x=x+vx;
    if(x<=160){
      if(millis() - now > delay-500){
        black = !black;

        
        now = millis();
      }
      if(black){
        image(imageExplode[explosionFrame],160,y); //adds delay and adds explosion animation
        if(explosionFrame==64){
          explosionFrame=0;
        }
        explosionFrame++;
        x=-161;
      }else{
        explosionFrame=0; // after timer ends the coordinate will reset again and player will lose a live
        lives--;
        x=int(random(840,890));
        y=int(random(0,800));
      }
    }
    
    if(mousePressed == true){ //if the mouse clicks on enemy it will reset the coordinate of the enemy and player earns a score
      float d=dist(x,y, mouseX-15, mouseY-15);
      if(d<40){
        x=x+vx;
        x=int(random(840,890));;
        y=int(random(0,800));
        score++;
      }
      
    }
  }
  
}
