import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  String? id;
  String? media;
  String? name;
  Timestamp? time;
  String? mediaType;

  Story({
    this.id,
    this.media,
    this.name,
    this.time,
    this.mediaType,
  });
  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
        id: json['id'],
        media: json['mediaUrl'],
        name: json['name'],
        time: json['time'],
        mediaType: json['media_type']);
  }
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'mediaUrl': media,
      'name': name,
      'time': time,
      'media_type': mediaType,
    };
  }
}
