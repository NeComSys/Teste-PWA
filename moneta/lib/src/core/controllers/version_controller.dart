import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

enum VersionState { idle, success, error, loading }

class VersionController with ChangeNotifier {
  String _version = '';
  String _dateUpdated = '';

  String get version => _version;
  String get dateUpdated => _dateUpdated;

  Future<void> loadVersion() async {
    // final String response = await rootBundle.loadString('assets/version.json');
    // final data = json.decode(response);
    // _version = data['version'];
    // _dateUpdated = data['dateUpdated'];
    // notifyListeners();

    try {
      final response = await http.get(Uri.parse('/version.json'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _version = data['version'];
        _dateUpdated = data['dateUpdated'];
        notifyListeners();
      } else {
        throw Exception('Failed to load version');
      }
    } catch (e) {
      print('Error fetching version: $e');
      // Manejar erro conforme necessário
    }
  }
}
