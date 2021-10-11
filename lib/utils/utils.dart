import 'package:flutter/material.dart';

ImageProvider getPicture(String url){

  if (url.contains('http')){
    return NetworkImage(url);
  }
  else if(url.contains('assets')){
    return AssetImage(url);
  }else{
      return AssetImage(url);
  }
}
