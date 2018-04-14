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
  print("Done!\n");
}
float euclidean(int i,int j){
  float y=0;
  HashMap<Integer,Float> r1=R.get(i),r2=R.get(j);
  for(int m:r1.keySet()) if(r2.containsKey(m)) y+=pow(r1.get(m)-r2.get(m),2);
  return 1/sqrt(y);
}
HashMap<Integer,Float> nearest(int i){
  HashMap<Integer,Float>N=new HashMap();
  for(int u2:R.keySet()) 
    if(u2!=i) N.put(u2,euclidean(i,u2));
  return N;
}
