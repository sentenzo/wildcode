import std.stdio: writefln, writeln, chunks, File;
import std.file: dirEntries, isFile, SpanMode;
import std.path: baseName;
import std.algorithm: sort;
import std.datetime;

import std.digest.md;
import std.digest.sha;
import std.digest.crc;

// dir : "_Folk" 598 Mib / 71 file
// MD5 14s
// SHA1 9s
// SHA256 35s
// SHA384 50s
// SHA512 49s
// CRC32 9s

// dir: "_music" 12.1 GiB / 2443 files
// CRC32 s


string[][string] state;

void main(string[] args) {
    SysTime t0 = Clock.currTime();
    foreach(string path; args[1..$]) {
        addToState(path);
    }
    writeln((Clock.currTime() - t0).total!"seconds");
    foreach(string[] it
    ; state.values.sort!((x, y)=>x.length>y.length).release) {
        if(it.length > 1) {
            writefln("%d", it.length);
            foreach(string file; it) {
                writefln("\t%s", file);
            }
        }
    }
}

void addToState(string path) {
    foreach(string file; dirEntries(path, SpanMode.breadth, false)) {
        if (file.isFile) {
            string metric = fileToMetric(file);
            state[metric] ~= file;
        }
    }
}

string fileToMetric(string file) {
    //return file.baseName;
    return file.digest;
}

string digest(string file) {
    //SHA1 digest;
    //MD5 digest;
    CRC32 digest;
    digest.start();
    
    foreach (ubyte[] buffer; chunks(File(file)
    //, 512)) {
    , 1024)) {
    //, 2048)) {
    //, 4096)) {
        digest.put(buffer[]);
    }

    return toHexString(digest.finish()).dup;
}