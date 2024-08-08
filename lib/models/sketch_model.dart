import 'package:cloud_firestore/cloud_firestore.dart';

class SketchModel {
  String? name;
  List<dynamic>? data;
  Timestamp? timestamp;

  SketchModel({
    this.data,
    this.name,
    this.timestamp
});
  factory SketchModel.fromJson(Map<String, dynamic> json){
    return SketchModel(
      name: json['name'],
      data: json['data'],
      timestamp: json['timestamp']
    );
  }
}