abstract class enemy{
  
  int x;
  int y;
  int currentFrame;
  int explosionFrame;
  int vx=-1;
  int vy;

  
  enemy(int x, int y){
    this.x=x; //x and y coordinates of the enemy
    this.y=y;
  }
  
  void update(){
    move();
  }
  
  void move(){
    if(gameState=="LOSE" || gameState=="WIN"){
      x=int(random(840,890)); //whenever the game finishes the x position will reset to a new position
    }
    image(images[currentFrame],x,y); 
    
    currentFrame++; //makes it animated
    
    if(currentFrame==43){ // resets the animation so its a loop
      currentFrame=0;      
    }
     //x = 160 is for castle touch 
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
    
    
    if(mousePressed == true){
      float d=dist(x,y, mouseX, mouseY); //if the mouse clicks on enemy it will reset the coordinate of the enemy and player earns a score
      if(d<40){
        x=x+vx;
        x=int(random(840,890));
        y=int(random(0,800));
        score++;
      }
      
    }
  }
}
