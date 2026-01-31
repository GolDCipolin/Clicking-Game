class Blue extends enemy{
  int currentFrame2;
  
  Blue(int x, int y){
    super(x,y);
    vx = -1;
    vy=5;
  }
  
  @Override
    void move(){
    if(gameState=="LOSE" || gameState=="WIN"){
      x=int(random(840,890));
    }
    //x = 160 is for castle touch 
    image(images2[currentFrame2],x,y);
       
    currentFrame2++;
    
    if(currentFrame2==43){ // resets the animation so its a loop
      currentFrame2=0;      
    }
    x=x+vx;
    y=y+vy;
    if(y <= 0 || y >= 800){
      vy=vy*-1;
    }
    if(x<=160){
      if(millis() - now > delay-500){
        black = !black;

        
        now = millis();
      }
      if(black){
        image(imageExplode[explosionFrame],160,y); //adds delay and adds explosion animation
        explosionFrame++;
        if(explosionFrame==64){
          explosionFrame=0;
        }
        x=-161;
      }else{
        explosionFrame=0; // after timer ends the coordinate will reset again and player will lose a live
        lives--;
        x=int(random(840,890));
        y=int(random(0,800));
      }
    }

    if(mousePressed == true){ //if the mouse clicks on enemy it will reset the coordinate of the enemy and player earns a score
      float d=dist(x,y, mouseX, mouseY);
      if(d<40){
        x=x+vx;
        x=int(random(840,890));
        y=int(random(0,800));
        score++;
      }
      
    }  
  }
}
