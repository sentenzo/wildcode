// alpha.wallhaven.cc use TLSv1.2, so you should 
//  have .Net Framework 4.5 (or higher)
//  to use client.DownloadString

using System;
using System.Net;
using System.Threading;
using System.IO;

class MainClass
{
	//we don't know exactly, what extansion will it be
	static string[] exts = { "jpg", "png", "jpeg"};

	public static void Main (string[] args)
	{
		string exeName = System.IO.Path.GetFileNameWithoutExtension( 
			System.AppDomain.CurrentDomain.FriendlyName); 
		int imageCount = getImageCount (exeName);

		while (imageCount --> 0) {
			(new Thread (() => doWork ()))
				.Start ();
		}
	}



	public static void doWork() {
		string id = getWallheavenRandImageId ();
		string randName = id; //Path.GetRandomFileName();
		foreach(string ext in exts) {
			if (tryDownloadImage (id, ext, randName)) {
				break;
			}
		}
	}
	static string subTag(string html, string tag) {
		int b = html.IndexOf ("<" + tag);
		int e = html.IndexOf ("</" + tag) + tag.Length + 3;
		return html.Substring (b, e - b);
	}
	static string getWallheavenRandImageId() {
		using (WebClient client = new WebClient ()) {
			string html = client.DownloadString ("https://alpha.wallhaven.cc/random");
			string figure = subTag (html, "figure");
			string a = subTag (figure, "a");
			string href = a.Substring (a.IndexOf ("https://"));
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
					"https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-" 
					+ id + "." + ext, name + "."+ext);
			}
			ret = true;
		} catch {
			ret = false;
		}
		return ret;
	}

	static int getImageCount(string exeName) {
		string r = "";
		for (int i = exeName.Length - 1; i >= 0; i--) {
			if (exeName [i] <= '9' && exeName [i] >= '0') {
				r = exeName [i] + r;
			} else {
				break;
			}
		}
		if (r == "") {
			return 1;
		} else {
			return int.Parse (r);
		}
	}
}
