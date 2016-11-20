import std.stdio;

import g_state;
import g_random;

import std.string;

static State state;

void main(string[] args) {
  //state  = new State(r"D:\YandexDisk\_s\mp3DirectCut");
  state  = new State(r"~/../space/__track_pak");
  //state  = new State(std.file.tempDir());
  //writeln(Rand.getRandName(state).to!dstring[12]);
  writeln(Rand.deform(Rand.getRandName(state)));

  
  //writeln(cast(char)(91));
  //writeln(cast(int)('a')); // a - 97
  //int i = 100;
  //while (i --> 0) {
  //  writeln(Rand.getRandFile(state));
  //}
  //void f0() {Rand.getRandFile(state);}

  //auto r = std.datetime.benchmark
  //  !(
  //     {Rand.getRandName_v0(state);}
  //    ,{Rand.getRandName_v1(state);})
  //  (10_000);

  
  //writeln(r);
}
