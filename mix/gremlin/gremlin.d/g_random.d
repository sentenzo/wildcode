module g_random;

import std.random;
import std.path;
import std.conv:to;
import std.file;

class Rand {
  private static Random gen;
  private static string[] f_names;
  private static string[] d_names;
  static this() {
    gen 
      //= Random(100);
      = Random(unpredictableSeed);
    f_names = ["file0", "file1", "file2"];
    d_names = ["dir0", "dir1", "dir2"];
  }
  
  private static T getRandArrEl(T)(T[] arr) {
    auto len = arr.length;
    auto choise = uniform(0, len, gen);
    return arr[choise];
  }

  private static dstring charSet 
    = "()-_         "
    ~ "0123456789"
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
  
  public static void collectRandNames(string rootDir) {
    f_names = [];
    d_names = [];
    rootDir = rootDir.expandTilde.absolutePath;
    foreach(string node; dirEntries(rootDir, SpanMode.breadth, false)) {
        if (node.isFile) {
            f_names ~= node.baseName;
        } else if(node.isDir) {
            d_names ~= node.baseName;
        }
    }
  }

  public static string getRandName() {
    auto len = f_names.length + d_names.length;
    auto choise = uniform(0, len, gen);
    if (choise < f_names.length) {
      return f_names[choise];
    } else {
      return d_names[choise - f_names.length];
    }
  }
  public static string getRandFileName() {
    return getRandArrEl(f_names);
  }
  public static string getRandDirName() {
    return getRandArrEl(d_names);
  }
}