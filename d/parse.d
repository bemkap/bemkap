import std.stdio;
import std.array;
import std.algorithm;

class CFG {
private:
  int[string] alphabet;
  int sep; // Between non-terminals and terminals. Why?
  int[][][] rules; // I'm 11. What's this?
  bool[int][] firsts;
  int[][] table;
  void calc_first() {
    bool keep;
    firsts.length = alphabet.length;
    do {
      keep = false;
      foreach(k0, v0; alphabet)
        if(v0 <= sep) {
          foreach(r; filter!(s => s.length > 0)(rules[v0 - 1]))
            if(r.front < 0) {
              keep |= (r.front in firsts[v0 - 1]) is null;
              firsts[v0 - 1][r.front] = true;
            } else foreach(k1, v1; firsts[r.front - 1]) {
                keep |= (k1 in firsts[v0 - 1]) is null;
                firsts[v0 - 1][k1] = v1;
              }
        } else {
          firsts[v0 - 1][v0] = true;
        }
    } while(keep);
  }
  void calc_table() {
    table.length = rules.length; // n non-terminals
    foreach(i, nt; rules) {
      table[i].length = alphabet.length - rules.length; // n terminals
      foreach(int j, r; nt)
        foreach(k, v; firsts[r.front - 1])
          table[i][k - 1 - sep] = j + 1;
    }
  }
public:
  this(string[][string] R) {
    foreach(nt; R.keys)
      alphabet[nt] = alphabet.length + 1;
    sep = rules.length = alphabet.length;
    foreach(nt, rs; R)
      foreach(r; rs) {
	int[] r_id;
	foreach(tok; split(r))
	  if((tok in alphabet) is null) r_id ~= alphabet[tok] = alphabet.length + 1;
	  else r_id ~= alphabet[tok];
	rules[alphabet[nt] - 1] ~= r_id;
      }
    calc_first();
    calc_table();
  }
  bool parse(string sentence) {
    int[] current = [alphabet["Session"]];
    for(auto i = 0; i < sentence.length; ) {
      // What is readability?
      if(table[current.front - 1][alphabet[[sentence[i]]] - 1 - sep] - 1 < 0) return false;      
      current = rules[current.front - 1][table[current.front - 1][alphabet[[sentence[i]]] - 1 - sep] - 1] ~ current[1 .. $];
      while(i < sentence.length && current.front == alphabet[[sentence[i]]]) { write(sentence[i++]); current = current[1 .. $]; }
    }
    return true;
  }
}

void main() {
  auto g = new CFG(["Session": ["Fact Session", "Question", "( Session ) Session"],
		    "Fact": ["! s"],
		    "Question": ["? s"]]);
  writeln(g.parse("(!s)?s"));
}
