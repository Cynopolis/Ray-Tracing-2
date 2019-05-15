public class Car{
  int xPos;
  int yPos;
  float angle = 0; //IN RADIANS
  int carLength;
  int carWidth;
  int xVel = 0;
  int yVel = 0;
  int pastTime = millis();
  int time = millis();
  
  ArrayList<View> views = new ArrayList<View>();
  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
  ArrayList<int[]> points = new ArrayList<int[]>();
  
  Car(int xPos, int yPos, int carLength, int carWidth){
    this.xPos = xPos;
    this.yPos = yPos;
    this.carLength = carLength;
    this.carWidth = carWidth;
  }
  
  public void addView(float FOV, int numberOfRays){
    views.add(new View(this.xPos, this.yPos, numberOfRays, radians(FOV)));
  }
  
  public void drawCar(ArrayList<Wall> walls){
    stroke(255);
    ellipse(xPos, yPos, carWidth, carLength);
    for(View view : views){
      view.look(walls);
    }
    for(Obstacle obstacle : obstacles){
      obstacle.drawObstacle();
    }
    this.pointProcess();
  }
  
  void pointProcess(){
    for(View view : views){
      ArrayList<int[]> somePoints = view.getPoints();
      for(int[] point : somePoints){
        points.add(point);
      }
    }
    for(Obstacle obstacle : obstacles){
      for(int i = 0; i < points.size(); i++){
        if(obstacle.addPoint(points.get(i)[0], points.get(i)[1]) == true){
          points.remove(i);
        }
        else {
          for(int j = i+1; j < points.size()-i; j++){
            if(this.getDistance(points.get(i)[0], points.get(i)[1], points.get(j)[0], points.get(j)[1]) <= 5){
              ArrayList<int[]> temp = new ArrayList<int[]>();
              temp.add(new int[] {points.get(i)[0], points.get(i)[1]});
              temp.add(new int[] {points.get(j)[0], points.get(j)[1]});
              obstacles.add(new Obstacle(temp));
            }
          }
        }
      }
    }
  }
  
  //find the distance between (a,b) and (x,y).
  private float getDistance(int a, int b, int x, int y){
    return sqrt((float)(a-x)*(a-x)+(b-y)*(b-y));
  }
  
  public int[] getPos(){
    return new int[] {this.xPos, this.yPos};
  }
  
  public float getAngle(){
    return degrees(this.angle);
  }
  
  public void setAngle(float angle){
    angle = radians(angle);
    while(angle >= 2*PI){angle -= 2*PI;}
    while(angle <= -2*PI){angle += 2*PI;}
    this.angle = angle;
    for(View view : views){
      view.setAngle(angle);
    }
  }
  
  public void setPos(int x, int y){
    this.xPos = x;
    this.yPos = y;
    pastTime = time;
    time = millis();
    for(View view : views){
      view.setPos(x, y);
    }
  }
}
