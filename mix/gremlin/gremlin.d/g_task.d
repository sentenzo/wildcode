module g_task;

import std.file;
import std.path;
import std.random;

import g_action;
import g_state;
import g_random;

class Task {
    private State _state;
    public this(State state) {
        _state = state;
    }
    public int rmAllEmptyDirs (string rootDir) {
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
    
    public void mkRandEmptyDirs (string rootDir) {
        double p0 = 0.7;
        double p1 = 0.6;
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
    
    private void mkRandEmptyDirBranch (string dir) {
        Action a = Action.mkDir( std.array.array(
            chainPath(dir, 
                        Rand.deform(
                            Rand.getRandName(_state)))));
        a.run();
    }
}