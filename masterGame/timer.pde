class Timer{
  int startTime;
  int interval;
  
  Timer(int timeInterval){
    interval = timeInterval;
  }
  
  void start(){
    startTime=millis(); //timer
  }
  
  boolean complete(){
    int elapsedTime=millis()-startTime;
    if(elapsedTime>interval){
      return true;
    }else{
      return false;
    }
  }
}
