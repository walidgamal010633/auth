

import 'package:firebase_auth/firebase_auth.dart';
import 'package:test/features/auth/data/models/user_model.dart';
import 'package:test/features/auth/domain/entities/user_entity.dart';

class UserMapper {
   UserEntity mapToEntity(User model) {
    return UserEntity(
      name: model.displayName,
      email: model.email,
      uId: model.uid,
    );
  }
}