module g_state;

import std.file;
import std.path;

class State {
    public string rootDir;
    string[][string] fileTree;
    string[] files;
    string[] dirs;
    
    public this(string rootDir) {
        this.rootDir = rootDir;
        rootDir = rootDir.expandTilde.absolutePath;
        foreach(string node; dirEntries(rootDir, SpanMode.breadth, false)) {
            if (node.isFile) {
                fileTree[node.dirName] ~= node.baseName;
                files ~= node;
            } else if(node.isDir) {
                fileTree[node] = []; // SpanMode.breadth allows us to do so
                dirs ~= node;
            }
        }
    }
}