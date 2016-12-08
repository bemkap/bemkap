import std.stdio;
import std.array;
import std.algorithm;

class CFG {
private:
  int[string] alphabet;
  int empty, sep; // Between non-terminals and terminals. Why?
  int[][][] rules; // I'm 11. What's this?
  bool[int][] firsts, follows;
  int[][] table;
  void FIRST() {
    bool keep;
    firsts.length = alphabet.length;
    do {
      keep = false;
      foreach(k0, v0; alphabet)
        if(v0 < sep) {
          foreach(r; rules[v0]) {
	    foreach(tok; r) {
	      foreach(k1, v1; firsts[tok]) {
	  	keep |= !(k1 in firsts[v0]);
	  	firsts[v0][k1] = k1 != empty || r.length < 2;
	      }
	      if(!(empty in firsts[tok])) break;
	    }
	  }
	} else {
          firsts[v0][v0] = true;
        }
    } while(keep);
  }
  void FOLLOW() {
    bool keep;
    follows.length = sep;
    do {
      keep = false;
      foreach(k0, v0; alphabet)
	if(v0 < sep)
	  foreach(r; filter!((r){ return r.length >= 2; })(rules[v0]))
	    for(int i = r.length - 2; i >= 0; --i)
	      if(r[i] < sep) {
		foreach(k1, v1; firsts[r[i + 1]]) {
		  keep |= !(k1 in follows[r[i]]) || follows[r[i]][k1] < v1;
		  follows[r[i]][k1] = v1;
		}
		if(empty in firsts[r[i]] && firsts[r[i + 1]][empty])
		  foreach(k1, v1; follows[r[i]]) {
		    keep |= !(k1 in follows[r[i]]) || follows[r[i]][k1] < v1;
		    follows[r[i]][k1] = v1;
		  }
	      }
    } while(keep);
  }
  void TABLE() {
    table.length = rules.length; // n non-terminals
    foreach(i, nt; rules) {
      table[i].length = alphabet.length - rules.length; // n terminals
      foreach(int j, r; nt)
        foreach(k, v; firsts[r.front - 1])
          table[i][k - 1 - sep] = j + 1;
    }
  }
public:
  this(string[][string] R, string S) {
    foreach(nt; R.keys)
      alphabet[nt] = alphabet.length + 1;
    sep = rules.length = alphabet.length + 1;
    foreach(nt, rs; R)
      foreach(r; rs) {
	int[] r_id;
	foreach(tok; split(r)) {
	  if(!(tok in alphabet)) alphabet[tok] = alphabet.length + 1;
	  r_id ~= alphabet[tok];
	}
	rules[alphabet[nt]] ~= r_id;
      }
    alphabet[S ~ "_start"] = 0;
    rules[0] ~= [alphabet[S], alphabet.length];
    alphabet["#"] = alphabet.length;
    int* p = "ç" in alphabet;
    empty = p ? *p : -1;
    FIRST();
    FOLLOW();
    writeln(rules);
    writeln(alphabet);
    writeln(firsts);
    writeln(follows);
    //TABLE();
  }
  bool parse(string sentence) {
    int[] current = [1];
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
  auto g = new CFG(["Session": ["Facts Question", "( Session ) Session"],
		    "Facts": ["Fact Facts", "ç"],
		    "Fact": ["! s"],
		    "Question": ["? s"]], "Session");
  //writeln(g.parse("(!s)?s"));
}
