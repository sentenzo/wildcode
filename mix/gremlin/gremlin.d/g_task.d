module g_task;

import std.file;
import std.path;
import std.random;

import g_action;
import g_random;
import conf;

class Task {
    //private State _state;
    //public this(State state) {
    //    _state = state;
    //}
    
    // chainPath(dir, Rand.getRandDeformedName()).array - geves an error
    // so, I made...
    private static string sumPath(string path0, string path1) {
        return std.array.array(
            chainPath(path0, path1)
        );
    }
    
    public static int rmAllEmptyDirs (string rootDir) {
        //string rootDir = _state.rootDir;
        rootDir = rootDir.expandTilde.absolutePath;
        int ret = 0;
        foreach(string node; dirEntries(rootDir, SpanMode.shallow, false)) {
            ret += 1;
            if (node.isDir) {
                int sch = rmAllEmptyDirs(node);
                if(sch == 0) {
                    Action a = Action.rmDir(node);
                    a.run();
                    ret -= 1;
                }
            }
        }
        return ret;
    }
    
    public static void mkRandEmptyDirs (string rootDir) {
        double p0 = conf.p_mk_empty_dir_here;
        double p1 = conf.p_mk_empty_dir_rec;
        if(dice(p0, 1-p0) == 0) {
            mkRandEmptyDirBranch(rootDir);
        }
        foreach(string node; dirEntries(rootDir, SpanMode.shallow, false)) {
            if (node.isDir) {
                if(dice(p1, 1 - p1) == 0) {
                    mkRandEmptyDirs(node);
                }
            }
        }
    }
    
    private static void mkRandEmptyDirBranch (string dir) {
        Action a = Action.mkDir(sumPath(dir, Rand.getRandDeformedName()));
        a.run();
    }
    
    public static void renameRandFiles (string rootDir) {
        double p = conf.p_rename_file;
        foreach(string node; dirEntries(rootDir, SpanMode.breadth, false)) {
            if (node.isFile) {
                if(dice(p, 1-p) == 0) {
                    renameFile(node);
                }
            }
        }
    }
    private static void renameFile(string file) {
        string dir = file.dirName;
        string newName = Rand.getRandDeformedName();
        //std.stdio.writefln("%s\t%s", dir, newName); return;
        while (sumPath(dir, newName).exists) {
            newName = Rand.getRandDeformedName();
        }
        
        Action a = Action.mv(file, sumPath(dir, newName));
        a.run();
    }
}