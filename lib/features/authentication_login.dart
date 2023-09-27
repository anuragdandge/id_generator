import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:id_generator/constants.dart';
import 'package:id_generator/features/generate_qr_code.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io' show Platform;

import 'package:shared_preferences/shared_preferences.dart';

class MongoDatabase {
  static var db, credsCollection;
  // static var credentialCollection = "credentials";
  static connect() async {
    db = await Db.create(MONGO_URL);
    await db.open();
    inspect(db);
    credsCollection = db.collection(CRED_COLLECTION);
  }

  void checkCreds(String u, String p) async {
    final user = await credsCollection
        .find(where.eq('phonenumber', u).eq('password', p));
    if (await user.isEmpty) {
      debugPrint("No User Found ");
    } else {
      debugPrint("Success ");
    }
  }
}
