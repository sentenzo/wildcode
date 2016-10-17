# nim c -d:ssl --opt:size --app:gui Program.nim

import httpclient, nre

var
  downloadUrlTemplate = "https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-"
  userAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0"
  randUrl = "https://alpha.wallhaven.cc/random"
  rex = re"""<img [^>]*? src=\".*?th-(\d+\..{3})\"[^>]*?>"""

proc getDownloadName():string =
  let body = getContent(url = randUrl, userAgent = userAgent)
  return body.find(rex).get.captures[0]

let outputFilename = getDownloadName()
downloadFile(
  url = downloadUrlTemplate & outputFilename,
  outputFilename = outputFilename,
  userAgent = userAgent)
