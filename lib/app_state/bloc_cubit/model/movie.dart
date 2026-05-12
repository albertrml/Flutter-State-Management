import 'package:flutter_state_management/app_state/bloc_cubit/model/classification.dart';

class Movie {
  String name;
  Classification classification;
  String duration;
  String sinopse;
  String genre;
  String? imageURI;
  List<String>? sessions;
  Movie({
    required this.name,
    required this.classification,
    required this.duration,
    required this.sinopse,
    required this.genre,
    required this.imageURI,
    required this.sessions,
  });

  Movie.fromJson(Map<String, dynamic> json)
    : name = json['name'].toString(),
      classification = Classification.values.firstWhere(
        (element) => element.classification == json['classification'],
      ),
      duration = json['duration'].toString(),
      sinopse = json['sinopse'].toString(),
      genre = json['genre'].toString(),
      imageURI = json['imageURI'].toString() {
    if (json['sessions'] != null) {
      final v = json['sessions'];
      final temp = <String>[];
      v.forEach((v) {
        temp.add(v.toString());
      });
      sessions = temp;
    }
  }
}
