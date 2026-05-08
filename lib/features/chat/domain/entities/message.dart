import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String productId,
    required String senderUsername,
    required String text,
    @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
    required DateTime createdAt,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

DateTime _dateTimeFromJson(dynamic json) {
  if (json is String) {
    return DateTime.parse(json);
  }
  return DateTime.fromMillisecondsSinceEpoch(json as int);
}

dynamic _dateTimeToJson(DateTime dateTime) {
  return dateTime.toIso8601String();
}
