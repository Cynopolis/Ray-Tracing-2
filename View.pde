public class View{
  int xPos;
  int yPos;
  float angle = 0;
  float FOV;
  ArrayList<Ray> rays = new ArrayList<Ray>();
  
  //the x,y position of the view, what angle it's looking at and its FOV
  View(int xPos, int yPos, int numberOfRays, float FOV){
    this.xPos = xPos;
    this.yPos = yPos;
    this.FOV = FOV;
    this.setRayNum(numberOfRays, FOV, this.angle);
  }
  
  //sets the number of rays and their starting values in the ray list
  public void setRayNum(int numberOfRays, float FOV, float angleOffset){
    float rayStep = FOV/numberOfRays;
    rays.clear();
    float angle = 0.01-angleOffset; //the 0.01 fixes some bugs
    for(int i = 0; i < numberOfRays; i++){
      Ray ray = new Ray(xPos, yPos, 100000, angle);
      angle = angle + rayStep;
      rays.add(ray);
    }
  }
  
  //sees if the ray will collide with the walls in the wall list
  public void look(ArrayList<Wall> walls){
    for (Ray ray : rays){
      ray.castRay(walls);
      ray.drawRay();
    }
  }
  
  //changes the position of the view
  public void setPos(int x, int y){
    this.xPos = x;
    this.yPos = y;
    for(Ray ray : rays){ray.setPos(x, y);}
  }
  
  //changes the angle of the view
  public void setAngle(float angle){
    this.angle = angle;
    this.setRayNum(rays.size(), this.FOV, angle);
  }
  
  //changes the field of view of the view
  public void setFOV(float FOV){
    this.FOV = FOV;
    this.setRayNum(this.rays.size(), this.FOV, this.angle);
  }
  
  public int[] getPos(){return new int[] {this.xPos, this.yPos};}
  
  public float getAngle(){return this.angle;}
  
  public float getFOV(){return this.FOV;}
  
  public int getRayNum(){return this.rays.size();}
  
  //gets the point that each ray has collided with
  public ArrayList<int[]> getPoints(){
    ArrayList<int[]> points = new ArrayList<int[]>();
    
    for(Ray ray : rays){
      if(ray.getPoint() != new int[] {}){
        points.add(ray.getPoint());
      }
    }
    return points;
  }
}

class Ray{
  int xPos;
  int yPos;
  int rayLength;
  int defaultRayLength;
  float angle; // IN RADIANS
  
  //takes the starting position of the ray, the length of the ray, and it's casting angle (radians)
  Ray(int xPos, int yPos, int defaultRayLength, float angle){
    this.xPos = xPos;
    this.yPos = yPos;
    this.defaultRayLength = defaultRayLength;
    this.rayLength = defaultRayLength;
    this.angle = angle;
  }
  
  public void drawRay(){
    line(xPos, yPos, (xPos + cos(angle)*rayLength), (yPos + sin(angle)*rayLength));
  }
  
  //checks to see at what coordinate the ray will collide with an object and sets the ray length to meet that point.
  private void castRay(ArrayList<Wall> objects){
    this.rayLength = defaultRayLength;
    ArrayList<Integer> distances = new ArrayList<Integer>();
    //sees what objects it collides with
    for(Wall object : objects){
      float theta1 = angle;
      float theta2 = radians(object.getAngle());
      int[] wallPos = object.getPos();
      
      //finds where along the wall the ray collides
      float b = (xPos*sin(theta1) + wallPos[1]*cos(theta1) - yPos*cos(theta1) - wallPos[0]*sin(theta1)) / (cos(theta2)*sin(theta1) - sin(theta2)*cos(theta1));
      
      //if the place along the wall is further away than the wall extends, then it didn't collide
      if(b < object.getLength() && b > 0){
        //finds the length of the ray needed to collide with the wall
        float a = (b*sin(theta2) + wallPos[1]-yPos) / sin(theta1);
        //add that length to a list
        if(a > 0){
          distances.add((int)abs(a));
        }
       
      }
    }
    //finds the shortest distance and sets the length of the ray to that distance
    if(distances.size() > 0){
      for(Integer distance : distances){
        if(distance < rayLength){
          rayLength = distance;
        }
      }
    }
    else this.rayLength = defaultRayLength;
  }
  
  public int[] getPos(){ return new int[] {xPos, yPos};}
  
  public int getRayLength(){return this.rayLength;}
  
  public float getAngle(){return this.angle;}
  
  public boolean hasCollided(){
    if(this.defaultRayLength != this.rayLength){return true;}
    else{return false;}
  }
  
  public int[] getPoint(){
    if(this.rayLength != this.defaultRayLength){
      int x = rayLength * (int)cos(this.angle);
      int y = rayLength * (int)sin(this.angle);
      return new int[] {x, y};
    }
    else{
      return new int[] {};
    }
  }
  
  public void setPos(int x, int y){
    this.xPos = x;
    this.yPos = y;
  }
  
  public void setRayLength(int rayLength){this.rayLength = rayLength;}
  
  public void setDefaultRayLength(int defaultRayLength){this.defaultRayLength = defaultRayLength;}
  
  public void setAngle(float angle){this.angle = angle;}
  
}
