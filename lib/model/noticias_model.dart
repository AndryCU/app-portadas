class Noticias {
  String _title;
  String _subtitle;
  String _url;
  String _url_image;
  String _content;
  int _favorite;
  int _portada;
  int _destacada;

  Noticias(
      this._title,
      this._subtitle,
      this._url,
      this._url_image,
      this._content,
      this._favorite,
      this._portada,
      this._destacada);


  int get destacada => _destacada;

  set destacada(int value) {
    _destacada = value;
  }

  int get favorite => _favorite;

  set favorite(int value) {
    _favorite = value;
  }

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get subtitle => _subtitle;

  set subtitle(String value) {
    _subtitle = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get title => _title;

  set title(String value) {
    _title = value;
  }

  String get url_image => _url_image;

  set url_image(String value) {
    _url_image = value;
  }


  int get portada => _portada;

  set portada(int value) {
    _portada = value;
  }

  Map<String,dynamic> toJson()=>{
    'title':title,
    'subtitle':subtitle,
    'url':url,
    'url_image':url_image,
    'content':content,
    'favorite':favorite,
    'portada': portada,
    'destacada':destacada
  };


  static List<Noticias> fromJson(List<Map<String,dynamic>> map){
    List<Noticias> favoritas=[];
    for(var mapa_noticia in map){
      String title=mapa_noticia['title'];
      String subtitle=mapa_noticia['subtitle'];
      String url=mapa_noticia['url'];
      String url_image=mapa_noticia['url_image'];
      String content=mapa_noticia['content'];
      int favorite=(mapa_noticia['favorite']);
      int portada=mapa_noticia['portada'];
      int destacada=mapa_noticia['destacada'];
      favoritas.add(Noticias(title, subtitle, url, url_image, content,favorite,portada,destacada));
    }
    return favoritas;
  }

}