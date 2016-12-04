import std.stdio;
import std.array;
import std.algorithm;
import std.math;

class LL {
private:
  int[string] alphabet;
  int t = 1, nt = 1;
  int[][][] rules; // I'm 11. What's this?
  bool[int][] firsts;
public:
  void calc_first() {
    bool end;
    while(!end) {
      end = false;
      foreach(i, sym; rules)
	foreach(r; filter!(s => s.length > 0)(sym))
	  if(r.front < 0)
	    firsts[i][r.front] = true;
	  else foreach(k, v; firsts[r.front - 1]) {
	      end ||= (firsts[i][k] != v);
	      firsts[i][k] = v;
	    }
    }
  }
  void new_t(string[] ts ...) {
    foreach(s; ts) alphabet[s] = -t++;
  }
  void new_nt(string[] nts ...) {
    foreach(s; nts) alphabet[s] = nt++;
    rules.length = firsts.length = nt;
  }
  void new_rule(string l, string[] rs) {
    foreach(r; rs) {
      int[] one;
      foreach(tok; split(r)) one ~= alphabet[tok];
      rules[alphabet[l] - 1] ~= one;
    }
  }
}

void main() {
  auto g = new LL;
  g.new_nt("Session", "Fact", "Question");
  g.new_t("!", "?", "(", ")", "s");
  writeln(g.alphabet);
  g.new_rule("Session", ["Fact Session", "Question", "( Session ) Session"]);
  g.new_rule("Fact", ["! s"]);
  g.new_rule("Question", ["? s"]);
  g.calc_first();
  writeln(g.firsts);
}
