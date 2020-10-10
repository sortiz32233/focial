// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['userId'].toString(),
    firstName: json['firstName'].toString(),
    lastName: json['lastName'].toString(),
    email: json['email'].toString(),
    phone: json['phone'].toString(),
    gender: json['gender'].toString(),
    bio: json['bio'].toString(),
    username: json['username'].toString(),
    coverPic: json['coverPic'].toString(),
    age: json['age'] as int,
    location: json['location'].toString(),
    photoUrl: json['photoUrl'].toString(),
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
    posts: json['posts'] as int,
    followers: json['followers'] as int,
    following: json['following'] as int,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'userId': instance.id,
      'username': instance.username,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'coverPic': instance.coverPic,
      'email': instance.email,
      'phone': instance.phone,
      'gender': instance.gender,
      'bio': instance.bio,
      'age': instance.age,
      'location': instance.location,
      'photoUrl': instance.photoUrl,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'posts': instance.posts,
      'followers': instance.followers,
      'following': instance.following,
    };
