import httpclient, streams
import htmlparser, xmltree
import db_mysql

proc loadHtml(url: string): StringStream =
  return newHttpClient().getContent(url).newStringStream

proc selectImg(html: XmlNode): seq[string] =
  var imgs: seq[string]
  for img in html.findAll("img"):
    imgs.add(img.attr("src"))
  return imgs

proc insertImg(imgs: seq[string]): void =
  let db = open("localhost", "root", "password", "animal")
  for img in imgs:
    db.exec(sql"INSERT INTO cat VALUES (?)", img)
  db.close()

const API = "https://www.google.com/search?tbm=isch&q=A"
let imgs = API.loadHtml.parseHtml.selectImg
imgs.insertImg
