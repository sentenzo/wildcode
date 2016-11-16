import std.stdio;
import std.file;
import std.path;

class State {
    string[][string] fileTree;
    string[] files;
    string[] dirs;
    
    public this(string rootDir) {
        rootDir = absolutePath(rootDir);
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
    
    private string getRandName() {
        return "some name";
    }
    
    private string deform(string name) {
        return "s0m3_N?Me_001";
    }
    
    private string getRandFile() {
        return "/path/to/file.ext";
    }
    
    private string getRandDir() {
        return "/path/to/dir";
    }
    
    //std.file:
    
    // getcwd
    
    // mkdir
    // rmdir
    // copy
    // rename (Rename file from to to. If the target file exists, it is overwritten.)
    
    
}

static State state;

void main(string[] args) {
    state  = new State(r"D:\YandexDisk\_s\mp3DirectCut");
    
    writeln("Hi!");
}
