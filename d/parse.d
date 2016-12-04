import std.stdio;
import std.array;
import std.algorithm;
import std.math;
import std.conv;

class LL {
private:
  int[string] alphabet;
  int[][][] rules; // I'm 11. What's this?
  bool[int][] firsts;
  int[][] table;
public:
  void new_t(string[] ts ...) {
    foreach(s; ts) alphabet[s] = -to!int(alphabet.length) - 1;
    firsts.length = alphabet.length;
  }
  void new_nt(string[] nts ...) {
    foreach(s; nts) alphabet[s] = to!int(alphabet.length) + 1;
    rules.length = firsts.length = alphabet.length;
  }
  void new_rule(string l, string[] rs) {
    foreach(r; rs) {
      int[] one;
      foreach(tok; split(r)) one ~= alphabet[tok];
      rules[alphabet[l] - 1] ~= one;
    }
  }
  void calc_first() {
    for(bool keep = true; keep;) {
      keep = false;
      foreach(k0, v0; alphabet)
        if(v0 > 0) {
          foreach(r; filter!(s => s.length > 0)(rules[v0 - 1]))
            if(r.front < 0) {
              keep |= (r.front in firsts[v0 - 1]) is null;
              firsts[v0 - 1][r.front] = true;
            } else foreach(k1, v1; firsts[r.front - 1]) {
                keep |= (k1 in firsts[v0 - 1]) is null;
                firsts[v0 - 1][k1] = v1;
              }
        } else {
          firsts[-v0 - 1][v0] = true;
        }
    }
  }
  void calc_table() {
    table.length = rules.length;
    foreach(i, sym; rules) {
      table[i].length = alphabet.length;
      foreach(int j, r; sym)
        foreach(k, v; firsts[abs(r.front) - 1])
          table[i][abs(k) - 1] = j + 1;
    }
  }
  void parse(string sentence) {
    int[] current = [alphabet["Session"]];
    int i = alphabet["Session"];
    foreach(c; sentence) {
      current = rules[i][table[i][abs(alphabet[[c]]) - 1] - 1] ~ current[1 .. $];
      while(current.front < 0) current = current[1 .. $];
      i = current.front;
      writeln(current);
    }
  }
}

void main() {
  auto g = new LL;
  g.new_t("!", "?", "(", ")", "s");
  g.new_nt("Session", "Fact", "Question");
  g.new_rule("Session", ["Fact Session", "Question", "( Session ) Session"]);
  g.new_rule("Fact", ["! s"]);
  g.new_rule("Question", ["? s"]);
  g.calc_first();
  g.calc_table();
  g.parse("(!s)?s");
}
