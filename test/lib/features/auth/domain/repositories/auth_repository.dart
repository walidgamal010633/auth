import 'package:dartz/dartz.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> CreateUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
}
