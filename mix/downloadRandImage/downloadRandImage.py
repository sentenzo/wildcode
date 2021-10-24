from abc import ABC, abstractmethod
from typing import List
import urllib.request


USER_AGENT = "Mozilla/5.0 (X11; U; Linux i686) Gecko/20071127 Firefox/2.0.0.11"


class RandImgSource(ABC):
    @abstractmethod
    def _get_rand_imgs_link_list(self) -> List[str]: pass

    def grab_img(self) -> None:
        iurls = self._get_rand_imgs_link_list()
        for iurl in iurls:
            try:
                file_name = iurl.split("/")[-1]
                req = RandImgSource._build_request(iurl)
                with urllib.request.urlopen(req) as response, open(file_name, 'wb') as out_file:
                    data = response.read()
                    out_file.write(data)
                    return
            except Exception as ex:
                pass

    @staticmethod
    def _build_request(url):
        req = urllib.request.Request(url)
        req.add_header("User-Agent", USER_AGENT)
        return req

    @staticmethod
    def _get_html_str(url) -> str:
        req = RandImgSource._build_request(url)
        res = urllib.request.urlopen(req)
        bhtml = res.read()
        res.close()
        html = bhtml.decode("utf8")
        return html


class Wallhaven_RIS(RandImgSource):
    url = 'https://wallhaven.cc/random'
    ptrn1 = "https://wallhaven.cc/w/"  # 'https://th.wallhaven.cc/small'
    exts = ["jpg", "png"]

    def __init__(self) -> None:
        super().__init__()

    def _get_rand_imgs_link_list(self) -> List[str]:
        html = Wallhaven_RIS._get_html_str(Wallhaven_RIS.url)
        pos = html.find(Wallhaven_RIS.ptrn1) + len(Wallhaven_RIS.ptrn1)
        base = []
        while html[pos] not in '/"':
            base.append(html[pos])
            pos += 1
        base = "".join(base)

        ans = [
            f"https://w.wallhaven.cc/full/{base[:2]}/wallhaven-{base}.{ext}"
            for ext in Wallhaven_RIS.exts
        ]
        return ans


wris = Wallhaven_RIS()
wris.grab_img()