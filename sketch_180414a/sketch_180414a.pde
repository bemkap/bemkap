import java.util.Map;
JSONArray M;
HashMap<Integer,HashMap<Integer,Float>> R=new HashMap();
void setup(){
  size(500,500);
  noLoop();
  M=loadJSONArray("ratings.json");
  for(int i=0; i<M.size(); i++){
    JSONObject o=M.getJSONObject(i);
    if(!R.containsKey(o.getInt("userId"))) R.put(o.getInt("userId"),new HashMap());
    R.get(o.getInt("userId")).put(o.getInt("movieId"),o.getFloat("rating"));
  }
  print("Done!");
}
float distance(int i,int j){
  float y=0;
  HashMap<Integer,Float> r1=R.get(i),r2=R.get(j);
  for(int m:r1.keySet()) if(r2.containsKey(m)) y+=pow(r1.get(m)-r2.get(m),2);
  return sqrt(y);
}
void draw(){
  background(255);
  for(int u1:R.keySet()) for(int u2:R.keySet()) point(map(u1,0,671,0,width),map(distance(u1,u2),0,100,height,0));
}