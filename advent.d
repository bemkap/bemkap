import std.stdio;
import std.regex;
import std.algorithm;
import std.conv;
struct bot {
  int v[2];int o[2];
  int rl,rh;
  void put(int n){if(o[1]==0) o[1]=n;else if(o[0]==0) o[0]=n;}
  void prepare(){v[0]=min(o[0],o[1]));v[1]=max(o[0],o[1]);}
  bool ready(){return v[0]!=0&&v[1]!=0;}
}
void main(){
  bot bot[230];
  auto r_v=regex(`value (\d+) goes to bot (\d+)`);
  auto r_b=regex(`bot (\d+) gives low to (bot|output) (\d+) and high to (bot|output) (\d+)`);
  foreach(line;stdin.byLine)
    if(auto m=matchAll(line,r_v))bot[to!(int)(m.front[2])].put(to!(int)(m.front[1]));
    else if(auto m=matchAll(line,r_b)){
      bot[to!(int)(m.front[1])].rl=to!(int)(m.front[3])+(m.front[2]=="output"?210:0);
      bot[to!(int)(m.front[1])].rh=to!(int)(m.front[5])+(m.front[4]=="output"?210:0);
    }
  for(auto i=0;i<210;++i)bot[i].prepare();
  while(1){
    for(auto i=0;i<210;++i)
      if(bot[i].ready()){
  	bot[bot[i].rl].put(bot[i].v[0]);
  	bot[bot[i].rh].put(bot[i].v[1]);
  	bot[i].v[0]=bot[i].v[1]=0;
	bot[i].o[0]=bot[i].o[1]=0;
      }
    for(auto i=0;i<210;++i)bot[i].prepare();
    for(auto i=0;i<210;++i)if(bot[i].v==[17,61]){
  	writeln(i,' ',bot[i].v);
  	writeln(bot[210].o);
  	writeln(bot[211].o);
  	writeln(bot[212].o);
  	return;
      }
  }  
}
