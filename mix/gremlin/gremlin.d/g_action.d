module g_action;

import std.file;
import std.path;

class Action {
  private this() {}

  private void delegate() d_run;
  public void run() { d_run(); }
  
  private void delegate() d_unrun;
  public void unrun() { d_unrun(); }
  
  private Action revert() {
    void delegate() tmp = this.d_run;
    this.d_run = this.d_unrun;
    this.d_unrun = tmp;
    return this;
  }
  
  public static Action rmDir(string dir) {
    Action a = new Action();
    a.d_run   = () => rmdir(dir);
    a.d_unrun = () => mkdir(dir);
    return a;
  }
  public static Action mkDir(string dir) {
    return Action.rmDir(dir).revert();
  }
  
  public static Action copy(string fileFrom, string fileTo) {
    Action a = new Action();
    a.d_run = () => std.file.copy(fileFrom, fileTo);
    a.d_unrun = delegate() {
      if(feq(fileFrom, fileTo)) {
        remove(fileTo);
      } else {
        throw new Exception("fileFrom != fileTo");
      }
    };
    return a;
  }
  public static Action drain(string fileTo, string fileFrom) {
    return Action.copy(fileTo, fileFrom).revert();
  }
  private static bool feq(string file0, string file1) {
    return file0.getSize == file1.getSize;
  }
  
  public static Action mv(string fileFrom, string fileTo) {
    Action a = new Action();
    a.d_run   = () => std.file.rename(fileFrom, fileTo);
    a.d_unrun = () => std.file.rename(fileTo, fileFrom);
    return a;
  }
  
  // mkJunk(file0): creates file of random size with random data inside
  public static Action mkJunk(string file) {
    Action a = new Action();
    a.d_run = delegate() {
      //
    };
    a.d_unrun = delegate() {
      //
    };
    return a;
  }
}