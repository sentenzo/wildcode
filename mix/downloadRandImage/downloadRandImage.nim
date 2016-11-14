# nim c -d:ssl --opt:size --app:gui Program.nim

import httpclient, nre
from strutils import parseInt 
from os import getAppFilename, splitFile, sleep

const
  downloadUrlTemplate = "https://wallpapers.wallhaven.cc/wallpapers/full/wallhaven-"
  userAgent = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:49.0) Gecko/20100101 Firefox/49.0"
  randUrl = "https://alpha.wallhaven.cc/random"
  rexString = """<img [^>]*? src=\".*?th-(\d+\..{3})\"[^>]*?>"""

proc getDownloadName():string =
  let body = getContent(url = randUrl, userAgent = userAgent)
  return body.find(re(rexString)).get.captures[0]

proc getImgCount(): int =
  let execName = splitFile(getAppFilename()).name
  let rx_num = execName.find(re"\d+")
  if rx_num.isSome():
    return parseInt(rx_num.get().match)
  return 3

proc downloadImage(): void =
  let outputFilename = getDownloadName()
  downloadFile(
    url = downloadUrlTemplate & outputFilename,
    outputFilename = outputFilename,
    userAgent = userAgent)

proc tryDownloadImage(times = 3): void =
  try:
   downloadImage()
  except:
    if times > 1:
      sleep(500)
      tryDownloadImage(times - 1)

var n = getImgCount()
while n > 0:
  tryDownloadImage()
  dec(n)
