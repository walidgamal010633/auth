import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:test/core/errors/failures.dart';
import 'package:test/features/auth/domain/entities/user_entity.dart';
import 'package:test/features/auth/domain/repositories/auth_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._repository) : super(RegisterInitial());
  final AuthRepository _repository;
  Future<void> register(String email, String password, String name) async {
    emit(RegisterLoading());
    final result = await _repository.CreateUserWithEmailAndPassword(
      email: email,
      password: password,
      name: name,
    );
    result.fold(
      (failure) => emit(RegisterFailure(message: failure.message)),
      (userEntity) => emit(RegisterSuccess(user: userEntity)),
    );
  }
}
