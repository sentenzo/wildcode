// libcurl library must be installed 
//
// dmd -O Program.d
// 
// for Windows you can optionally include def file
// dmd -O Program.d win_app.def
// 
// win_app.def content:
// EXETYPE NT
// SUBSYSTEM WINDOWS


import std.net.curl: get, download;
import std.stdio;
import std.path: baseName, stripExtension;
import std.string;
import std.array: split;
import std.file;
import std.concurrency;
import std.conv:to;

//we don't know exactly, what extansion will it be
immutable string[] exts = [ "jpg", "png", "jpeg"];
immutable string url = "https://alpha.wallhaven.cc/random";

void main(string[] args) {
    int n = getImageCount(args[0].baseName.stripExtension);
    while(n --> 0) {
        spawn(&doWork);
    }
}

string subTag(string html, string tag) {
    int b = html.indexOf ("<" ~ tag);
    int e = html.indexOf ("</" ~ tag) + tag.length + 3;
    return html[b..e];
}

string getWallheavenRandImageId() {
    string html = cast(string)(get(url));
    string figure = subTag (html, "figure");
    string a = subTag (figure, "a");
    string href = a[a.indexOf ("https://")..$];
    href = href[0..href.indexOf ('"')];
    string num = href.split('/')[$-1];
    return num;
}

void doWork() {
    string id = getWallheavenRandImageId ();
    string randName = id; 
    foreach(string ext ; exts) {
        if (tryDownloadImage (id, ext, randName)) {
            break;
        }
        //writeln(randName~"."~ext);
    }
}

bool tryDownloadImage(string id, string ext, string name) {
    bool ret = false;
    try {
        string fname = name ~ "." ~ ext;
        download(
            "https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-" 
            ~ id ~ "." ~ ext, fname);
        if(getSize(fname) < 1024*8) { //excluding "404 Page not found" 
            remove(fname);// O_O why do you think, the file is not blocked now?
            ret = false;
        } else {
            ret = true;
        }
    } catch {
        ret = false;
    }
    return ret;
}

int getImageCount(string exeName) {
    string r = "";
    for (int i = exeName.length - 1; i >= 0; i--) {
        if (exeName [i] <= '9' && exeName [i] >= '0') {
            r = exeName [i] ~ r;
        } else {
            break;
        }
    }
    if (r == "") {
        return 1;
    } else {
        return to!int(r);
    }
}
