// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent()';
}


}

/// @nodoc
class $AuthEventCopyWith<$Res>  {
$AuthEventCopyWith(AuthEvent _, $Res Function(AuthEvent) __);
}


/// Adds pattern-matching-related methods to [AuthEvent].
extension AuthEventPatterns on AuthEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AuthCheckRequested value)?  authCheckRequested,TResult Function( LoginRequested value)?  loginRequested,TResult Function( RegisterRequested value)?  registerRequested,TResult Function( LogoutRequested value)?  logoutRequested,TResult Function( GoogleSignInRequested value)?  googleSignInRequested,TResult Function( ProfileUpdateRequested value)?  profileUpdateRequested,TResult Function( PasswordResetRequested value)?  passwordResetRequested,TResult Function( ProfileImageUpdateRequested value)?  profileImageUpdateRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AuthCheckRequested() when authCheckRequested != null:
return authCheckRequested(_that);case LoginRequested() when loginRequested != null:
return loginRequested(_that);case RegisterRequested() when registerRequested != null:
return registerRequested(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case ProfileUpdateRequested() when profileUpdateRequested != null:
return profileUpdateRequested(_that);case PasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case ProfileImageUpdateRequested() when profileImageUpdateRequested != null:
return profileImageUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AuthCheckRequested value)  authCheckRequested,required TResult Function( LoginRequested value)  loginRequested,required TResult Function( RegisterRequested value)  registerRequested,required TResult Function( LogoutRequested value)  logoutRequested,required TResult Function( GoogleSignInRequested value)  googleSignInRequested,required TResult Function( ProfileUpdateRequested value)  profileUpdateRequested,required TResult Function( PasswordResetRequested value)  passwordResetRequested,required TResult Function( ProfileImageUpdateRequested value)  profileImageUpdateRequested,}){
final _that = this;
switch (_that) {
case AuthCheckRequested():
return authCheckRequested(_that);case LoginRequested():
return loginRequested(_that);case RegisterRequested():
return registerRequested(_that);case LogoutRequested():
return logoutRequested(_that);case GoogleSignInRequested():
return googleSignInRequested(_that);case ProfileUpdateRequested():
return profileUpdateRequested(_that);case PasswordResetRequested():
return passwordResetRequested(_that);case ProfileImageUpdateRequested():
return profileImageUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AuthCheckRequested value)?  authCheckRequested,TResult? Function( LoginRequested value)?  loginRequested,TResult? Function( RegisterRequested value)?  registerRequested,TResult? Function( LogoutRequested value)?  logoutRequested,TResult? Function( GoogleSignInRequested value)?  googleSignInRequested,TResult? Function( ProfileUpdateRequested value)?  profileUpdateRequested,TResult? Function( PasswordResetRequested value)?  passwordResetRequested,TResult? Function( ProfileImageUpdateRequested value)?  profileImageUpdateRequested,}){
final _that = this;
switch (_that) {
case AuthCheckRequested() when authCheckRequested != null:
return authCheckRequested(_that);case LoginRequested() when loginRequested != null:
return loginRequested(_that);case RegisterRequested() when registerRequested != null:
return registerRequested(_that);case LogoutRequested() when logoutRequested != null:
return logoutRequested(_that);case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested(_that);case ProfileUpdateRequested() when profileUpdateRequested != null:
return profileUpdateRequested(_that);case PasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that);case ProfileImageUpdateRequested() when profileImageUpdateRequested != null:
return profileImageUpdateRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  authCheckRequested,TResult Function( String email,  String password)?  loginRequested,TResult Function( String email,  String username,  String password)?  registerRequested,TResult Function()?  logoutRequested,TResult Function()?  googleSignInRequested,TResult Function( String username)?  profileUpdateRequested,TResult Function( String email)?  passwordResetRequested,TResult Function( File image)?  profileImageUpdateRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AuthCheckRequested() when authCheckRequested != null:
return authCheckRequested();case LoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password);case RegisterRequested() when registerRequested != null:
return registerRequested(_that.email,_that.username,_that.password);case LogoutRequested() when logoutRequested != null:
return logoutRequested();case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case ProfileUpdateRequested() when profileUpdateRequested != null:
return profileUpdateRequested(_that.username);case PasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email);case ProfileImageUpdateRequested() when profileImageUpdateRequested != null:
return profileImageUpdateRequested(_that.image);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  authCheckRequested,required TResult Function( String email,  String password)  loginRequested,required TResult Function( String email,  String username,  String password)  registerRequested,required TResult Function()  logoutRequested,required TResult Function()  googleSignInRequested,required TResult Function( String username)  profileUpdateRequested,required TResult Function( String email)  passwordResetRequested,required TResult Function( File image)  profileImageUpdateRequested,}) {final _that = this;
switch (_that) {
case AuthCheckRequested():
return authCheckRequested();case LoginRequested():
return loginRequested(_that.email,_that.password);case RegisterRequested():
return registerRequested(_that.email,_that.username,_that.password);case LogoutRequested():
return logoutRequested();case GoogleSignInRequested():
return googleSignInRequested();case ProfileUpdateRequested():
return profileUpdateRequested(_that.username);case PasswordResetRequested():
return passwordResetRequested(_that.email);case ProfileImageUpdateRequested():
return profileImageUpdateRequested(_that.image);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  authCheckRequested,TResult? Function( String email,  String password)?  loginRequested,TResult? Function( String email,  String username,  String password)?  registerRequested,TResult? Function()?  logoutRequested,TResult? Function()?  googleSignInRequested,TResult? Function( String username)?  profileUpdateRequested,TResult? Function( String email)?  passwordResetRequested,TResult? Function( File image)?  profileImageUpdateRequested,}) {final _that = this;
switch (_that) {
case AuthCheckRequested() when authCheckRequested != null:
return authCheckRequested();case LoginRequested() when loginRequested != null:
return loginRequested(_that.email,_that.password);case RegisterRequested() when registerRequested != null:
return registerRequested(_that.email,_that.username,_that.password);case LogoutRequested() when logoutRequested != null:
return logoutRequested();case GoogleSignInRequested() when googleSignInRequested != null:
return googleSignInRequested();case ProfileUpdateRequested() when profileUpdateRequested != null:
return profileUpdateRequested(_that.username);case PasswordResetRequested() when passwordResetRequested != null:
return passwordResetRequested(_that.email);case ProfileImageUpdateRequested() when profileImageUpdateRequested != null:
return profileImageUpdateRequested(_that.image);case _:
  return null;

}
}

}

/// @nodoc


class AuthCheckRequested implements AuthEvent {
  const AuthCheckRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthCheckRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.authCheckRequested()';
}


}




/// @nodoc


class LoginRequested implements AuthEvent {
  const LoginRequested({required this.email, required this.password});
  

 final  String email;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginRequestedCopyWith<LoginRequested> get copyWith => _$LoginRequestedCopyWithImpl<LoginRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,password);

@override
String toString() {
  return 'AuthEvent.loginRequested(email: $email, password: $password)';
}


}

/// @nodoc
abstract mixin class $LoginRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $LoginRequestedCopyWith(LoginRequested value, $Res Function(LoginRequested) _then) = _$LoginRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String password
});




}
/// @nodoc
class _$LoginRequestedCopyWithImpl<$Res>
    implements $LoginRequestedCopyWith<$Res> {
  _$LoginRequestedCopyWithImpl(this._self, this._then);

  final LoginRequested _self;
  final $Res Function(LoginRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? password = null,}) {
  return _then(LoginRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class RegisterRequested implements AuthEvent {
  const RegisterRequested({required this.email, required this.username, required this.password});
  

 final  String email;
 final  String username;
 final  String password;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RegisterRequestedCopyWith<RegisterRequested> get copyWith => _$RegisterRequestedCopyWithImpl<RegisterRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RegisterRequested&&(identical(other.email, email) || other.email == email)&&(identical(other.username, username) || other.username == username)&&(identical(other.password, password) || other.password == password));
}


@override
int get hashCode => Object.hash(runtimeType,email,username,password);

@override
String toString() {
  return 'AuthEvent.registerRequested(email: $email, username: $username, password: $password)';
}


}

/// @nodoc
abstract mixin class $RegisterRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $RegisterRequestedCopyWith(RegisterRequested value, $Res Function(RegisterRequested) _then) = _$RegisterRequestedCopyWithImpl;
@useResult
$Res call({
 String email, String username, String password
});




}
/// @nodoc
class _$RegisterRequestedCopyWithImpl<$Res>
    implements $RegisterRequestedCopyWith<$Res> {
  _$RegisterRequestedCopyWithImpl(this._self, this._then);

  final RegisterRequested _self;
  final $Res Function(RegisterRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? username = null,Object? password = null,}) {
  return _then(RegisterRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LogoutRequested implements AuthEvent {
  const LogoutRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LogoutRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.logoutRequested()';
}


}




/// @nodoc


class GoogleSignInRequested implements AuthEvent {
  const GoogleSignInRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoogleSignInRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthEvent.googleSignInRequested()';
}


}




/// @nodoc


class ProfileUpdateRequested implements AuthEvent {
  const ProfileUpdateRequested({required this.username});
  

 final  String username;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateRequestedCopyWith<ProfileUpdateRequested> get copyWith => _$ProfileUpdateRequestedCopyWithImpl<ProfileUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdateRequested&&(identical(other.username, username) || other.username == username));
}


@override
int get hashCode => Object.hash(runtimeType,username);

@override
String toString() {
  return 'AuthEvent.profileUpdateRequested(username: $username)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $ProfileUpdateRequestedCopyWith(ProfileUpdateRequested value, $Res Function(ProfileUpdateRequested) _then) = _$ProfileUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 String username
});




}
/// @nodoc
class _$ProfileUpdateRequestedCopyWithImpl<$Res>
    implements $ProfileUpdateRequestedCopyWith<$Res> {
  _$ProfileUpdateRequestedCopyWithImpl(this._self, this._then);

  final ProfileUpdateRequested _self;
  final $Res Function(ProfileUpdateRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? username = null,}) {
  return _then(ProfileUpdateRequested(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class PasswordResetRequested implements AuthEvent {
  const PasswordResetRequested({required this.email});
  

 final  String email;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PasswordResetRequestedCopyWith<PasswordResetRequested> get copyWith => _$PasswordResetRequestedCopyWithImpl<PasswordResetRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PasswordResetRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'AuthEvent.passwordResetRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $PasswordResetRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $PasswordResetRequestedCopyWith(PasswordResetRequested value, $Res Function(PasswordResetRequested) _then) = _$PasswordResetRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$PasswordResetRequestedCopyWithImpl<$Res>
    implements $PasswordResetRequestedCopyWith<$Res> {
  _$PasswordResetRequestedCopyWithImpl(this._self, this._then);

  final PasswordResetRequested _self;
  final $Res Function(PasswordResetRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(PasswordResetRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProfileImageUpdateRequested implements AuthEvent {
  const ProfileImageUpdateRequested({required this.image});
  

 final  File image;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileImageUpdateRequestedCopyWith<ProfileImageUpdateRequested> get copyWith => _$ProfileImageUpdateRequestedCopyWithImpl<ProfileImageUpdateRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileImageUpdateRequested&&(identical(other.image, image) || other.image == image));
}


@override
int get hashCode => Object.hash(runtimeType,image);

@override
String toString() {
  return 'AuthEvent.profileImageUpdateRequested(image: $image)';
}


}

/// @nodoc
abstract mixin class $ProfileImageUpdateRequestedCopyWith<$Res> implements $AuthEventCopyWith<$Res> {
  factory $ProfileImageUpdateRequestedCopyWith(ProfileImageUpdateRequested value, $Res Function(ProfileImageUpdateRequested) _then) = _$ProfileImageUpdateRequestedCopyWithImpl;
@useResult
$Res call({
 File image
});




}
/// @nodoc
class _$ProfileImageUpdateRequestedCopyWithImpl<$Res>
    implements $ProfileImageUpdateRequestedCopyWith<$Res> {
  _$ProfileImageUpdateRequestedCopyWithImpl(this._self, this._then);

  final ProfileImageUpdateRequested _self;
  final $Res Function(ProfileImageUpdateRequested) _then;

/// Create a copy of AuthEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? image = null,}) {
  return _then(ProfileImageUpdateRequested(
image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

// dart format on
