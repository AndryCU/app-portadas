

import 'dart:io';

import 'package:flutter/material.dart';

ImageProvider getPicture(String url) {
  if (url.contains('http')) {
    return NetworkImage(url);
  }
  else if(url.contains('asset'))  {
    return AssetImage(url);
  }else{
    File file=File(url);
    return FileImage(file);
  }

}
