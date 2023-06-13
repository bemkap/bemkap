#include<iostream>
#include<vector>
#include<set>
using namespace std;
bool diff(string a,string b,int i){
  int n=0;
  if(a.size()!=b.size()||a[i]==b[i])return false;
  for(int j=0;j<a.size()&&n<=1;j++)n+=a[j]!=b[j];
  return n==1;
}
void findLadders(string beginWord,string endWord,vector<string>&wordList){
  vector<vector<vector<int>>>M(beginWord.size(),vector<vector<int>>(wordList.size()+1,vector<int>()));
  for(int i=0;i<wordList.size();i++)
    for(int p=0;p<beginWord.size();p++){
      if(diff(beginWord,wordList[i],p))M[p][0].push_back(i+1);
    }
  for(int i=0;i<wordList.size();i++)
    for(int j=i+1;j<wordList.size();j++)
      for(int p=0;p<beginWord.size();p++)
        if(diff(wordList[i],wordList[j],p)){
          M[p][i+1].push_back(j+1);
          M[p][j+1].push_back(i+1);
        }
  vector<vector<int>>R({{0},{0},{0}});
  vector<bool>B({false,false,false});
  bool end;
  while(true){
    for(int p=0;p<beginWord.size();p++){
      vector<int>T=R[p];
      if(!B[p]){
	for(int t:T){
	  for(int s:M[p][t]){
	    R[p].push_back(s);
	    B[p]=B[p]||wordList[s-1][p]==endWord[p];
	  }
	  R[p].erase(R[p].begin());
	}	
      }
    }
    end=true;
    for(bool b:B)end=end&&b;
    if(end)break;
  }
}
int main(){
  vector<string>WL({"hot","dot","dog","lot","log","cog"});
  findLadders("hit","cog",WL);
  return 0;
}
