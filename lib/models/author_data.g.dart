// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'author_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorData _$AuthorDataFromJson(Map<String, dynamic> json) {
  return AuthorData(
    id: json['userId'].toString(),
    photoUrl: json['photoUrl'].toString(),
    username: json['username'].toString(),
  );
}

Map<String, dynamic> _$AuthorDataToJson(AuthorData instance) => <String, dynamic>{
      'userId': instance.id,
      'photoUrl': instance.photoUrl,
      'username': instance.username,
    };
