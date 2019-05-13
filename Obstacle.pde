public class Obstacle{
  double[] COM = {0, 0};
  double[] pastCOM = {0, 0};
  ArrayList<int[]> points;
  double xVel = 0;
  double yVel = 0;
  int time;
  
  Obstacle(ArrayList<int[]> points){
    this.points = points;
  }
  
  public boolean addPoint(int x, int y){
    double[] CoM = this.getCenterOfMass();
    double d1 = this.getDistance(CoM[0], CoM[1], x, y);
    double d2 = 0;
    double dLarge = 0;
    for(int i = 0; i < this.points.size(); i++){
      d2 = this.getDistance(CoM[0], CoM[1], points.get(i)[0], points.get(i)[1]);
      if(d2 > dLarge){
        dLarge = d2;
      }
    }
    if(d1 > dLarge+5){
      points.add(new int[] {x, y});
      getCenterOfMass();
      return true;
    }
    else{return false;}
  }
  
  public double[] getCenterOfMass(){
    double x = 0;
    double y = 0;
    this.pastCOM = this.COM;
    for(int i = 0; i < points.size(); i++){
      x += points.get(i)[0];
      y += points.get(i)[1];
    }
    x /= points.size();
    y /= points.size();
    
    return new double[] {x, y};
  }
  
  public void setCenterOfMass(int x, int y){
    int pastX = (int)this.getCenterOfMass()[0];
    int pastY = (int)this.getCenterOfMass()[1];
    
    for(int i = 0; i < points.size(); i++){
      int xCoord = this.points.get(i)[0] + (x-pastX);
      int yCoord = this.points.get(i)[1] + (y-pastY);
      this.points.set(i, new int[] {xCoord, yCoord});
    }
  }
  
  public void findVelocity(int time){
    this.xVel = (this.pastCOM[0] - this.COM[0])/(time-this.time);
    this.yVel = (this.pastCOM[1] - this.COM[1])/(time-this.time);
    this.time = time;
  }
  
  public void drawObstacle(){
    stroke(255);
    for(int i = 0; i < points.size(); i++){
      ellipse(points.get(i)[0], points.get(i)[1], 10, 10);
      if(i == points.size()){break;}
      line(points.get(i)[0], points.get(i)[1], points.get(i+1)[0], points.get(i+1)[1]);
    }
  }
  
  private float getDistance(double a, double b, double x, double y){
    return sqrt((float)((a-x)*(a-x)+(b-y)*(b-y)));
  }
}
