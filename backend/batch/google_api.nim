import httpclient
import htmlparser
import xmltree
import streams

proc loadHtml(url: string): StringStream =
  return newHttpClient().getContent(url).newStringStream

proc selectImg(html: XmlNode): seq[string] =
  var imgs: seq[string]
  for img in html.findAll("img"):
    echo img.attr("src")
    imgs.add(img.attr("src"))
  return imgs

const API = "https://www.google.com/search?tbm=isch&q=A"
echo API.loadHtml.parseHtml.selectImg
