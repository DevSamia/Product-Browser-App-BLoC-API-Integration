import 'package:json_annotation/json_annotation.dart';

part 'message_model.g.dart';

@JsonSerializable()
class MessageModel {
  final String id;
  final String text;
  @JsonKey(name: 'sender_id')
  final String senderId;
  final DateTime timestamp;

  MessageModel({
    required this.id,
    required this.text,
    required this.senderId,
    required this.timestamp,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
  Map<String, dynamic> toJson() => _$MessageModelToJson(this);
}
