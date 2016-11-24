module g_task;

import std.file;
import std.path;
import std.random;

import g_action;
import g_random;
import conf;

class Task {
    
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
        rootDir = rootDir.expandTilde.absolutePath;
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
        Action a = Action.mkDir(buildPath(dir, Rand.getRandDeformedName()));
        a.run();
    }
    
    public static void renameRandFiles (string rootDir) {
        double p = conf.p_rename_file;
        foreach(string node; dirEntries(rootDir, SpanMode.depth, false)) {
            if (node.isFile) {
                if(dice(p, 1-p) == 0) {
                    renameFile(node);
                }
            }
        }
    }
    public static string renameFile(string file) {
        string dir = file.dirName;
        string ext;
        if(conf.spoil_extensions) {
            ext = "";
        } else {
            ext = file.extension;
        }
        string newName = Rand.getRandDeformedName(ext);
        //std.stdio.writefln("%s\t%s", dir, newName); return;
        while (buildPath(dir, newName).exists) {
            newName = Rand.getRandDeformedName(ext);
        }
        
        Action a = Action.mv(file, buildPath(dir, newName));
        a.run();
        
        return newName;
    }
    
    // cpmv == cp & mv
    public static void cpmvRandFiles (string rootDir) {
        rootDir = rootDir.expandTilde.absolutePath;
        string[] dirs = [rootDir];
        foreach(string node; dirEntries(rootDir, SpanMode.depth, false)) {
            if (node.isDir) {
                //std.stdio.writeln(node);
                dirs ~= node;
            }
        }
        if(dirs.length == 1) { return; }
        foreach(string node; dirEntries(rootDir, SpanMode.depth, false)) {
            if (node.isFile) {
        //std.stdio.writeln(")))");
                cpmvRandFiles(node, dirs);
            }
        }
    }
    private static void cpmvRandFiles(string file, string[] dirs) {
        double p_mv = conf.p_move_file;
        double p_cp = conf.p_copy_file;
        
        auto d = dice(p_mv, p_cp, 1 - p_mv - p_cp);
        if(d == 2) { return; }
        
        string dir = file.dirName;
        string name = file.baseName;
        string newDir = Rand.getRandArrEl(dirs);
        while (newDir == dir) {
            newDir = Rand.getRandArrEl(dirs);
        }
        Action a;
        if(d == 0) {
            a = Action.mv(file, buildPath(newDir, name));
        } else if (d == 1) {
            a = Action.copy(file, buildPath(newDir, name));
        }
        //std.stdio.writefln("%s\t%s", file, newDir);
        a.run();
    }
}