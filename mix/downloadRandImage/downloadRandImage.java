package com.sentenzo;


import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.channels.*;
import java.net.*;
import java.util.regex.*;

public class Main {

    static String[] exts = {"jpg", "png", "jpeg"};

    public static void main(String[] args) throws IOException, URISyntaxException {
        String jarName = getJarName();
        int n = getImageCount(jarName);
        while(n-->0) {
            doWork();
        }
        //System.out.println(tryDownloadImage(id, "jpg", id));
    }

    public static void doWork() throws IOException, URISyntaxException {
        String id = getWallheavenRandImageId();
        String randName = id; //Path.GetRandomFileName();
        for(String ext : exts) {
            if (tryDownloadImage (id, ext, randName)) {
                break;
            }
        }
    }

    static Boolean tryDownloadImage(String id, String ext, String name) {
        try {
            URL url = new URL("http://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-"
                    + id + "." + ext);
            URLConnection urlConn = url.openConnection();
            urlConn.addRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)");
            ReadableByteChannel rbc = Channels.newChannel(urlConn.getInputStream());
            FileOutputStream fos = new FileOutputStream(name + "." + ext);
            fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
            return true;
        } catch (Exception ex) {
            return false;
        }
    }

    static String subTag(String html, String tag) {
        int b = html.indexOf ("<" + tag);
        int e = html.indexOf ("</" + tag) + tag.length() + 3;
        return html.substring(b, e);
    }

    static String getWallheavenRandImageId() throws IOException, URISyntaxException {
        String url = "http://alpha.wallhaven.cc/random";
        String html = getPage(url);
        String figure = subTag (html, "figure");
        String a = subTag (figure, "a");
        String href = a.substring (a.indexOf ("http://"));
        href = href.substring (0, href.indexOf ('"'));
        String[] tmp = href.split("/");
        String num = tmp [tmp.length - 1];
        return num;
    }
    public static String getPage(String address) throws IOException,
            URISyntaxException {
        URL url = new URL("http://alpha.wallhaven.cc/random");
        URLConnection urlConn = url.openConnection();
        urlConn.addRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1)");

        InputStream is = urlConn.getInputStream();// url.openStream();
        int ptr = 0;
        StringBuffer buffer = new StringBuffer();
        while ((ptr = is.read()) != -1) {
            buffer.append((char)ptr);
        }
        return buffer.toString();
    }

    static int getImageCount(String exeName) {
        Pattern pattern = Pattern.compile(".*?(\\d*)$");
        Matcher matcher = pattern.matcher(exeName);
        if (matcher.find())
        {
            try {
                return Integer.parseInt(matcher.group(1));
            } catch (NumberFormatException nfe)  {
                return 1;
            }
        }
        else {
            return 1;
        }
    }

    static String getJarName() {
        return new java.io.File(Main.class.getProtectionDomain()
                .getCodeSource()
                .getLocation()
                .getPath())
                .getName();
    }
}