public class AI{
  int[] goal;
  float minDistance;
  int moveDistance;
  
  AI(int[] targetPosition, float minDistanceFromObstacle, int moveDistance){
    this.goal = targetPosition;
    this.minDistance = minDistanceFromObstacle;
    //move distance is the distance the ai moves each turn.
    this.moveDistance = moveDistance;
  }
  
  void decide(int[] carPos, float carAngle, ArrayList<int[]> points){
    float angleDif = carAngle-atan((goal[1]-carPos[1])/(goal[0]-carPos[0]));
    float angleChange = 0;
    if(angleDif > 0){
      
    }
  }
  
  //find the distance between (a,b) and (x,y).
  private float getDistance(int a, int b, int x, int y){
    return sqrt((float)(a-x)*(a-x)+(b-y)*(b-y));
  }
}
