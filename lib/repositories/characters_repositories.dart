import 'dart:convert';
import 'package:convert/convert.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hero_app/constants_api/constants_api.dart';
import 'package:hero_app/model/characters_model.dart';

import 'package:crypto/crypto.dart' as crypto;

class CharactersRepository {
  Future<CharactersModel> getCharacters(int offset) async {
    var dio = Dio();
    var timestamp = DateTime.now().microsecondsSinceEpoch.toString();
    var publickey = ConstantsApi.MARVELPUBLICKEY;
    var privatekey = ConstantsApi.MARVELAPIKEY;
    var hash = _generateMd5(timestamp + privatekey + publickey);
    var query = "offset=$offset&ts=$timestamp&apikey=$publickey&hash=$hash";
    var result =
        await dio.get("http://gateway.marvel.com/v1/public/characters?$query");
    var charactersModel = CharactersModel.fromJson(result.data);
    return charactersModel;
  }

  _generateMd5(String data) {
    var dio = Dio();
    var content = new Utf8Encoder().convert(data);
    var md5 = crypto.md5;
    var digest = md5.convert(content);
    return hex.encode(digest.bytes);
  }
}
