import 'package:dartz/dartz.dart';
import 'package:test/core/errors/exception.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/core/service/firebase_auth_service.dart';
import 'package:test/features/auth/data/mapper/user_mapper.dart';
import 'package:test/features/auth/domain/entities/user_entity.dart';
import 'package:test/features/auth/domain/repositories/auth_repository.dart';

class AuthRepoImp extends AuthRepository {
  final FirebaseAuthService _authService;
  final UserMapper _mapper;
  AuthRepoImp(this._authService, this._mapper);

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      var users = await _authService.createUserWithEmailAndPassword(
        fullName: name,
        email: email,
        password: password,
      );
print("===============================================");
print(users);
      return right(_mapper.mapToEntity(users));
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure("there was an error "));
    }
  }

  Future<Either<Failure, UserEntity>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      var users = await _authService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      print("===============================================");
      print(users);
      return right(_mapper.mapToEntity(users));
      
    } on CustomException catch (e) {
      return left(ServerFailure(e.message));
    } catch (e) {
      return left(ServerFailure("there was an error , please try again"));
    }
  }
}
