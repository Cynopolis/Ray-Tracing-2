public class Car{
  int xPos;
  int yPos;
  float angle = 0; //IN RADIANS
  int carLength;
  int carWidth;
  
  ArrayList<View> views = new ArrayList<View>();
  ArrayList<int[]> points = new ArrayList<int[]>();
  
  Car(int xPos, int yPos, int carLength, int carWidth){
    this.xPos = xPos;
    this.yPos = yPos;
    this.carLength = carLength;
    this.carWidth = carWidth;
  }
  
  //adds a new view with the specified FOV and ray number
  public void addView(float FOV, int numberOfRays){
    views.add(new View(this.xPos, this.yPos, numberOfRays, radians(FOV)));
  }
  
  //draw the car and its views
  public void drawCar(ArrayList<Wall> walls){
    stroke(255);
    ellipse(xPos, yPos, carWidth, carLength);
    this.updateViews(walls);
  }
  
  //add the points that each view can currently see to the list of points
  void seePoints(){
    for(View view : views){
      ArrayList<int[]> pointList = view.getPoints();
      for(int[] point : pointList){
        points.add(point);
      }
    }
  }
  
  //updates what each ray is colliding with in each view
  void updateViews(ArrayList<Wall> walls){
    for(View view : views){
      view.look(walls);
    }
  }
  
  public int[] getPos(){
    return new int[] {this.xPos, this.yPos};
  }
  
  //always returns a positive angle between 0 and 360 degrees
  public float getAngle(){
    return degrees(this.angle);
  }
  
  //the given angle is in DEGREES!
  public void setAngle(float angle){
    //converts from degrees to radians
    angle = radians(angle);
    while(angle >= 2*PI){angle -= 2*PI;}
    while(angle <= -2*PI){angle += 2*PI;}
    this.angle = angle;
    for(View view : views){
      view.setAngle(angle);
    }
    return;
  }
  
  public void setPos(int x, int y){
    this.xPos = x;
    this.yPos = y;
    for(View view : views){
      view.setPos(x, y);
    }
  }
}
