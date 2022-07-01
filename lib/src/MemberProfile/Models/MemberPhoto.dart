// @dart=2.9
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'dart:typed_data';

class MemberPhoto {
  int id;
  String member_CardID;
  String member_CardYear_THFormat;
  String image;
  Uint8List bytes;

  MemberPhoto.fromJson(Map<String, dynamic> json) {
    id = json["ID"];
    member_CardID = json["Member_CardID"];
    member_CardYear_THFormat = json["Member_CardYear_THFormat"];
    image = json["Image"];

    bytes = const Base64Decoder().convert(image);
  }
}
