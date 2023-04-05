public class Car{
  PVector pose = new PVector(0,0); // the car's x, y position
  float angle = 0; // the current angle that the car is at.
  int carLength = 50;
  int carWidth = 40;
  
  ArrayList<View> views = new ArrayList<View>();
  ArrayList<PVector> points = new ArrayList<PVector>();
  
  // default constructor
  Car(){}
  
  Car(int xPos, int yPos, int carLength, int carWidth){
    this.pose = new PVector(xPos, yPos);
    this.carLength = carLength;
    this.carWidth = carWidth;
  }
  
  //adds a new view with the specified FOV and ray number
  public void addView(float FOV, int numberOfRays){
    views.add(new View(pose, numberOfRays, radians(FOV)));
  }
  
  //draw the car and its views
  public void drawCar(ArrayList<Wall> walls){
    stroke(255);
    ellipse(pose.x, pose.y, carWidth, carLength);
    this.updateViews(walls);
  }
  
  //add the points that each view can currently see to the list of points
  void seePoints(){
    for(View view : views){
      ArrayList<PVector> pointList = view.getPoints();
      for(PVector point : pointList){
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
  
  public PVector getPose(){
    return pose;
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
  
  public void setPose(PVector newPose){
    pose = newPose;
    for(View view : views){
      view.setPos(pose);
    }
  }
}
