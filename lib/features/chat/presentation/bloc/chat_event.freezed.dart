// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent()';
}


}

/// @nodoc
class $ChatEventCopyWith<$Res>  {
$ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}


/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( WatchMessagesEvent value)?  watchMessages,TResult Function( SendMessageEvent value)?  sendMessage,TResult Function( MessagesUpdatedEvent value)?  messagesUpdated,required TResult orElse(),}){
final _that = this;
switch (_that) {
case WatchMessagesEvent() when watchMessages != null:
return watchMessages(_that);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that);case MessagesUpdatedEvent() when messagesUpdated != null:
return messagesUpdated(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( WatchMessagesEvent value)  watchMessages,required TResult Function( SendMessageEvent value)  sendMessage,required TResult Function( MessagesUpdatedEvent value)  messagesUpdated,}){
final _that = this;
switch (_that) {
case WatchMessagesEvent():
return watchMessages(_that);case SendMessageEvent():
return sendMessage(_that);case MessagesUpdatedEvent():
return messagesUpdated(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( WatchMessagesEvent value)?  watchMessages,TResult? Function( SendMessageEvent value)?  sendMessage,TResult? Function( MessagesUpdatedEvent value)?  messagesUpdated,}){
final _that = this;
switch (_that) {
case WatchMessagesEvent() when watchMessages != null:
return watchMessages(_that);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that);case MessagesUpdatedEvent() when messagesUpdated != null:
return messagesUpdated(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String productId)?  watchMessages,TResult Function( String text,  String productId)?  sendMessage,TResult Function( List<Message> messages)?  messagesUpdated,required TResult orElse(),}) {final _that = this;
switch (_that) {
case WatchMessagesEvent() when watchMessages != null:
return watchMessages(_that.productId);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that.text,_that.productId);case MessagesUpdatedEvent() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String productId)  watchMessages,required TResult Function( String text,  String productId)  sendMessage,required TResult Function( List<Message> messages)  messagesUpdated,}) {final _that = this;
switch (_that) {
case WatchMessagesEvent():
return watchMessages(_that.productId);case SendMessageEvent():
return sendMessage(_that.text,_that.productId);case MessagesUpdatedEvent():
return messagesUpdated(_that.messages);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String productId)?  watchMessages,TResult? Function( String text,  String productId)?  sendMessage,TResult? Function( List<Message> messages)?  messagesUpdated,}) {final _that = this;
switch (_that) {
case WatchMessagesEvent() when watchMessages != null:
return watchMessages(_that.productId);case SendMessageEvent() when sendMessage != null:
return sendMessage(_that.text,_that.productId);case MessagesUpdatedEvent() when messagesUpdated != null:
return messagesUpdated(_that.messages);case _:
  return null;

}
}

}

/// @nodoc


class WatchMessagesEvent implements ChatEvent {
  const WatchMessagesEvent(this.productId);
  

 final  String productId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WatchMessagesEventCopyWith<WatchMessagesEvent> get copyWith => _$WatchMessagesEventCopyWithImpl<WatchMessagesEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WatchMessagesEvent&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,productId);

@override
String toString() {
  return 'ChatEvent.watchMessages(productId: $productId)';
}


}

/// @nodoc
abstract mixin class $WatchMessagesEventCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $WatchMessagesEventCopyWith(WatchMessagesEvent value, $Res Function(WatchMessagesEvent) _then) = _$WatchMessagesEventCopyWithImpl;
@useResult
$Res call({
 String productId
});




}
/// @nodoc
class _$WatchMessagesEventCopyWithImpl<$Res>
    implements $WatchMessagesEventCopyWith<$Res> {
  _$WatchMessagesEventCopyWithImpl(this._self, this._then);

  final WatchMessagesEvent _self;
  final $Res Function(WatchMessagesEvent) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? productId = null,}) {
  return _then(WatchMessagesEvent(
null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SendMessageEvent implements ChatEvent {
  const SendMessageEvent(this.text, this.productId);
  

 final  String text;
 final  String productId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SendMessageEventCopyWith<SendMessageEvent> get copyWith => _$SendMessageEventCopyWithImpl<SendMessageEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SendMessageEvent&&(identical(other.text, text) || other.text == text)&&(identical(other.productId, productId) || other.productId == productId));
}


@override
int get hashCode => Object.hash(runtimeType,text,productId);

@override
String toString() {
  return 'ChatEvent.sendMessage(text: $text, productId: $productId)';
}


}

/// @nodoc
abstract mixin class $SendMessageEventCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $SendMessageEventCopyWith(SendMessageEvent value, $Res Function(SendMessageEvent) _then) = _$SendMessageEventCopyWithImpl;
@useResult
$Res call({
 String text, String productId
});




}
/// @nodoc
class _$SendMessageEventCopyWithImpl<$Res>
    implements $SendMessageEventCopyWith<$Res> {
  _$SendMessageEventCopyWithImpl(this._self, this._then);

  final SendMessageEvent _self;
  final $Res Function(SendMessageEvent) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? text = null,Object? productId = null,}) {
  return _then(SendMessageEvent(
null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class MessagesUpdatedEvent implements ChatEvent {
  const MessagesUpdatedEvent(final  List<Message> messages): _messages = messages;
  

 final  List<Message> _messages;
 List<Message> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}


/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessagesUpdatedEventCopyWith<MessagesUpdatedEvent> get copyWith => _$MessagesUpdatedEventCopyWithImpl<MessagesUpdatedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessagesUpdatedEvent&&const DeepCollectionEquality().equals(other._messages, _messages));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_messages));

@override
String toString() {
  return 'ChatEvent.messagesUpdated(messages: $messages)';
}


}

/// @nodoc
abstract mixin class $MessagesUpdatedEventCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $MessagesUpdatedEventCopyWith(MessagesUpdatedEvent value, $Res Function(MessagesUpdatedEvent) _then) = _$MessagesUpdatedEventCopyWithImpl;
@useResult
$Res call({
 List<Message> messages
});




}
/// @nodoc
class _$MessagesUpdatedEventCopyWithImpl<$Res>
    implements $MessagesUpdatedEventCopyWith<$Res> {
  _$MessagesUpdatedEventCopyWithImpl(this._self, this._then);

  final MessagesUpdatedEvent _self;
  final $Res Function(MessagesUpdatedEvent) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? messages = null,}) {
  return _then(MessagesUpdatedEvent(
null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<Message>,
  ));
}


}

// dart format on
