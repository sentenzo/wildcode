import std.stdio;

import g_random;
import g_task;

import std.string;

void main(string[] args) {
    string rootDir = r"D:\__track_pak";
    //string rootDir = r"~/../space/__track_pak";

    Rand.collectRandNames(rootDir);
    
    Task.rmAllEmptyDirs(rootDir);
    //Task.mkRandEmptyDirs(rootDir);

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
