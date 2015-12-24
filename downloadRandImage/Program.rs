extern crate curl;
extern crate regex;

use curl::http;
use regex::Regex;
use std::io::prelude::*;
use std::fs::File;

static URL: &'static str = "http://alpha.wallhaven.cc/random";

static REX: &'static str = r#"<img [^>]*? src=".*?th-(\d+\..{3})"[^>]*?>"#;

fn get_body(url : &str) -> String {
    let resp = http::handle()
        .get(url)
        .exec()
        .unwrap_or_else(|e| {
            panic!("Failed to get {}; error is {}", url, e);
        });
    let body = std::str::from_utf8(resp.get_body()).unwrap_or_else(|e| {
        panic!("Failed to parse response from {}; error is {}", url, e);
    });
    let ret = body.to_string();
    return ret; 
}

fn get_img_name(html : &str) -> String {
    let re = Regex::new(REX).unwrap();
    let cap = re.captures(html).unwrap();
    let mut ret_a = "http://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-".to_string();
    let ret_b = cap.at(1).unwrap_or("");
    let ret = ret_a+ret_b; // :0
    return ret;
}

//fn download_img(url : str) {
//    let mut f = try!(File::create("foo.jpg"));
//}

fn main() {
    let html = get_body(URL);
    let img = get_img_name(&html);
    println!("{}", img); 
}
