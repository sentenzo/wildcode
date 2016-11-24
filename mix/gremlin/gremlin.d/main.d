import std.stdio;

import g_random;
import g_task;

import std.string;

import std.file;

void main(string[] args) {
    string rootDir;
    
    if(args.length > 1) {
        rootDir = args[1];
        //writeln(rootDir); return;
    } else {
        return;
        //rootDir = r"D:\__track_pak";
        //rootDir = r"~/../space/__track_pak";
    }

    Rand.collectRandNames(rootDir);

    Task.mkRandEmptyDirs(rootDir);
    Task.renameRandFiles(rootDir);
    Task.cpmvRandFiles(rootDir);
    Task.rmAllEmptyDirs(rootDir);

    //void f0() {Rand.getRandFile(state);}

    //auto r = std.datetime.benchmark
    //  !(
    //     {Rand.getRandName_v0(state);}
    //    ,{Rand.getRandName_v1(state);})
    //  (10_000);
    //writeln(r);
}
