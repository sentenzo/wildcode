module g_random;

import std.random;
import std.path:baseName;
import std.conv:to;

import g_state;
import g_config;

class Rand {
  private static Random gen;
  static this() {
    gen 
      //= Random(100);
      = Random(unpredictableSeed);
  }
  
  private static T getRandArrEl(T)(T[] arr) {
    auto len = arr.length;
    auto choise = uniform(0, len, gen);
    return arr[choise];
  }

  private static dstring charSet 
    = "()-_"
    ~"0123456789"
    ~ "abcdefghijklmnopqrstuvwxyz"
    ~ "ABCDIFGHIJKLMNOPQRSTUVWXYZ"
    ;
  private static dchar deformDChar(dchar ch) {
    return getRandArrEl(charSet);
  }
  /***********************************
   * Makes random mutations in given string.
   *  Replaces some chars in string with others from 
   *  the special set. Does not changes the length of
   *  the string.
   * Params:
   *	name =	the name to be deformed
   * Returns: deformed name
   */
  public static string deform(string name) {
    dchar[] d_name = name.to!(dchar[]);
    auto len = d_name.length;
    for (int i=0; i<= uniform(0, len/4+1, gen); i+=1) {
      auto choise = uniform(0, len, gen);
      d_name[choise] = deformDChar(d_name[choise]);
    }
    return d_name.to!string;
  }

  public static string getRandName(State state) {
    auto len = state.files.length + state.dirs.length;
    auto choise = uniform(0, len, gen);
    if (choise < state.files.length) {
      return state.files[choise].baseName;
    } else {
      return state.dirs[choise - state.files.length].baseName;
    }
  }
  public static string getRandFile(State state) {
    return getRandArrEl(state.files);
  }
  public static string getRandDir(State state) {
    return getRandArrEl(state.dirs);
  }
}