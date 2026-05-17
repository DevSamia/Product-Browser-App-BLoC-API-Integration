// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Message _$MessageFromJson(Map<String, dynamic> json) => _Message(
  id: json['id'] as String,
  productId: json['productId'] as String,
  senderUsername: json['senderUsername'] as String,
  text: json['text'] as String,
  createdAt: _dateTimeFromJson(json['createdAt']),
);

Map<String, dynamic> _$MessageToJson(_Message instance) => <String, dynamic>{
  'id': instance.id,
  'productId': instance.productId,
  'senderUsername': instance.senderUsername,
  'text': instance.text,
  'createdAt': _dateTimeToJson(instance.createdAt),
};
