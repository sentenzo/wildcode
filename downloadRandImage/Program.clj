(ns downloadRandImage
 (:require [clojure.java.io :as io]))

(def url "http://alpha.wallhaven.cc/random")
(def userAgent "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1")

(defn getWwwInputStream [url] 
  (-> (java.net.URL. url)    
      .openConnection    
      (doto (.setRequestProperty "User-Agent"
                               userAgent))
      .getInputStream))

(def html (-> url getWwwInputStream slurp))

(def *matcher* (re-matcher #"<img [^>]*? src=\".*?th-(\d+\..{3})\"[^>]*?>" html))

(def imgName ((re-find *matcher*) 1))

(def imgUrl (str "http://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-" imgName))

(defn fetch-to-file [url file]
                (with-open [in (io/input-stream url) 
                            out (io/output-stream file)]
                  (io/copy in out)))

(fetch-to-file (getInputStream imgUrl) imgName)