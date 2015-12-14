using System;
using System.Net;
using System.Threading;
using System.IO;

class MainClass
{
    //we don't know exactly, what extansion will it be
    static string[] exts = { "jpg", "png", "jpeg"};

    public static void doWork() {
        string id = getWallheavenRandImageId ();
        string randName = id; //Path.GetRandomFileName();
        foreach(string ext in exts) {
            if (tryDownloadImage (id, ext, randName)) {
                break;
            }
        }
    }
    
    static string getWallheavenRandImageId() {
        using (WebClient client = new WebClient ()) {
            string html = client.DownloadString ("http://alpha.wallhaven.cc/random");
            string figure = subTag (html, "figure");
            string a = subTag (figure, "a");
            string href = a.Substring (a.IndexOf ("http://"));
            href = href.Substring (0, href.IndexOf ('"'));
            string[] tmp = href.Split ('/');
            string num = tmp [tmp.Length - 1];
            return num;
        }
    }
    
    static bool tryDownloadImage(string id, string ext, string name) {
        bool ret = false;
        try {
            using (WebClient client = new WebClient ()) {
                client.DownloadFile (
                    "http://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-" 
                    + id + "." + ext, name + "."+ext);
            }
            ret = true;
        } catch {
            ret = false;
        }
        return ret;
    }
    
    static string subTag(string html, string tag) {
        int b = html.IndexOf ("<" + tag);
        int e = html.IndexOf ("</" + tag) + tag.Length + 3;
        return html.Substring (b, e - b);
    }
    
    public static void Main (string[] args)
    {
        Thread th;

        int tries = 3;
        while (tries --> 0) {
            th = new Thread (() => doWork ());
            th.Start ();
            //the program only have 10 sec to do work
            System.Threading.Thread.Sleep(10000);
            if (th.ThreadState == ThreadState.Stopped) {
                // success!
                break;
                //we are done here
            } else {
                // failure
                th.Abort ();
                // let's try again (if we've got any times left)
            }
        }
    }

}