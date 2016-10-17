(ns downloadRandImage
  (:gen-class)
  (:require [clojure.java.io :as io]))

(def url "http://alpha.wallhaven.cc/random")
(def userAgent "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1")
(def img-r-ex #"<img [^>]*? src=\".*?th-(\d+\..{3})\"[^>]*?>")
(def image-link-prefix "http://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-")

(defn getWwwInputStream [url]
  (-> (java.net.URL. url)
      .openConnection
      (doto (.setRequestProperty "User-Agent"
        userAgent))
      .getInputStream))

(defn fetch-to-file [url file]
  (with-open [in  (io/input-stream url)
              out (io/output-stream file)]
    (io/copy in out)))

(defn -main [& args]
  (let [html    (-> url getWwwInputStream slurp)
        matcher (re-matcher img-r-ex html)
        imgName ((re-find matcher) 1)
        imgUrl  (str image-link-prefix imgName)]
          (fetch-to-file (getWwwInputStream imgUrl) imgName)))
