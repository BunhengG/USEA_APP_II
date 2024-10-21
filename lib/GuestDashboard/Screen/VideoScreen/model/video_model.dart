import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VDO_Class {
  final String youtube_thumbnail;
  final String title;
  final String caption;
  final String link;

  VDO_Class({
    required this.youtube_thumbnail,
    required this.title,
    required this.caption,
    required this.link,
  });

  factory VDO_Class.fromJson(Map<String, dynamic> json) =>
      _$VDO_ClassFromJson(json);
  Map<String, dynamic> toJson() => _$VDO_ClassToJson(this);
}
